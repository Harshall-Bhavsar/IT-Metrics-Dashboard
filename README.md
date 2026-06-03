# IT Metrics Dashboard
**Business Analysis Portfolio Project**  
Author: Harshall Bhavsar | Business Analyst | ITSM | ITIL | ServiceNow

---

## Project Summary

A end-to-end Business Analysis portfolio project for a 250-person IT services company struggling with manual reporting, poor SLA visibility, and reactive incident management.

This project covers the full BA lifecycle: problem definition, requirements gathering, process mapping, system design, and proof-of-concept scripting.

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
MTTR:              10.2h  →  7.0h      (31% improvement)
SLA Compliance:     82%   →  95%+      (+13 points)
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
│
├── BRD/
│   └── 01_Business_Requirements_Document      # 3,500+ line enterprise-grade BRD
│
├── 02_User_Stories/
│   └── User_Stories                           # 10 user stories, 31 story points, acceptance criteria
│
├── 03_Process_Maps/
│   ├── 00_PROCESS_MAPS_INDEX                  # Master index + cross-process summary
│   ├── 01_Incident_Management_Process         # As-Is → To-Be with gap analysis
│   ├── 02_Problem_Management_Process          # Includes KEDB structure design
│   └── 03_Change_Management_Process           # Includes CAB charter
│
├── 04_System_Architecture/
│   └── 04_System_Architecture                 # 3-layer architecture with data flow narrative
│
├── 05_Python_Analysis/
│   ├── analyze_incidents.py                   # Analysis script (zero dependencies)
│   ├── sample_incidents.csv                   # 200 realistic incidents
│   └── reports/
│       ├── summary_overall_kpis.csv
│       ├── summary_by_priority.csv
│       ├── summary_by_category.csv
│       └── summary_by_engineer.csv
```

---

## Sample Script Output

```
════════════════════════════════════════════════════════════
  IT METRICS DASHBOARD — INCIDENT ANALYSIS REPORT
════════════════════════════════════════════════════════════

  OVERALL KPIs
  Total incidents analysed : 200
  Average MTTR             : 8.4h  (baseline: 10.2h)
  MTTR improvement         : ▼ 17.6% vs baseline
  SLA compliance           : 91.0% (baseline: 82.0%)
  SLA improvement          : ▲ 9.0 pts vs baseline
  Total SLA breaches       : 18
```

---

## ITIL Processes Covered

| Process | As-Is Maturity | To-Be Maturity |
|---------|---------------|----------------|
| Incident Management | Level 1 — Ad hoc | Level 4 — Managed |
| Problem Management | Level 0 — None | Level 3 — Defined |
| Change Management | Level 0 — None | Level 4 — Managed |

---

## Skills Demonstrated

- Business Requirements Documentation (BRD)
- User Story writing with acceptance criteria
- As-Is / To-Be process mapping
- Gap analysis and pain point identification
- ITIL v4 process alignment
- System architecture (BA-level)
- Python scripting for data analysis
- KPI definition and metrics design
- Stakeholder perspective mapping (engineer / manager / leadership)
- ROI and business case analysis

---

## How to Run the Analysis Script

```bash
# No installation needed — standard Python 3.7+ only
python analyze_incidents.py

# Custom input file
python analyze_incidents.py --input your_incidents.csv --output reports/
```

---

## Author

**Harshall Bhavsar**  
Business Analyst | ITSM | ITIL | ServiceNow | Digital Transformation  
[https://www.linkedin.com/in/iamharshalbhavsar/] | [harshal.bhavsar16@gmail.com]
