-- The main purpose of these database is to practice the creation of constraints

DROP DATABASE IF EXISTS Meta_Mangata_Gallo;

CREATE DATABASE Meta_Mangata_Gallo; 

USE META_Mangata_Gallo; 

DROP TABLE IF EXISTS clients;
CREATE TABLE clients (
ClientID INT NOT NULL PRIMARY KEY,
FullName VARCHAR(100) NOT NULL,
PhoneNumber INT NOT NULL UNIQUE
);
SHOW COLUMNS FROM clients; 

DROP TABLE IF EXISTS itens;
CREATE TABLE itens (
ItemID INT NOT NULL PRIMARY KEY,
ItemName VARCHAR(100) NOT NULL,
Price DECIMAL(5,2) NOT NULL
);
SHOW COLUMNS FROM itens; 

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
OrdersID INT NOT NULL PRIMARY KEY,
ClientID INT NOT NULL,
ItemID INT NOT NULL,
Quantity INT NOT NULL CHECK (Quantity <= 3),
Cost DECIMAL (6,2) NOT NULL,
FOREIGN KEY (ClientID) REFERENCES clients(ClientID),
FOREIGN KEY (ItemID) REFERENCES itens(ItemID)
);
SHOW COLUMNS FROM orders; 

/* 
Task 1:  Create the Staff table with the following PRIMARY KEY and NOT NULL constraints:
Staff ID should be INT, NOT NULL and PRIMARY KEY
PhoneNumber should be INT, NOT NULL and UNIQUE 
FullName: VARCHAR(100) NOT NULL.
*/

DROP TABLE IF EXISTS staffs;
CREATE TABLE staffs (
StaffID INT NOT NULL PRIMARY KEY,
PhoneNumber INT NOT NULL UNIQUE,
FullName VARCHAR(100) NOT NULL
);
SHOW COLUMNS FROM staffs; 

/* 
Task 2: Create the 'ContractInfo' table with the following key and domain constraints:
Contract ID should be INT, NOT NULL and PRIMARY KEY
StaffID should be INT, NOT NULL. 
Salary should be DECIMAL (7,2), NOT NULL.
Location should be VARCHAR (50) NOT NULL with DEFAULT = "Texas". 
StaffType should be VARCHAR (20) NOT NULL and should accept a "Junior" or a "Senior" value.
*/

DROP TABLE IF EXISTS ContractInfo;
CREATE TABLE ContractInfo (
ContractID INT NOT NULL PRIMARY KEY,
StaffID INT NOT NULL,
Salary DECIMAL(7,2) NOT NULL,
Location VARCHAR (50) NOT NULL DEFAULT 'Texas',
StaffType VARCHAR (20) NOT NULL CHECK (StaffType = "Junior" OR StaffType = "Senior"), 
FOREIGN KEY (StaffID) REFERENCES staffs(StaffID)
);
SHOW COLUMNS FROM ContractInfo; 


