CREATE DATABASE sbi_banking_system;
USE sbi_banking_system;

-- 1. REGIONS
CREATE TABLE regions (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(100) NOT NULL,
    zone VARCHAR(50),
    created_at DATE DEFAULT (CURRENT_DATE)
);
-- 2. STATES
CREATE TABLE states (
    state_id INT PRIMARY KEY,
    state_name VARCHAR(100) NOT NULL,
    state_code VARCHAR(10) UNIQUE,
    region_id INT,
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);
-- 3. CITIES
CREATE TABLE cities (
    city_id INT PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL,
    state_id INT,
    tier VARCHAR(20),
    FOREIGN KEY (state_id) REFERENCES states(state_id)
);
-- 4. BRANCHES
CREATE TABLE branches (
    branch_id INT PRIMARY KEY,
    branch_code VARCHAR(20) UNIQUE NOT NULL,
    branch_name VARCHAR(150) NOT NULL,
    city_id INT,
    address VARCHAR(300),
    ifsc_code VARCHAR(11) UNIQUE NOT NULL,
    branch_type VARCHAR(50),
    opening_date DATE,
    is_active TINYINT(1) DEFAULT 1,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);
-- 5. DEPARTMENTS
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    description VARCHAR(300)
);
-- 6. DESIGNATIONS
CREATE TABLE designations (
    designation_id INT PRIMARY KEY,
    designation_name VARCHAR(100) NOT NULL,
    grade VARCHAR(20),
    min_salary DECIMAL(12,2),
    max_salary DECIMAL(12,2)
);
-- 7. EMPLOYEES
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_code VARCHAR(20) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    branch_id INT,
    department_id INT,
    designation_id INT,
    manager_id INT,
    hire_date DATE,
    salary DECIMAL(12,2),
    is_active TINYINT(1) DEFAULT 1,
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (designation_id) REFERENCES designations(designation_id),
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);
-- 8. CUSTOMER_TYPES
CREATE TABLE customer_types (
    type_id INT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL,
    description VARCHAR(200)
);
-- 9. CUSTOMERS
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_code VARCHAR(20) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    date_of_birth DATE,
    gender VARCHAR(10),
    email VARCHAR(100),
    phone VARCHAR(15) NOT NULL,
    pan_number VARCHAR(10) UNIQUE,
    aadhaar_number VARCHAR(12) UNIQUE,
    address VARCHAR(300),
    city_id INT,
    customer_type_id INT,
    kyc_verified TINYINT(1) DEFAULT 0,
    registration_date DATE,
    home_branch_id INT,
    FOREIGN KEY (city_id) REFERENCES cities(city_id),
    FOREIGN KEY (customer_type_id) REFERENCES customer_types(type_id),
    FOREIGN KEY (home_branch_id) REFERENCES branches(branch_id)
);
-- 10. ACCOUNT_TYPES
CREATE TABLE account_types (
    account_type_id INT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL,
    min_balance DECIMAL(12,2),
    interest_rate DECIMAL(5,2),
    description VARCHAR(200)
);
-- 11. ACCOUNTS
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    account_number VARCHAR(20) UNIQUE NOT NULL,
    customer_id INT,
    account_type_id INT,
    branch_id INT,
    opening_date DATE,
    current_balance DECIMAL(15,2) DEFAULT 0,
    status VARCHAR(20) DEFAULT 'Active',
    last_transaction_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (account_type_id) REFERENCES account_types(account_type_id),
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);
-- 12. TRANSACTION_TYPES
CREATE TABLE transaction_types (
    txn_type_id INT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL,
    type_code VARCHAR(10) UNIQUE
);
-- 13. TRANSACTIONS
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    transaction_ref VARCHAR(30) UNIQUE NOT NULL,
    account_id INT,
    txn_type_id INT,
    amount DECIMAL(15,2) NOT NULL,
    balance_after DECIMAL(15,2),
    transaction_date DATETIME,
    description VARCHAR(200),
    channel VARCHAR(50),
    status VARCHAR(20) DEFAULT 'Completed',
    FOREIGN KEY (account_id) REFERENCES accounts(account_id),
    FOREIGN KEY (txn_type_id) REFERENCES transaction_types(txn_type_id)
);
-- 14. LOAN_TYPES
CREATE TABLE loan_types (
    loan_type_id INT PRIMARY KEY,
    type_name VARCHAR(100) NOT NULL,
    base_interest_rate DECIMAL(5,2),
    max_tenure_months INT,
    processing_fee_percent DECIMAL(5,2)
);
-- 15. LOANS
CREATE TABLE loans (
    loan_id INT PRIMARY KEY,
    loan_number VARCHAR(20) UNIQUE NOT NULL,
    customer_id INT,
    loan_type_id INT,
    branch_id INT,
    principal_amount DECIMAL(15,2) NOT NULL,
    interest_rate DECIMAL(5,2),
    tenure_months INT,
    emi_amount DECIMAL(12,2),
    disbursement_date DATE,
    maturity_date DATE,
    outstanding_balance DECIMAL(15,2),
    status VARCHAR(30) DEFAULT 'Active',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (loan_type_id) REFERENCES loan_types(loan_type_id),
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);
-- 16. LOAN_PAYMENTS
CREATE TABLE loan_payments (
    payment_id INT PRIMARY KEY,
    loan_id INT,
    payment_date DATE,
    amount_paid DECIMAL(12,2),
    principal_component DECIMAL(12,2),
    interest_component DECIMAL(12,2),
    penalty DECIMAL(10,2) DEFAULT 0,
    payment_mode VARCHAR(50),
    receipt_number VARCHAR(30) UNIQUE,
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);
-- 17. LOAN_APPROVALS
CREATE TABLE loan_approvals (
    approval_id INT PRIMARY KEY,
    loan_id INT,
    approved_by INT,
    approval_date DATE,
    approval_status VARCHAR(30),
    remarks VARCHAR(300),
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id),
    FOREIGN KEY (approved_by) REFERENCES employees(employee_id)
);
-- 18. FIXED_DEPOSITS
CREATE TABLE fixed_deposits (
    fd_id INT PRIMARY KEY,
    fd_number VARCHAR(20) UNIQUE NOT NULL,
    customer_id INT,
    branch_id INT,
    linked_account_id INT,
    principal_amount DECIMAL(15,2) NOT NULL,
    interest_rate DECIMAL(5,2),
    tenure_months INT,
    start_date DATE,
    maturity_date DATE,
    maturity_amount DECIMAL(15,2),
    status VARCHAR(30) DEFAULT 'Active',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id),
    FOREIGN KEY (linked_account_id) REFERENCES accounts(account_id)
);
-- 19. CREDIT_CARD_TYPES
CREATE TABLE credit_card_types (
    card_type_id INT PRIMARY KEY,
    type_name VARCHAR(100) NOT NULL,
    credit_limit_min DECIMAL(12,2),
    credit_limit_max DECIMAL(12,2),
    annual_fee DECIMAL(10,2),
    reward_rate DECIMAL(5,2)
);
-- 20. CREDIT_CARDS
CREATE TABLE credit_cards (
    card_id INT PRIMARY KEY,
    card_number VARCHAR(20) UNIQUE NOT NULL,
    customer_id INT,
    card_type_id INT,
    credit_limit DECIMAL(12,2),
    available_limit DECIMAL(12,2),
    issue_date DATE,
    expiry_date DATE,
    status VARCHAR(30) DEFAULT 'Active',
    billing_cycle_day INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (card_type_id) REFERENCES credit_card_types(card_type_id)
);
-- 21. CARD_TRANSACTIONS
CREATE TABLE card_transactions (
    card_txn_id INT PRIMARY KEY,
    card_id INT,
    transaction_date DATETIME,
    merchant_name VARCHAR(150),
    merchant_category VARCHAR(100),
    amount DECIMAL(12,2),
    currency VARCHAR(10) DEFAULT 'INR',
    status VARCHAR(30) DEFAULT 'Completed',
    FOREIGN KEY (card_id) REFERENCES credit_cards(card_id)
);
-- 22. LOCKERS
CREATE TABLE lockers (
    locker_id INT PRIMARY KEY,
    locker_number VARCHAR(20) UNIQUE NOT NULL,
    branch_id INT,
    size VARCHAR(20),
    annual_rent DECIMAL(10,2),
    customer_id INT,
    allotment_date DATE,
    status VARCHAR(30) DEFAULT 'Available',
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
-- 23. INSURANCE_PRODUCTS
CREATE TABLE insurance_products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    product_type VARCHAR(50),
    premium_min DECIMAL(10,2),
    coverage_max DECIMAL(15,2),
    partner_company VARCHAR(100)
);
-- 24. CUSTOMER_INSURANCE
CREATE TABLE customer_insurance (
    policy_id INT PRIMARY KEY,
    policy_number VARCHAR(30) UNIQUE NOT NULL,
    customer_id INT,
    product_id INT,
    premium_amount DECIMAL(12,2),
    coverage_amount DECIMAL(15,2),
    start_date DATE,
    end_date DATE,
    status VARCHAR(30) DEFAULT 'Active',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES insurance_products(product_id)
);
-- 25. AUDIT_LOG
CREATE TABLE audit_log (
    log_id INT PRIMARY KEY,
    table_name VARCHAR(50),
    operation VARCHAR(20),
    record_id INT,
    changed_by INT,
    change_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    old_values TEXT,
    new_values TEXT,
    FOREIGN KEY (changed_by) REFERENCES employees(employee_id)
    );

