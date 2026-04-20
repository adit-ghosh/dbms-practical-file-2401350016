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
