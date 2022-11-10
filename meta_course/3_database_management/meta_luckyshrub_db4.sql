/*
The main objectives of this activity are as follows:
1- Create a virtual table.
2- Update the base table using the virtual table.
3- Rename the virtual table.
4- Drop the virtual table.
*/

DROP DATABASE IF EXISTS meta_luckyshrub_db4;

CREATE DATABASE meta_luckyshrub_db4;

USE meta_luckyshrub_db4;

DROP TABLE IF EXISTS Orders;

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

/* 
Task 1: Write a SQL statement to create the OrdersView Virtual table based on the Orders table. The table must include the following columns: Order ID, Quantity and Cost. 
*/

DROP VIEW IF EXISTS OrdersView;

CREATE VIEW OrdersView AS
SELECT OrderID , Quantity , Cost 
FROM orders;

SELECT * FROM OrdersView;

/*
Task 2: Write a SQL statement that utilizes the ‘OrdersView’ virtual table to Update the base Orders table. In the UPDATE TABLE statement, change the cost to 200 where the order id equals 2. 
Once you have executed the query, select all data from the OrdersView table. The expected output result should be the same as the following screenshot (assuming that you have created and populated the table correctly).
*/
-- REMENBER: The REPLACE command work in the intire row, so if you want to update only one field of the row the REPLACE command will delete the others rows. In this case is the UPDATE function.

UPDATE ordersview SET Cost = 200 WHERE OrderId = 2;
SELECT * FROM OrdersView;


/*
Task 3: Write a SQL statement that changes the name of the ‘OrdersView’ virtual table to ClientsOrdersView.
*/
-- This option (ALTER TABLE ordersview RENAME ClientsOrdersView;) shows an error beacause the function ALTER TABLE can't rename a VIEW, only tables.

RENAME TABLE ordersview TO ClientsOrdersView2;

/*
Task 4: Write a SQL statement to delete the Orders virtual table.
*/

DROP VIEW ClientsOrdersView2;

-- ------------------------------------------------------------------------------------------- Procedures ---------------------------------------------------------------------------------------

/*
Task 1: Write a SQL statement that creates a stored procedure called 'GetOrdersData' which retrieves all data from the Orders table.
After executing the query, call the “GetOrdersData” to show all orders on the MySQL terminal.
*/
CREATE PROCEDURE GetOrdersData()
SELECT * 
FROM orders;

CALL GetOrdersData(); -- test

/*
Task 2: Write a SQL statement that creates a stored procedure called “GetListOfOrdersInRange”. The procedure must contain two parameters that determine the range of retrieved data based on the user input of 
two cost values “MinimumValue” and “MaximumValue”.
Once you have executed the query, call the “GetListOfOrdersInRange” to display the data of orders that cost between $150 and $600. 
*/

CREATE PROCEDURE GetListOfOrdersInRange(MinimumValue INT,MaximumValue INT)
SELECT * 
FROM orders 
WHERE COST BETWEEN MinimumValue AND MaximumValue;

CALL GetListOfOrdersInRange(150, 600); -- test

