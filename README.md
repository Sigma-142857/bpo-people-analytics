
# From Burnout to Retention — A BPO People Analytics Story

A full-cycle people analytics project analyzing BPO agent performance, shift patterns, and attrition risk — built end-to-end using PostgreSQL, Google Sheets, Looker Studio, and Canva.

---

## Project Overview

This project simulates a real BPO operations scenario to identify the root causes of poor shift performance and high agent attrition. It demonstrates the complete data analytics workflow — from database design and SQL querying to exploratory data analysis, interactive dashboards, and business recommendations.

**The Business Problem:** BPO centers struggle with high agent turnover and inconsistent shift performance, but lack data-driven visibility into which shifts and teams underperform and why.

---

## Key Findings

- **Night shift agents take 89% longer to handle calls** than morning shift (472 sec vs 250 sec) and deliver the lowest CSAT score of 1.55 out of 5
- **Team Echo is the lowest-performing team** with a CSAT score of 1.91 and the highest handle time of 392 seconds
- **Night shift accounts for 61% of all absences** while morning shift records zero absences
- **Estimated cost of attrition: $25,000** per cycle

---

## Tools & Technologies

| Tool | Purpose |
|------|---------|
| PostgreSQL | Database design and SQL querying |
| Google Sheets | Exploratory data analysis and pivot tables |
| Looker Studio | Interactive dashboard development |
| Canva | Business presentation deck |

---

## Project Structure

```
bpo-people-analytics/
├── sql/                    # SQL queries and database schema
│   ├── schema.sql
│   └── queries.sql
├── data/                   # CSV datasets
│   ├── agents.csv
│   ├── calls.csv
│   └── attendance.csv
├── screenshots/            # Dashboard screenshots
│   ├── executive_dashboard.png
│   └── team_leader_dashboard.png
├── deck/                   # Business presentation
│   └── BPO_Analytics_Deck.pdf
└── README.md
```

---

## Methodology

### Phase 1 — Database Design (PostgreSQL)
Built a relational database with three tables: agents (50 records), calls (150 records), and attendance (200 records). Wrote 6 SQL queries covering average handle time by shift, CSAT by team, absence rate, attrition risk scoring, and cost of attrition estimation.

### Phase 2 — Exploratory Data Analysis (Google Sheets)
Performed EDA using 3 pivot tables and 3 charts. Built a normalized performance index benchmarking all teams against the top performer. Documented three key findings with business implications.

### Phase 3 — Dashboard Development (Looker Studio)
Built a two-page interactive dashboard:
- **Executive Dashboard:** KPI scorecards, AHT by shift, CSAT by team, and absence distribution
- **Team Leader Dashboard:** CSAT by agent, AHT by agent, and a detailed agent performance table

Used blended data sources with inner joins on agent_id to combine data across tables — equivalent to SQL JOIN operations.

### Phase 4 — Business Recommendations (Canva)
Produced a 5-slide business deck translating findings into actionable recommendations.

---

## Recommendations

1. **Restructure night shift operations** — assign dedicated supervisors, reduce back-to-back call loads, and introduce wellness check-ins
2. **Launch a 30-day Team Echo coaching program** — pair low performers with top agents and set a 90-day CSAT improvement target
3. **Create an absence early warning system** — flag agents with 2+ absences per month and offer night shift incentives

**Projected Impact:** Reduce the $25,000 attrition cost and improve overall CSAT from 2.7 to 3.5+ within 6 months.

---

## About the Author

**Sigma Rose A. Abordo, RMT, ASCPi**
Operations and Data Analyst with 10+ years of experience in multi-site operations management, quality assurance, and performance reporting across the Philippines, UAE, and Saudi Arabia.

- Email: 
- LinkedIn: 
- Location: Bacolod City, Philippines

---

*This project was built as a portfolio demonstration of end-to-end data analytics skills for BPO Data Analyst and Business Analyst roles.*
