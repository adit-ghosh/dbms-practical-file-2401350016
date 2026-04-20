-- PRACTICAL 1: DDL COMMANDS
-- AIM: To study and implement various DDL commands to create and modify a table in MySQL.
DROP DATABASE IF EXISTS DBMS_Practicals;
CREATE DATABASE IF NOT EXISTS DBMS_Practicals;
USE DBMS_Practicals;

DROP TABLE IF EXISTS Employees;
CREATE TABLE IF NOT EXISTS Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50) NOT NULL,
    Department VARCHAR(30),
    Salary DECIMAL(10, 2),
    ManagerID INT
);

DESCRIBE Employees;

ALTER TABLE Employees ADD DateOfJoin DATE;
ALTER TABLE Employees MODIFY EmpName VARCHAR(100);
ALTER TABLE Employees CHANGE COLUMN DateOfJoin DOJ DATE;
ALTER TABLE Employees DROP COLUMN DOJ;

-- Adding sample data to verify table functionality
INSERT INTO Employees (EmpID, EmpName, Department, Salary, ManagerID) VALUES
(101, 'Rahul Sharma', 'IT', 75000.00, NULL),
(102, 'Priya Verma', 'HR', 60000.00, 101),
(103, 'Amit Gupta', 'IT', 70000.00, 101);

SELECT * FROM Employees;
TRUNCATE TABLE Employees;
SELECT * FROM Employees;
DESCRIBE Employees;

-- PRACTICAL 2: DML COMMANDS
-- AIM: To study and implement various DML commands to insert, retrieve, update, and delete data.

-- 1. INSERT: Adding data into the table
INSERT INTO Employees (EmpID, EmpName, Department, Salary, ManagerID) VALUES
(101, 'Rahul Sharma', 'IT', 75000.00, NULL),
(102, 'Priya Verma', 'HR', 60000.00, 101),
(103, 'Amit Gupta', 'IT', 70000.00, 101),
(104, 'Suresh Lal', 'Finance', 55000.00, 102),
(105, 'Neha Kapoor', 'HR', 62000.00, 102);

-- 2. SELECT: Retrieving data
-- Retrieving all columns
SELECT * FROM Employees;

-- Retrieving specific columns with a condition
SELECT EmpName, Salary FROM Employees WHERE Department = 'IT';

-- 3. UPDATE: Modifying existing data
UPDATE Employees SET Salary = 80000.00 WHERE EmpID = 101;
UPDATE Employees SET Department = 'Operations' WHERE EmpID = 104;

-- Verifying updates
SELECT * FROM Employees;

-- 4. DELETE: Removing specific records
DELETE FROM Employees WHERE EmpID = 105;

-- Verifying deletion
SELECT * FROM Employees;

-- PRACTICAL 3: DCL COMMANDS
-- AIM: To study and implement DCL commands to control access and permissions in MySQL.

-- 1. Creating a new user for demonstration
CREATE USER IF NOT EXISTS 'test_user'@'localhost' IDENTIFIED BY 'password123';

-- 2. GRANT: Giving permissions to the user
-- Granting SELECT permission on the Employees table
GRANT SELECT ON DBMS_Practicals.Employees TO 'test_user'@'localhost';

-- 3. REVOKE: Taking back permissions
-- Revoking the SELECT permission
REVOKE SELECT ON DBMS_Practicals.Employees FROM 'test_user'@'localhost';

-- 4. Cleaning up
DROP USER 'test_user'@'localhost';

-- PRACTICAL 4: AGGREGATE FUNCTIONS
-- AIM: To implement aggregate functions MIN(), MAX(), SUM(), AVG(), and COUNT() on a table in MySQL.

-- 1. COUNT: Total number of employees
SELECT COUNT(*) AS TotalEmployees FROM Employees;

-- 2. SUM: Total salary paid by the company
SELECT SUM(Salary) AS TotalSalary FROM Employees;

-- 3. AVG: Average salary of employees
SELECT AVG(Salary) AS AverageSalary FROM Employees;

-- 4. MIN: Minimum salary in the table
SELECT MIN(Salary) AS MinimumSalary FROM Employees;

-- 5. MAX: Maximum salary in the table
SELECT MAX(Salary) AS MaximumSalary FROM Employees;

-- PRACTICAL 5: GROUP BY AND HAVING CLAUSE
-- AIM: To implement GROUP BY and HAVING clauses to group rows and filter groups in MySQL.

-- 1. GROUP BY: Grouping employees by department
SELECT Department, COUNT(*) AS NumberOfEmployees
FROM Employees
GROUP BY Department;

-- 2. HAVING: Filtering groups with more than 1 employee
SELECT Department, COUNT(*) AS NumberOfEmployees
FROM Employees
GROUP BY Department
HAVING COUNT(*) > 1;

-- 3. Multiple aggregate functions
SELECT Department, COUNT(*) AS NumberOfEmployees, AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY Department;

-- PRACTICAL 6: NATURAL JOIN AND EQUI JOIN
-- AIM: To implement NATURAL JOIN and EQUI JOIN on tables in MySQL.

-- To perform joins, we need a second table.
CREATE TABLE IF NOT EXISTS Departments (
    Department VARCHAR(30) PRIMARY KEY,
    Location VARCHAR(50)
);

-- Inserting data into Departments
INSERT INTO Departments (Department, Location) VALUES
('IT', 'Floor 1'),
('HR', 'Floor 2'),
('Finance', 'Floor 3'),
('Operations', 'Floor 4');

-- 1. EQUI JOIN: Joining tables using a common column with '=' operator
SELECT Employees.EmpName, Employees.Department, Departments.Location
FROM Employees
JOIN Departments ON Employees.Department = Departments.Department;

-- 2. NATURAL JOIN: Joining tables automatically based on columns with same name
SELECT * FROM Employees NATURAL JOIN Departments;

-- PRACTICAL 7: LEFT OUTER JOIN AND RIGHT OUTER JOIN
-- AIM: To implement LEFT OUTER JOIN and RIGHT OUTER JOIN on tables in MySQL.

-- Adding sample data to show unmatched records
INSERT INTO Departments (Department, Location) VALUES ('Marketing', 'Floor 5');
INSERT INTO Employees (EmpID, EmpName, Department, Salary, ManagerID) VALUES (106, 'Vicky Malhotra', NULL, 48000.00, 101);

-- 1. LEFT OUTER JOIN: Returns all records from the left table, and matched records from the right table.
-- Employees is Left, Departments is Right. This will show 'Vicky' even without a department.
SELECT Employees.EmpName, Employees.Department, Departments.Location
FROM Employees
LEFT JOIN Departments ON Employees.Department = Departments.Department;

-- 2. RIGHT OUTER JOIN: Returns all records from the right table, and matched records from the left table.
-- This will show 'Marketing' and 'Finance' even if they have no employees.
SELECT Employees.EmpName, Departments.Department, Departments.Location
FROM Employees
RIGHT JOIN Departments ON Employees.Department = Departments.Department;

-- PRACTICAL 8: SELF JOIN
-- AIM: To implement SELF JOIN on a table in MySQL.

-- SELF JOIN: Joining the 'Employees' table with itself to find managers
-- We use aliases 'e' for employee and 'm' for manager.
SELECT e.EmpName AS Employee, m.EmpName AS Manager
FROM Employees e
JOIN Employees m ON e.ManagerID = m.EmpID;

-- This query matches the ManagerID of an employee with the EmpID of another employee in the same table.


