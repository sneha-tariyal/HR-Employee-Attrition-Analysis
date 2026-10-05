# HR Employee Attrition Analysis

## Project Overview

This project analyzes employee workforce, salary, job roles, and attrition patterns using PostgreSQL and SQL.

The analysis focuses on understanding workforce size, departmental distribution, salary patterns, employee attrition, 
overtime, job roles, and other factors related to employee turnover.

## Project Objective

To analyze employee workforce, salary, job roles, and attrition patterns using PostgreSQL SQL queries, identify factors 
associated with employee turnover, and derive actionable business insights to support employee retention and workforce management.

## Tools & Technologies

- PostgreSQL
- SQL
- pgAdmin
- GitHub

## Dataset

The main employee dataset contains employee-level information such as:

- Age
- Attrition
- Business Travel
- Department
- Education
- Job Role
- Job Satisfaction
- Monthly Income
- OverTime
- Performance Rating
- Work-Life Balance
- Years at Company
- Years in Current Role
- Years Since Last Promotion
- Years With Current Manager

The project uses the `Employee_Attrition` table for employee-level analysis.

A supplementary `Department` table is also included for JOIN-based analysis. It contains:

- EmployeeNumber
- Department
- ManagerName
- Location

## Database Structure

### Employee_Attrition

The `Employee_Attrition` table contains employee-level HR information and uses `EmployeeNumber` as the primary key.

### Department

The `Department` table contains department, manager, and location information linked to employees through `EmployeeNumber`.

## SQL Analysis Performed

The project includes SQL analysis covering:

### 1. Workforce Overview
- Total workforce size
- Different departments
- Average employee age
- Employees by location

### 2. Salary & Job Role Analysis
- Average monthly income by job role
- Job roles with average income above 10,000
- Employees earning above the company average
- Second-highest monthly income

### 3. Attrition Analysis
- Overall employee attrition
- Attrition by department
- Attrition by gender
- Attrition by marital status
- Attrition by overtime
- Attrition by job role

### 4. Advanced SQL Analysis
The project demonstrates the use of:

- Aggregate functions
- GROUP BY
- HAVING
- Subqueries
- Common Table Expressions (CTEs)
- JOINs
- Window functions
- DENSE_RANK
- CASE statements

## Key Findings

- Total workforce analyzed: 1,470 employees
- Overall employee attrition rate: 16.12%
- Sales has the highest attrition rate at 20.63%
- Employees working overtime have a higher attrition rate of 30.53%
- Manager and Research Director roles have the highest average monthly income

## Business Recommendations

Based on the analysis:

1. Focus retention efforts on departments with higher attrition, particularly Sales and HR.
2. Review overtime workload and its potential relationship with employee turnover.
3. Consider compensation and career-growth opportunities for improving employee retention.
4. Monitor job satisfaction, work-life balance, and career progression as part of employee retention strategies.

## Project Files

- `HR_Employee_Attrition_Portfolio.sql` – SQL table creation and analysis queries
- `HR-Employee-Attrition.csv` – Employee dataset used for the analysis
- `Department.csv` – Supplementary department, manager, and location data
- `README.md` – Project documentation

## Conclusion

This project demonstrates how SQL can be used to analyze HR data and convert employee-level information into meaningful 
workforce and attrition insights.

The analysis can help HR teams identify attrition patterns, understand workforce characteristics, and support data-driven 
employee retention decisions.
