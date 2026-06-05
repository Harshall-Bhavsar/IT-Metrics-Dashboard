# Project Status — IT Metrics Dashboard

**Author:** Harshall Bhavsar
**Project Type:** Business Analysis Portfolio
**Started:** Week 1 | **Target Completion:** Week 3

---

## Overall Progress

```
Week 1 — Foundation        ████████████ 100% Complete
Week 2 — Process & Design  ████████████ 100% Complete
Week 3 — Build & Deliver   ████████░░░░  75% In Progress
```

---

## Week 1 — Foundation ✅

**Goal:** Define the problem, document requirements, generate sample data.

| Deliverable | File | Status |
|------------|------|--------|
| Business Requirements Document | [01_BRD/01_Business_Requirements_Document.pdf](01_BRD/01_Business_Requirements_Document.pdf) | ✅ Done |
| User Stories (10 stories, 31 pts) | [02_User_Stories/02_User_Stories.pdf](02_User_Stories/02_User_Stories.pdf) | ✅ Done |

**Key Outputs:**
- Enterprise-grade BRD with ROI analysis
- 10 user stories with acceptance criteria
- KPI targets defined: 7h MTTR, 95% SLA compliance

---

## Week 2 — Process & Design ✅

**Goal:** Map ITIL processes, design system architecture.

| Deliverable | File | Status |
|------------|------|--------|
| Process Maps Master Index | [03_Process_Maps/00_Process_Maps_Index.md](03_Process_Maps/00_Process_Maps_Index.md) | ✅ Done |
| Incident Management Process | [03_Process_Maps/01_Incident_Management_Process.md](03_Process_Maps/01_Incident_Management_Process.md) | ✅ Done |
| Problem Management Process | [03_Process_Maps/02_Problem_Management_Process.md](03_Process_Maps/02_Problem_Management_Process.md) | ✅ Done |
| Change Management Process | [03_Process_Maps/03_Change_Management_Process.md](03_Process_Maps/03_Change_Management_Process.md) | ✅ Done |
| System Architecture | [04_System_Architecture/04_System_Architecture.md](04_System_Architecture/04_System_Architecture.md) | ✅ Done |

**Key Outputs:**
- As-Is → To-Be maps for 3 ITIL processes
- Gap analysis per process
- 3-layer system architecture document

---

## Week 3 — Build & Deliver 🔄

**Goal:** Build SQL analysis, live dashboard, analysis report, presentation, case study.

| Deliverable | File | Status |
|------------|------|--------|
| SQL Schema | [05_SQL_Analysis/schema.sql](05_SQL_Analysis/schema.sql) | ✅ Done |
| Incident Analysis Queries | [05_SQL_Analysis/incident_queries.sql](05_SQL_Analysis/incident_queries.sql) | ✅ Done |
| Sample Data | [05_SQL_Analysis/sample_incidents.csv](05_SQL_Analysis/sample_incidents.csv) | ✅ Done |
| Live KPI Dashboard | [06_Dashboard/index.html](06_Dashboard/index.html) | ✅ Done |
| Incident Analysis Report | [07_Analysis_Report/analysis_report.txt](07_Analysis_Report/analysis_report.txt) | ✅ Done |
| Stakeholder Presentation | 08_Presentation/ | 🔄 Day 11 |
| Case Study Narrative | CASE_STUDY.md | 🔄 Day 12 |

---

## KPI Results (From SQL Server Analysis)

| Metric | Baseline | Target | Current | Gap |
|--------|---------|--------|---------|-----|
| Overall SLA | 82.0% | 95.0% | 84.0% | -11.0pts |
| P1 SLA | — | 95.0% | 54.2% | -40.8pts |
| P2 SLA | — | 95.0% | 36.4% | -58.6pts |
| Server SLA | — | 95.0% | 71.9% | -23.1pts |
| Database SLA | — | 95.0% | 75.0% | -20.0pts |

---

## Technology Decisions Log

| Decision | Rationale |
|---------|-----------|
| SQL Server over Python | Enterprise ITSM standard, better BA skill signal |
| HTML dashboard (no framework) | Zero dependencies, opens in browser without server |
| PDFs for BRD and User Stories | Preserves formatting for recruiter viewing |
| Markdown for process maps | GitHub native Mermaid diagram rendering |

---

*Last updated: Week 3 — Day 10 complete*
