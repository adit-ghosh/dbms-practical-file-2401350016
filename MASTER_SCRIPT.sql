-- MASTER SCRIPT

-- DATABASE AND TABLE CREATION
DROP DATABASE IF EXISTS aditstudents;
CREATE DATABASE aditstudents;
USE aditstudents;

CREATE TABLE student(
id INT PRIMARY KEY ,
name VARCHAR(50),
validity TINYINT,
age INT NOT NULL
);

INSERT INTO student (id , name , validity , age) VALUES(1,'john',21,20);
INSERT INTO student (id , name , validity , age) VALUES(2,'terry',21,26);
INSERT INTO student (id , name , validity , age) VALUES(3,'junior',21,30);

SELECT * FROM student;

-- KEYS CONCEPTS

-- new table
DROP TABLE IF EXISTS temp;
DROP TABLE IF EXISTS temp1;

-- Parent table 
CREATE TABLE temp1 (
    id INT NOT NULL,                         
    name VARCHAR(50) NOT NULL,
    city VARCHAR(50) UNIQUE,                
    availability TINYINT NOT NULL DEFAULT 1, 
    CHECK (availability IN (0,1)),           
    PRIMARY KEY (id, name)
);

-- Insert into parent
INSERT INTO temp1 VALUES (100, 'john', 'liverpool', 1);
INSERT INTO temp1 VALUES (200, 'terry', 'chelsea', 0);
INSERT INTO temp1 VALUES (300, 'Bukaio', 'London', 0);

-- Child table with composite foreign key
CREATE TABLE temp (
    cust_id INT NOT NULL,
    cust_name VARCHAR(50) NOT NULL,                    
    FOREIGN KEY (cust_id, cust_name) REFERENCES temp1(id, name)
    ON DELETE CASCADE -- THIS IS USED TO AVERT THE FOREIGN KEY CONSTRAINT ERROR
    ON UPDATE CASCADE
);

-- Insert into child
INSERT INTO temp VALUES (100, 'john');
INSERT INTO temp VALUES (200, 'terry');

-- View both tables
SELECT * FROM temp1;
SELECT * FROM temp;

-- delete from primary key table [temp1]
DELETE FROM temp1 WHERE id = 300;

-- delete from primary KEY table with foreign key refernece [temp1 -> temp]
DELETE FROM temp1 WHERE id = 100;

-- View both tables
SELECT * FROM temp1;
SELECT * FROM temp;

-- JOINS

-- new table
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS dept;

-- Parent table --Department Table
CREATE TABLE dept (
    id INT NOT NULL,                         
    name VARCHAR(50) NOT NULL,                         
    PRIMARY KEY (id)
);

-- Insert into parent
INSERT INTO dept VALUES (100, 'Physics');
INSERT INTO dept VALUES (200, 'Mathematics');

-- Child table with composite foreign key --Employee Table
CREATE TABLE Employee (
    emp_id INT NOT NULL,
    emp_name VARCHAR(50) NOT NULL,
    dept_id INT NOT NULL,
    dept_name VARCHAR(50) NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES dept(id),
	PRIMARY KEY (emp_id)
);

-- Insert into child
INSERT INTO Employee VALUES (101, 'Eric', 100, 'Physics');
INSERT INTO Employee VALUES (202, 'Garcia', 200, 'Maths');

-- View both tables
SELECT * FROM dept;
SELECT * FROM Employee;

-- Joins In Employee and dept

-- Natural join dept [parent table], Employee [Child Table]
SELECT * FROM dept NATURAL JOIN Employee;

-- OUTER JOIN
SELECT * FROM dept NATURAL LEFT JOIN Employee;
SELECT * FROM dept NATURAL RIGHT JOIN Employee;

-- EQUI JOIN
SELECT * FROM dept JOIN Employee WHERE dept.id = Employee.dept_id;

-- THETA JOIN
SELECT * FROM dept JOIN Employee WHERE dept.id > Employee.emp_id;