-- Data imported using Table Data Import Wizard.
SELECT * FROM regions;
SELECT * FROM states;
SELECT * FROM cities;
SELECT * FROM branches;
SELECT * FROM departments;
SELECT * FROM designations;
SELECT * FROM employees;
SELECT * FROM customer_types;
SELECT * FROM customers;
SELECT * FROM account_types;
SELECT * FROM accounts;
SELECT * FROM transaction_types;
SELECT * FROM transactions;
SELECT * FROM loan_types;
SELECT * FROM loans;
SELECT * FROM loan_payments;
SELECT * FROM loan_approvals;
SELECT * FROM fixed_deposits;
SELECT * FROM credit_card_types;
SELECT * FROM credit_cards;
SELECT * FROM card_transactions;
SELECT * FROM lockers;
SELECT * FROM insurance_products;
SELECT * FROM customer_insurance;
SELECT * FROM audit_log;


-- Create a reusable financial report view 
CREATE VIEW sbi_report AS

SELECT
    b.branch_id,
    b.branch_name,
    c.city_name,
    s.state_name,
    r.region_name,

    COUNT(DISTINCT cu.customer_id) AS total_customers,

    COUNT(DISTINCT a.account_id) AS total_accounts,

    ROUND(COALESCE(SUM(DISTINCT a.current_balance),0),2)
        AS total_deposits,

    COUNT(DISTINCT l.loan_id) AS total_loans,

    ROUND(COALESCE(SUM(DISTINCT l.principal_amount),0),2)
        AS total_loan_amount,

    ROUND(COALESCE(SUM(DISTINCT l.outstanding_balance),0),2)
        AS outstanding_loan_amount,

    COUNT(DISTINCT fd.fd_id) AS total_fixed_deposits,

    ROUND(COALESCE(SUM(DISTINCT fd.principal_amount),0),2)
        AS fd_amount,

    ROUND(COALESCE(SUM(DISTINCT fd.maturity_amount),0),2)
        AS maturity_amount,

    COUNT(DISTINCT cc.card_id) AS total_credit_cards,

    ROUND(COALESCE(SUM(DISTINCT cc.credit_limit),0),2)
        AS total_credit_limit,

    ROUND(COALESCE(SUM(DISTINCT
        cc.credit_limit-cc.available_limit),0),2)
        AS utilized_credit,

    ROUND(
        CASE
            WHEN SUM(DISTINCT cc.credit_limit)=0
            THEN 0
            ELSE
            SUM(DISTINCT(cc.credit_limit-cc.available_limit))
            /
            SUM(DISTINCT cc.credit_limit)
            *100
        END,2) AS utilization_percent,

    COUNT(DISTINCT ci.policy_id)
        AS insurance_policies,

    ROUND(COALESCE(SUM(DISTINCT ci.premium_amount),0),2)
        AS insurance_premium,

    COUNT(DISTINCT lk.locker_id)
        AS lockers,

    COUNT(DISTINCT
        CASE
            WHEN lk.status='Allotted'
            THEN lk.locker_id
        END) AS active_lockers

