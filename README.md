# DBMS Practical File - 2401350016

This repository contains the implementation of various Database Management System (DBMS) practicals using MySQL. The experiments cover fundamental and advanced SQL concepts, ranging from basic table manipulation to complex joins.

## 📊 Experiments Overview

| S.N | Aim | Description |
|:---:|:---|:---|
| 1 | **DDL Commands** | Implementation of Data Definition Language commands (`CREATE`, `ALTER`, `DROP`, `TRUNCATE`). |
| 2 | **DML Commands** | Implementation of Data Manipulation Language commands (`INSERT`, `SELECT`, `UPDATE`, `DELETE`). |
| 3 | **DCL Commands** | Controlling access and permissions using `GRANT` and `REVOKE`. |
| 4 | **Aggregate Functions** | Using `MIN()`, `MAX()`, `SUM()`, `AVG()`, and `COUNT()` for data analysis. |
| 5 | **Group By & Having** | Categorizing records and filtering groups based on specific conditions. |
| 6 | **Joins (Equi & Natural)** | Combining records from multiple tables based on related columns. |
| 7 | **Outer Joins** | Implementing `LEFT OUTER JOIN` and `RIGHT OUTER JOIN` to handle unmatched data. |
| 8 | **Self Join** | Joining a table with itself (e.g., finding Employee-Manager relationships). |

## 🛠️ Approach Details

### 1. Database Structure
- All practicals are executed within a single database: `DBMS_Practicals`.
- The central table used is `Employees`, which stores employee details like ID, name, department, salary, and manager references.
- For Join operations, a secondary `Departments` table is utilized to demonstrate table relationships.

### 2. Implementation Strategy
- **Practical 1-2**: Foundation of the database structure and population of sample data.
- **Practical 3**: Security-focused commands for managing user privileges.
- **Practical 4-5**: Data analysis using built-in SQL functions and group-level filtering.
- **Practical 6-8**: Advanced data retrieval techniques focusing on internal and external table relationships.

## 🚀 How to Run
1. Ensure your MySQL server is running.
2. Open the [Practical_File.sql](Practical_File.sql) and execute the script in your MySQL Workbench or CLI.
3. Every step includes `SELECT` or `DESCRIBE` operations to verify results immediately.

---
**Roll No:** 2401350016
