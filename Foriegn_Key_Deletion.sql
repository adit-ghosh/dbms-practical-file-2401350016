-- delete from primary key table [temp1]
DELETE FROM temp1 WHERE id = 300;

-- delete from primary KEY table with foreign key refernece [temp1 -> temp]
DELETE FROM temp1 WHERE id = 100;