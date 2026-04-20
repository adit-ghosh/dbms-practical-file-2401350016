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