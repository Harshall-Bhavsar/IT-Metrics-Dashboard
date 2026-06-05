# IT Metrics Dashboard — System Architecture
**Author:** Harshall Bhavsar | Business Analyst  
**Project:** IT Metrics Dashboard Portfolio  
**Version:** 1.0  

---

## Overview

This document describes the system architecture for the IT Metrics Dashboard — a real-time ITSM reporting solution for a 250-person IT services company. The architecture follows a 3-layer design: Data Sources → Processing → Presentation.

The solution eliminates manual Excel reporting (6-8 hours/week) and replaces it with automated, real-time KPI visibility across Incident, Problem, and Change Management processes.

---

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    LAYER 1 — DATA SOURCES                   │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   ┌─────────────┐   ┌─────────────┐   ┌─────────────┐       │
│   │  Ticketing  │   │    CMDB     │   │   Change    │       │
│   │   System    │   │  (Assets)   │   │  Records    │       │
│   │ (ServiceNow)│   │             │   │             │       │
│   └──────┬──────┘   └──────┬──────┘   └──────┬──────┘       │
│          │                 │                  │             │
└──────────┼─────────────────┼──────────────────┼─────────────┘
           │                 │                  │
           ▼                 ▼                  ▼
┌─────────────────────────────────────────────────────────────┐
│                   LAYER 2 — PROCESSING                      │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   ┌──────────────────────────────────────────────────┐      │
│   │              SQL Server Database                 │      │
│   │           (ITMetricsDashboard)                   │      │
│   │                                                  │      │
│   │   ┌──────────────┐    ┌──────────────────────┐   │      │
│   │   │ dbo.incidents│    │ Analytical Queries   │   │      │
│   │   │ (200 rows)   │──▶│ - KPI Calculation    │   │      │
│   │   │              │    │ - Priority Analysis  │   │      │
│   │   └──────────────┘    │ - Category Breakdown │   │      │
│   │                       │ - Engineer Metrics   │   │      │
│   │                       │ - SLA Breach Analysis│   │      │
│   │                       │ - Trend Analysis     │   │      │
│   │                       └──────────────────────┘   │      │
│   └──────────────────────────────────────────────────┘      │
│                                                             │
└─────────────────────────────────────────────────────────────┘
           │                 │                  │
           ▼                 ▼                  ▼
┌─────────────────────────────────────────────────────────────┐
│                  LAYER 3 — PRESENTATION                     │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   ┌─────────────┐   ┌─────────────┐   ┌─────────────┐       │
│   │    Live     │   │  Analysis   │   │ Stakeholder │       │
│   │  Dashboard  │   │   Report    │   │Presentation │       │
│   │ (index.html)│   │  (.txt)     │   │  (.pptx)    │       │
│   └─────────────┘   └─────────────┘   └─────────────┘       │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## Layer 1 — Data Sources

### 1.1 Ticketing System (ServiceNow)
The primary data source. Captures all incident lifecycle data including creation, assignment, resolution, and closure timestamps.

| Field | Description |
|-------|-------------|
| incident_id | Unique incident identifier (INC-XXXX) |
| title | Incident description |
| category | Service category (Network, Database, etc.) |
| priority | Business impact level (P1–P4) |
| assigned_to | Responsible engineer |
| created_at | Incident creation timestamp |
| resolved_at | Resolution timestamp |
| mttr_hours | Calculated resolution time in hours |
| sla_target_hours | SLA threshold for the priority level |
| sla_met | Whether SLA was met (Yes/No) |
| status | Current state (Resolved/Closed) |

### 1.2 CMDB (Configuration Management Database)
Stores asset and configuration item records. Links incidents to affected infrastructure components — servers, network devices, applications. Enables impact analysis and root cause correlation.

### 1.3 Change Records
Tracks all planned changes to the IT environment. Linking change records to incident records allows identification of change-induced failures — incidents that occurred as a direct result of a change activity.

---

## Layer 2 — Processing

