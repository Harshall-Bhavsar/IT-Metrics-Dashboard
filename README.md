# IT Metrics Dashboard
**Business Analysis Portfolio Project**


Author: Harshal Bhavsar | Business Analyst | ITSM | ITIL | ServiceNow

🔴 **[Live Dashboard →](https://harshall-bhavsar.github.io/IT-Metrics-Dashboard/06_Dashboard/index.html)**

---

## Project Summary

An end-to-end Business Analysis portfolio project for a 250-person IT services company struggling with manual reporting, poor SLA visibility, and reactive incident management.

This project covers the full BA lifecycle: problem definition, requirements gathering, process mapping, system design, SQL analysis, and live dashboard delivery.

---

## Business Problem

| Pain Point | Impact |
|-----------|--------|
| Manual Excel reporting | 6-8 hours/week wasted |
| No real-time SLA visibility | Breaches discovered after the fact |
| Inconsistent incident priority assignment | Wrong engineers on wrong tickets |
| No root cause tracking | Same incidents recurring month after month |
| No change success rate measurement | Change-induced incidents undetected |

---

## Proposed Solution

A real-time IT Metrics Dashboard integrating with the ticketing system to provide live KPI visibility, automated SLA alerting, and structured reporting — eliminating manual reporting entirely.

---

## Business Impact (From BRD)

```
MTTR:              10.2h  →  7.0h      (31% improvement target)
SLA Compliance:     82%   →  95%+      (+13 points target)
Reporting Time:    6-8h/week → 30 min  (95% reduction)
ROI:               4-5 month payback
Annual Benefit:    $135,000+
```

---

## Repository Structure

```
IT-Metrics-Dashboard/
│
├── README.md
├── PROJECT_STATUS.md
│
├── 01_BRD/
│   └── 01_Business_Requirements_Document.pdf
│
├── 02_User_Stories/
│   └── 02_User_Stories.pdf
│
├── 03_Process_Maps/
│   ├── 00_Process_Maps_Index.md
│   ├── 01_Incident_Management_Process.md
│   ├── 02_Problem_Management_Process.md
│   └── 03_Change_Management_Process.md
│
├── 04_System_Architecture/
│   └── 04_System_Architecture.md
│
├── 05_SQL_Analysis/
│   ├── schema.sql
│   ├── incident_queries.sql
│   └── sample_incidents.csv
│
├── 06_Dashboard/
│   └── index.html
│
└── 07_Analysis_Report/
    └── analysis_report.txt
```

---

## Project Deliverables

| # | Deliverable | Status | Link |
|---|------------|--------|------|
| 1 | Business Requirements Document | ✅ Complete | [View BRD](01_BRD/01_Business_Requirements_Document.pdf) |
| 2 | User Stories (10 stories, 31 pts) | ✅ Complete | [View User Stories](02_User_Stories/02_User_Stories.pdf) |
| 3 | Incident Management Process Map | ✅ Complete | [View](03_Process_Maps/01_Incident_Management_Process.md) |
| 4 | Problem Management Process Map | ✅ Complete | [View](03_Process_Maps/02_Problem_Management_Process.md) |
| 5 | Change Management Process Map | ✅ Complete | [View](03_Process_Maps/03_Change_Management_Process.md) |
| 6 | Process Maps Master Index | ✅ Complete | [View](03_Process_Maps/00_Process_Maps_Index.md) |
| 7 | System Architecture Document | ✅ Complete | [View](04_System_Architecture/04_System_Architecture.md) |
| 8 | SQL Schema + Analysis Queries | ✅ Complete | [View](05_SQL_Analysis/incident_queries.sql) |
| 9 | Live KPI Dashboard | ✅ Complete | [View](06_Dashboard/index.html) |
| 10 | Incident Analysis Report | ✅ Complete | [View](07_Analysis_Report/analysis_report.txt) |
| 11 | Stakeholder Presentation | 🔄 In Progress | Coming Day 11 |
| 12 | Case Study Narrative | 🔄 In Progress | Coming Day 12 |

---

## Key Findings (From SQL Analysis)

| Metric | Baseline | Current | Target | Gap |
|--------|---------|---------|--------|-----|
| Overall SLA Compliance | 82.0% | 84.0% | 95.0% | -11.0pts |
| P1 SLA Compliance | — | 54.2% | 95.0% | -40.8pts |
| P2 SLA Compliance | — | 36.4% | 95.0% | -58.6pts |
| Server Category SLA | — | 71.9% | 95.0% | -23.1pts |
| Database Category SLA | — | 75.0% | 95.0% | -20.0pts |

---

## ITIL Processes Covered

| Process | As-Is Maturity | To-Be Maturity |
|---------|---------------|----------------|
| Incident Management | Level 1 — Ad hoc | Level 4 — Managed |
| Problem Management | Level 0 — None | Level 3 — Defined |
| Change Management | Level 0 — None | Level 4 — Managed |

---

## Technology Stack

| Component | Technology |
|-----------|-----------|
| Database | SQL Server 2025 |
| Query Tool | SSMS 22 |
| Dashboard | HTML / CSS / JS / Chart.js |
| Documentation | Markdown + PDF |

---

## Skills Demonstrated

- Business Requirements Documentation (BRD)
- User Story writing with acceptance criteria
- As-Is / To-Be process mapping
- Gap analysis and pain point identification
- ITIL v4 process alignment
- System architecture design (BA-level)
- SQL Server — schema design and analytical queries
- KPI definition and metrics analysis
- Stakeholder perspective mapping
- ROI and business case analysis

---

## How to Run the SQL Analysis

```sql
-- 1. Restore schema
-- Run schema.sql in SSMS to create the database and table

-- 2. Import data
BULK INSERT dbo.incidents
FROM 'your_path\sample_incidents.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);

-- 3. Run analysis
-- Open incident_queries.sql and execute section by section
```

---

## Author

**Harshall Bhavsar**  
Business Analyst | ITSM | ITIL | ServiceNow | Digital Transformation  
[https://www.linkedin.com/in/iamharshalbhavsar/] | [harshal.bhavsar16@gmail.com]
