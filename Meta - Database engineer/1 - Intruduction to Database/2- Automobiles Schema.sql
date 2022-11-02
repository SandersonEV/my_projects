-- This database is the exercise number 2 from Meta Database Enginner Course - 1 Module, Week 4

DROP DATABASE IF EXISTS meta_automobile;

CREATE DATABASE meta_automobile;

USE meta_automobile;

CREATE TABLE `owner`(
ownerID VARCHAR(10) PRIMARY KEY,
ownerName VARCHAR(10),
ownerAddress VARCHAR(255)
);

CREATE TABLE vehicle(
vehicleID VARCHAR(10) PRIMARY KEY,
ownerID VARCHAR(10) NOT NULL, /* It should be NOT NULL because every vahicle has a owner. you have to create first the owner and after the vehicle to put the ownerID */
plateNumber VARCHAR(10),
phoneNumber INT,
FOREIGN KEY (ownerID) REFERENCES `owner`(ownerID)
);

-- (The foreign Key can also come at the end, after creating the table)
-- ALTER TABLE vehicle ADD FOREIGN KEY (ownerID) REFERENCES owner (ownerID); 

SHOW TABLES; /*see if the table was created */
SHOW COLUMNS FROM vehicle; /* Just to check if everything is right in the table. The key value MUL = the same values are allowed to be in other cells too */
SHOW COLUMNS FROM `owner`;