### 2.1 Database — SQL Server 2025
**Instance:** localhost\MSSQLSERVER  
**Database:** ITMetricsDashboard  
**Table:** dbo.incidents  

SQL Server serves as the analytical engine for this solution. All KPI calculations, breakdowns, and trend analysis are performed via T-SQL queries against the incidents table.

### 2.2 Analytical Query Modules

| Module | Purpose |
|--------|---------|
| Overall KPIs | MTTR average, SLA compliance rate, breach count |
| Priority Analysis | Performance breakdown by P1–P4 |
| Category Analysis | Volume and SLA compliance by service category |
| Engineer Metrics | Workload distribution and individual SLA performance |
| SLA Breach Log | Detailed breach records with overage hours |
| Trend Analysis | Monthly and weekly incident volume and MTTR trends |
| Executive View | Summary view for stakeholder reporting |

### 2.3 KPI Definitions

| KPI | Formula | Target |
|-----|---------|--------|
| MTTR | AVG(resolved_at - created_at) in hours | ≤ 7.0h |
| SLA Compliance | (SLA Met / Total) × 100 | ≥ 95% |
| Breach Rate | (Breaches / Total) × 100 | ≤ 5% |
| P1 Resolution | AVG(mttr_hours) WHERE priority = P1 | ≤ 4.0h |
| P2 Resolution | AVG(mttr_hours) WHERE priority = P2 | ≤ 8.0h |

---

## Layer 3 — Presentation

### 3.1 Live KPI Dashboard (index.html)
A self-contained HTML/CSS/JS dashboard that renders directly in any browser without a server or framework.

**Components:**
- 4 KPI cards: MTTR, SLA Compliance, Total Incidents, Breach Count
- Category volume bar chart
- MTTR by priority bar chart
- Priority breakdown table with progress bars
- SLA compliance donut chart
- CSV upload for custom data input

**Data source:** Hardcoded from SQL query outputs by default. Supports live CSV upload for updated datasets.

### 3.2 Analysis Report (analysis_report.txt)
A structured BA-level report covering overall KPIs, priority findings, category findings, engineer performance, root cause analysis, recommendations, and gap analysis. Written for an IT Manager or CIO audience.

### 3.3 Stakeholder Presentation
An 8-10 slide deck covering executive summary, business problem, methodology, key findings, recommendations, and ROI. Designed for non-technical leadership audiences.

---

## Data Flow

```
ServiceNow Export (CSV)
        │
        ▼
BULK INSERT into SQL Server
        │
        ▼
T-SQL Analytical Queries
        │
        ├──▶ Dashboard (index.html)
        ├──▶ Analysis Report (analysis_report.txt)
        └──▶ Stakeholder Presentation
```

---

## Technology Stack

| Component | Technology | Rationale |
|-----------|-----------|-----------|
| Database | SQL Server 2025 | Enterprise ITSM standard |
| Query Tool | SSMS 22 | Industry standard SQL IDE |
| Dashboard | HTML / CSS / JS / Chart.js | Zero dependencies, browser native |
| Documentation | Markdown | GitHub native rendering |
| Reporting | Plain text (.txt) | Portable, PDF-convertible |

---

## Security Considerations (BA-Level)

| Concern | Recommendation |
|---------|---------------|
| Data access | Role-based access — engineers see own tickets only |
| Dashboard access | Internal network only, no public exposure |
| PII in incidents | Engineer names anonymised in external reporting |
| Audit trail | All query executions logged via SQL Server Audit |

---

## Assumptions and Constraints

| Item | Detail |
|------|--------|
| Data source | CSV export from ServiceNow (simulated for portfolio) |
| Refresh frequency | Daily batch import for current implementation |
| Real-time target | API integration with ServiceNow for live feed |
| Users | IT Manager, Service Desk Lead, Engineers |
| Browser support | Chrome, Edge, Firefox (modern versions) |

---

*Document version 1.0 — IT Metrics Dashboard Portfolio*  
*Author: Harshall Bhavsar | github.com/Harshall-Bhavsar/IT-Metrics-Dashboard*
