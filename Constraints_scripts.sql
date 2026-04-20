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
