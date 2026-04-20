DROP DATABASE IF EXISTS UNI;
CREATE DATABASE IF NOT EXISTS UNI;
USE UNI;

DROP TABLE IF exists University;
CREATE TABLE University (
    UniversityID INT PRIMARY KEY,
    UniversityName VARCHAR(100),
    Location VARCHAR(100),
    EstablishedYear INT,
    ChancellorName VARCHAR(100)
);


ALTER TABLE University ADD DOB DATE;

INSERT INTO University (UniversityID, UniversityName, Location, EstablishedYear, ChancellorName, DOB) VALUES (1, 'Delhi University', 'Delhi', 1922, 'Yogesh Singh','2026-10-01'); 

ALTER TABLE University ADD Ranking INT;

ALTER TABLE University MODIFY EstablishedYear INT NULL;

ALTER TABLE University RENAME COLUMN Location TO City;

ALTER TABLE University DROP COLUMN ChancellorName;



UPDATE University SET ChancellorName = 'New Chancellor' WHERE UniversityID = 1;

DELETE FROM University WHERE UniversityID = 1;

SELECT * FROM University WHERE Location = 'Haryana';

SELECT * FROM University WHERE EstablishedYear > 2000;


