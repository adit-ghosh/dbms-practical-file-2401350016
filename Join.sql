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