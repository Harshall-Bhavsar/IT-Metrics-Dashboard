-- ============================================================
-- IT Metrics Dashboard — Incident Analysis Queries
-- Author: Harshall Bhavsar | Business Analyst Portfolio
-- Database: ITMetricsDashboard
-- Tool: SQL Server (T-SQL)
-- ============================================================
-- BRD Targets:
--   MTTR Target        : 7.0 hours
--   SLA Compliance     : 95%+
--   Baseline MTTR      : 10.2 hours
--   Baseline SLA       : 82%
-- ============================================================

USE ITMetricsDashboard;
GO


-- ============================================================
-- SECTION 1: OVERALL KPIs
-- ============================================================

-- Query 1.1 — Overall MTTR and SLA Compliance
-- Purpose: Measure top-level performance against BRD targets
SELECT
    COUNT(*)                                                    AS total_incidents,
    CAST(AVG(mttr_hours) AS DECIMAL(6,1))                       AS avg_mttr_hours,
    7.0                                                         AS mttr_target_hours,
    CAST(AVG(mttr_hours) - 7.0 AS DECIMAL(6,1))                AS mttr_gap_vs_target,
    CAST(10.2 - AVG(mttr_hours) AS DECIMAL(6,1))               AS mttr_improvement_vs_baseline,
    COUNT(CASE WHEN sla_met = 'Yes' THEN 1 END)                AS sla_met_count,
    COUNT(CASE WHEN sla_met = 'No'  THEN 1 END)                AS sla_breach_count,
    CAST(
        COUNT(CASE WHEN sla_met = 'Yes' THEN 1 END) * 100.0
        / COUNT(*)
    AS DECIMAL(5,1))                                           AS sla_compliance_pct,
    95.0                                                        AS sla_target_pct
FROM dbo.incidents;
GO


-- Query 1.2 — KPI Status vs BRD Targets
-- Purpose: Simple pass/fail view for stakeholder reporting
SELECT
    'MTTR'          AS kpi,
    CAST(AVG(mttr_hours) AS DECIMAL(6,1))   AS current_value,
    7.0                                      AS target,
    CASE WHEN AVG(mttr_hours) <= 7.0
         THEN 'TARGET MET' ELSE 'BELOW TARGET' END AS status
FROM dbo.incidents
UNION ALL
SELECT
    'SLA Compliance' AS kpi,
    CAST(COUNT(CASE WHEN sla_met = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS DECIMAL(5,1)),
    95.0,
    CASE WHEN COUNT(CASE WHEN sla_met = 'Yes' THEN 1 END) * 100.0 / COUNT(*) >= 95.0
         THEN 'TARGET MET' ELSE 'BELOW TARGET' END
FROM dbo.incidents;
GO


-- ============================================================
-- SECTION 2: BREAKDOWN BY PRIORITY
-- ============================================================

-- Query 2.1 — Incident Volume, MTTR, and SLA by Priority
-- Purpose: Identify which priority tier is driving breaches
SELECT
    priority,
    COUNT(*)                                                    AS incident_count,
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS DECIMAL(5,1)) AS pct_of_total,
    CAST(AVG(mttr_hours) AS DECIMAL(6,1))                       AS avg_mttr_hours,
    CAST(MIN(mttr_hours) AS DECIMAL(6,1))                       AS min_mttr_hours,
    CAST(MAX(mttr_hours) AS DECIMAL(6,1))                       AS max_mttr_hours,
    COUNT(CASE WHEN sla_met = 'Yes' THEN 1 END)                AS sla_met,
    COUNT(CASE WHEN sla_met = 'No'  THEN 1 END)                AS sla_breached,
    CAST(
        COUNT(CASE WHEN sla_met = 'Yes' THEN 1 END) * 100.0
        / COUNT(*)
    AS DECIMAL(5,1))                                           AS sla_compliance_pct,
    MAX(sla_target_hours)                                       AS sla_target_hours
FROM dbo.incidents
GROUP BY priority
ORDER BY priority;
GO


