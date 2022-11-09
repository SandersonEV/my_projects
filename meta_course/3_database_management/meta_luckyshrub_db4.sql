/*

The main objective of this script is to show how to create views

*/

DROP DATABASE IF EXISTS meta_luckyshrub_db4;

CREATE DATABASE meta_luckyshrub_db4;

USE meta_luckyshrub_db4;

CREATE TABLE Orders (
OrderID INT NOT NULL PRIMARY KEY, 
ClientID VARCHAR(10), 
ProductID VARCHAR(10), 
Quantity INT, 
Cost DECIMAL(6, 2)
);

INSERT INTO Orders (OrderID, ClientID, ProductID, Quantity, Cost) VALUES 
(1, "Cl1", "P1", 10, 500), 
(2, "Cl2", "P2", 5, 100), 
(3, "Cl3", "P3", 20, 800), 
(4, "Cl4", "P4", 15, 150), 
(5, "Cl3", "P3", 10, 450), 
(6, "Cl2", "P2", 5, 800), 
(7, "Cl1", "P4", 22, 1200), 
(8, "Cl1", "P1", 15, 150);
