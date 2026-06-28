# Credit Risk Intelligence Platform

An end-to-end **Credit Risk Analytics** solution built using **Python, PostgreSQL, SQL, and Power BI**. This project transforms raw loan data into a dimensional data warehouse and an interactive dashboard to analyze portfolio performance, borrower risk, repayment behavior, and potential fraud.

## Dashboard Preview

### Portfolio Overview

![Portfolio Overview](Portfolio_Overview.png)

### Credit Risk Deep Dive

![Credit Risk Deep Dive](dashboard/screenshots/credit_risk_analysis.png)

### Repayment Health

![Repayment Health](dashboard/screenshots/repayment_health.png)

### Fraud Detection Module

![Fraud Detection](dashboard/screenshots/fraud_detection.png)

## Tech Stack

| Layer                 | Technology       |
| --------------------- | ---------------- |
| Programming           | Python           |
| Data Processing       | Pandas, NumPy    |
| Database              | PostgreSQL       |
| Query Language        | SQL              |
| Business Intelligence | Power BI Desktop |
| Version Control       | Git & GitHub     |

## Project Structure

```text
CreditRisk_FraudMonitoring/

├── dashboard/
│   ├── CreditRisk.pbix
│   ├── CreditRisk.pdf
│   └── screenshots/
│
├── data/
│   ├── raw data/
│   └── processed/
│
├── scripts/
│   ├── 01_data_cleaning.py
│   └── 02_load_to_postgre.py
│
├── sql/
│   ├── create_schema_views.sql
│   └── sample_queries.sql
│
├── requirements.txt
└── README.md
```

---

## Project Workflow

### Phase 1 – Data Cleaning

The raw loan dataset is cleaned and transformed using Python.

Key preprocessing steps include:

* Handling missing values
* Standardizing data types
* Creating a **Default Flag** from delinquent loan statuses
* Engineering a **Fraud Flag** using borrower risk signals
* Creating borrower **Risk Tiers** (Low, Medium, High, Very High)
* Parsing issue dates into year, quarter and month
* Generating operational **Alert Levels** (CRITICAL, HIGH, MONITOR)

### Phase 2 – Data Warehouse

A **Star Schema** was implemented in PostgreSQL consisting of:

### Fact Table

* `fact_loans`

### Dimension Tables

* `dim_grade`
* `dim_borrower`
* `dim_time`

The ETL pipeline loads the cleaned dataset into a staging table before populating the dimension tables and fact table.

```
Raw CSV
   │
   ▼
Python ETL
   │
   ▼
Staging Table
   │
   ▼
Dimension Tables
   │
   ▼
Fact Table
```

---

### Phase 3 – SQL Analytics

Analytical SQL views were created to simplify reporting inside Power BI.

| View                       | Description                                  |
| -------------------------- | -------------------------------------------- |
| `vw_default_by_risk_tier`  | Default rate and exposure analysis           |
| `vw_rolling_default_trend` | 3-month rolling default trend                |
| `vw_fraud_signals`         | Fraud analysis by geography and loan purpose |
| `vw_high_risk_watchlist`   | High-risk and fraud-flagged loan monitoring  |
| `vw_repayment_health`      | Repayment and outstanding balance analysis   |

---

### Phase 4 – Power BI Dashboard

The dashboard consists of four interactive pages.

### Portfolio Overview

* Portfolio KPIs
* Total Exposure
* Default Rate
* Fraud Flags
* Risk Tier Distribution
* Monthly Portfolio Trend

### Credit Risk Deep Dive

* Risk Tier × Loan Purpose Heatmap
* Debt-to-Income vs Interest Rate Analysis
* Exposure at Risk by State
* Interactive Slicers

### Repayment Health

* Portfolio Principal Repaid
* Outstanding Balance Analysis
* Late Fee Analysis
* Outstanding Balance Trend
* Loan Status Distribution

### Fraud Detection Module

* Fraud Monitoring KPIs
* Fraud Flag Rate by Loan Purpose
* Geographic Fraud Distribution
* High Risk Watchlist

## Dashboard Features

* Interactive slicers
* Cross-filtering
* DAX measures
* KPI cards
* Conditional formatting
* Geographic analysis
* Role-Level Security (RLS)
* Professional dashboard navigation

## Dataset
* **Source:** OpenIntro Loans Dataset
* **Records:** 9,976 cleaned loan records
* **Features:** 60+ borrower, credit history, repayment and loan attributes

## Author

**Aarushi Ghosh**

Electronics & Telecommunication Engineering Student

Data Analytics • Business Intelligence • Machine Learning