-- Query 2.2 — P1 Critical Incidents Detail
-- Purpose: Executive view of highest-impact incidents
SELECT
    incident_id,
    title,
    category,
    assigned_to,
    created_at,
    resolved_at,
    mttr_hours,
    sla_met,
    CASE WHEN sla_met = 'No' THEN mttr_hours - sla_target_hours ELSE 0 END AS breach_overage_hours
FROM dbo.incidents
WHERE priority = 'P1'
ORDER BY mttr_hours DESC;
GO


-- ============================================================
-- SECTION 3: BREAKDOWN BY CATEGORY
-- ============================================================

-- Query 3.1 — Volume and MTTR by Category
-- Purpose: Identify which service areas have the most incidents and longest resolution times
SELECT
    category,
    COUNT(*)                                                    AS incident_count,
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS DECIMAL(5,1)) AS pct_of_total,
    CAST(AVG(mttr_hours) AS DECIMAL(6,1))                       AS avg_mttr_hours,
    COUNT(CASE WHEN sla_met = 'No' THEN 1 END)                 AS sla_breaches,
    CAST(
        COUNT(CASE WHEN sla_met = 'Yes' THEN 1 END) * 100.0
        / COUNT(*)
    AS DECIMAL(5,1))                                           AS sla_compliance_pct
FROM dbo.incidents
GROUP BY category
ORDER BY incident_count DESC;
GO


-- Query 3.2 — Category x Priority Heat Map
-- Purpose: Find which category/priority combinations are most problematic
SELECT
    category,
    COUNT(CASE WHEN priority = 'P1' THEN 1 END)    AS P1,
    COUNT(CASE WHEN priority = 'P2' THEN 1 END)    AS P2,
    COUNT(CASE WHEN priority = 'P3' THEN 1 END)    AS P3,
    COUNT(CASE WHEN priority = 'P4' THEN 1 END)    AS P4,
    COUNT(*)                                        AS total
FROM dbo.incidents
GROUP BY category
ORDER BY total DESC;
GO


-- ============================================================
-- SECTION 4: ENGINEER PERFORMANCE
-- ============================================================

-- Query 4.1 — Workload and Performance by Engineer
-- Purpose: Identify overloaded engineers and resolution quality
SELECT
    assigned_to,
    COUNT(*)                                                    AS total_assigned,
    CAST(AVG(mttr_hours) AS DECIMAL(6,1))                       AS avg_mttr_hours,
    COUNT(CASE WHEN sla_met = 'Yes' THEN 1 END)                AS sla_met,
    COUNT(CASE WHEN sla_met = 'No'  THEN 1 END)                AS sla_breached,
    CAST(
        COUNT(CASE WHEN sla_met = 'Yes' THEN 1 END) * 100.0
        / COUNT(*)
    AS DECIMAL(5,1))                                           AS sla_compliance_pct,
    COUNT(CASE WHEN priority = 'P1' THEN 1 END)               AS p1_count,
    COUNT(CASE WHEN priority = 'P2' THEN 1 END)               AS p2_count
FROM dbo.incidents
GROUP BY assigned_to
ORDER BY total_assigned DESC;
GO


-- Query 4.2 — Engineers with SLA Compliance Below 85%
-- Purpose: Flag engineers who may need support or training
SELECT
    assigned_to,
    COUNT(*)                                                    AS total_assigned,
    CAST(AVG(mttr_hours) AS DECIMAL(6,1))                       AS avg_mttr_hours,
    CAST(
        COUNT(CASE WHEN sla_met = 'Yes' THEN 1 END) * 100.0
        / COUNT(*)
    AS DECIMAL(5,1))                                           AS sla_compliance_pct
FROM dbo.incidents
GROUP BY assigned_to
HAVING COUNT(CASE WHEN sla_met = 'Yes' THEN 1 END) * 100.0 / COUNT(*) < 85.0
ORDER BY sla_compliance_pct ASC;
GO


-- ============================================================
-- SECTION 5: SLA BREACH ANALYSIS
-- ============================================================

