# 🏦 SBI Banking System – Financial Institution Database & Dashboard Project

## 📌 Project Overview

This project is a comprehensive banking database and analytics solution developed for the State Bank of India (SBI). It demonstrates the design and implementation of a relational database with interconnected banking entities, reusable SQL views for financial reporting, CSV-based data management, and an interactive Excel dashboard for business analysis.

The project simulates real-world banking operations, including customer management, account management, loans, fixed deposits, credit cards, insurance, transactions, lockers, and branch performance.

---

## 🎯 Project Objectives

- Design a normalized relational database for SBI.
- Implement primary and foreign key relationships.
- Import banking data using CSV files.
- Create reusable SQL views for financial reporting.
- Export financial reports as CSV files.
- Build an interactive dashboard for business insights.

---

## 🛠️ Technologies Used

- MySQL
- MySQL Workbench
- Microsoft Excel
- GitHub

---

## 📂 Project Structure

```
SBI-Banking-System/
│
├── 01_Database/
│   ├── sbi_banking_system.sql
│
├── 02_CSV/
│   ├── All CSV files
│   └── sbi_report.csv
│
├── 03_Dashboard/
│   ├── SBI_Dashboard.xlsx
│   └── Dashboard.png
│
├── 04_ER_Diagram/
│   ├── ER_Diagram.mwb
│   └── ER_Diagram.png
│
└── README.md
```

---

## 🗄️ Database Overview

The database consists of **25 interconnected tables** representing different banking operations.

### Tables Included

- Regions
- States
- Cities
- Branches
- Departments
- Designations
- Employees
- Customer Types
- Customers
- Account Types
- Accounts
- Transaction Types
- Transactions
- Loan Types
- Loans
- Loan Payments
- Loan Approvals
- Fixed Deposits
- Credit Card Types
- Credit Cards
- Card Transactions
- Lockers
- Insurance Products
- Customer Insurance
- Audit Log

---

## 🔄 Data Import

All table data was imported from CSV files using the **MySQL Workbench Table Data Import Wizard**.

---

## 📊 SQL Views

The project includes reusable SQL views for reporting and analysis:

- **sbi_report** – Branch-wise financial summary
- **monthly_transactions** – Monthly transaction analysis
- **loan_analysis** – Loan portfolio analysis

---

## 📈 Dashboard Features

The Excel dashboard includes:

- KPI Cards
- Customer Analysis
- Deposit Analysis
- Loan Analysis
- Credit Card Analysis
- Insurance Analysis
- Branch-wise Performance
- Revenue Trends
- Interactive Charts

---

## 📁 Financial Report

The reusable SQL view was exported as a CSV file and used as the primary data source for dashboard creation.

---

## 🚀 How to Run

1. Open MySQL Workbench.
2. Execute `sbi_banking_system.sql`.
3. Import all CSV files using the Table Data Import Wizard.
4. Execute the SQL views included in the script.
5. Export the financial report as a CSV file.
6. Open the Excel dashboard to explore the visualizations.