FROM branches b

LEFT JOIN cities c
ON b.city_id=c.city_id

LEFT JOIN states s
ON c.state_id=s.state_id

LEFT JOIN regions r
ON s.region_id=r.region_id

LEFT JOIN customers cu
ON b.branch_id=cu.home_branch_id

LEFT JOIN accounts a
ON b.branch_id=a.branch_id

LEFT JOIN loans l
ON b.branch_id=l.branch_id

LEFT JOIN fixed_deposits fd
ON b.branch_id=fd.branch_id

LEFT JOIN credit_cards cc
ON cu.customer_id=cc.customer_id

LEFT JOIN customer_insurance ci
ON cu.customer_id=ci.customer_id

LEFT JOIN lockers lk
ON cu.customer_id=lk.customer_id

WHERE b.is_active=1

GROUP BY

b.branch_id,
b.branch_name,
c.city_name,
s.state_name,
r.region_name;


-- Create a reusable monthly transactions view 

CREATE VIEW monthly_transactions AS

SELECT

DATE_FORMAT(transaction_date,'%Y-%m') AS Month,

COUNT(*) AS TotalTransactions,

SUM(amount) AS TransactionAmount,

AVG(amount) AS AverageTransaction,

MAX(amount) AS HighestTransaction

FROM transactions

WHERE status='Completed'

GROUP BY DATE_FORMAT(transaction_date,'%Y-%m')

ORDER BY Month;




-- Create a reusable loan analysis view
SELECT * FROM loan_analysis;

CREATE VIEW loan_analysis AS

SELECT

lt.type_name,

COUNT(l.loan_id) AS TotalLoans,

SUM(l.principal_amount) AS PrincipalAmount,

SUM(l.outstanding_balance) AS OutstandingAmount,

AVG(l.interest_rate) AS AvgInterest,

AVG(l.emi_amount) AS AvgEMI

FROM loans l

JOIN loan_types lt
ON l.loan_type_id=lt.loan_type_id

GROUP BY lt.type_name;