-- Query 5.1 — All SLA Breaches with Overage
-- Purpose: Detailed breach log for root cause investigation
SELECT
    incident_id,
    title,
    category,
    priority,
    assigned_to,
    mttr_hours,
    sla_target_hours,
    CAST(mttr_hours - sla_target_hours AS DECIMAL(6,1))        AS breach_by_hours,
    created_at,
    resolved_at
FROM dbo.incidents
WHERE sla_met = 'No'
ORDER BY breach_by_hours DESC;
GO


-- Query 5.2 — SLA Breach Rate by Priority and Category
-- Purpose: Cross-dimensional breach analysis
SELECT
    priority,
    category,
    COUNT(*)                                                    AS total,
    COUNT(CASE WHEN sla_met = 'No' THEN 1 END)                 AS breaches,
    CAST(
        COUNT(CASE WHEN sla_met = 'No' THEN 1 END) * 100.0
        / COUNT(*)
    AS DECIMAL(5,1))                                           AS breach_rate_pct
FROM dbo.incidents
GROUP BY priority, category
HAVING COUNT(CASE WHEN sla_met = 'No' THEN 1 END) > 0
ORDER BY breach_rate_pct DESC;
GO


-- ============================================================
-- SECTION 6: TREND ANALYSIS
-- ============================================================

-- Query 6.1 — Monthly Incident Volume and MTTR Trend
-- Purpose: Track improvement over time
SELECT
    FORMAT(created_at, 'yyyy-MM')                              AS month,
    COUNT(*)                                                    AS incident_count,
    CAST(AVG(mttr_hours) AS DECIMAL(6,1))                       AS avg_mttr_hours,
    COUNT(CASE WHEN sla_met = 'No' THEN 1 END)                 AS sla_breaches,
    CAST(
        COUNT(CASE WHEN sla_met = 'Yes' THEN 1 END) * 100.0
        / COUNT(*)
    AS DECIMAL(5,1))                                           AS sla_compliance_pct
FROM dbo.incidents
GROUP BY FORMAT(created_at, 'yyyy-MM')
ORDER BY month;
GO


-- Query 6.2 — Weekly Incident Volume
-- Purpose: Spot recurring patterns or peak periods
SELECT
    DATEPART(YEAR, created_at)                                  AS year,
    DATEPART(WEEK, created_at)                                  AS week_number,
    COUNT(*)                                                    AS incident_count,
    CAST(AVG(mttr_hours) AS DECIMAL(6,1))                       AS avg_mttr_hours
FROM dbo.incidents
GROUP BY DATEPART(YEAR, created_at), DATEPART(WEEK, created_at)
ORDER BY year, week_number;
GO


-- ============================================================
-- SECTION 7: EXECUTIVE SUMMARY VIEW
-- ============================================================

-- Query 7.1 — Create Summary View for Dashboard Reporting
-- Purpose: Reusable view for stakeholder dashboards
IF OBJECT_ID('dbo.vw_incident_summary', 'V') IS NOT NULL
    DROP VIEW dbo.vw_incident_summary;
GO

CREATE VIEW dbo.vw_incident_summary AS
SELECT
    COUNT(*)                                                    AS total_incidents,
    CAST(AVG(mttr_hours) AS DECIMAL(6,1))                       AS avg_mttr_hours,
    CAST(
        COUNT(CASE WHEN sla_met = 'Yes' THEN 1 END) * 100.0
        / COUNT(*)
    AS DECIMAL(5,1))                                           AS sla_compliance_pct,
    COUNT(CASE WHEN sla_met = 'No' THEN 1 END)                 AS total_breaches,
    COUNT(CASE WHEN priority = 'P1' THEN 1 END)               AS p1_count,
    COUNT(CASE WHEN priority = 'P2' THEN 1 END)               AS p2_count,
    COUNT(CASE WHEN status = 'Resolved' OR status = 'Closed' THEN 1 END) AS resolved_count
FROM dbo.incidents;
GO

-- Use the view
SELECT * FROM dbo.vw_incident_summary;
GO
