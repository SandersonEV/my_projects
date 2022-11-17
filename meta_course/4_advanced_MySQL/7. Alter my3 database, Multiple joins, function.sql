-- Create a FULL ATER JOIN, CTE, Query Multiple tables

-- FULL OUTER JOIN simulate on MySql
-- To do this you should use the right join, left join and union all

/* SIMULATION OF A FULL OUTER JOIN Syntax

SELECT columns
FROM table1
LEFT JOIN table2 
ON table1.CommomColumn = table2.CommomColumn
UNION ALL -- or use UNION insted of UNION ALL for retrive only the unique records
SELECT columns
FROM table1
RIGHT JOIN table2 
ON table1.CommomColumn = table2.CommomColumn

*/

USE meta_lucky_shrub_my3;

-- Example1:

SELECT o.OrderID, o.Quantity ,p.ProductID, p.ProductName, o.Date
FROM orders o
LEFT JOIN products p ON o.ProductID = p.ProductID
UNION -- Only unique values
SELECT o.OrderID, o.Quantity 'Quantity' ,p.ProductID, p.ProductName, o.Date
FROM orders o
RIGHT JOIN products p ON o.ProductID = p.ProductID;

-- Example2:

SELECT o.OrderID, o.Quantity ,p.ProductID, p.ProductName, o.Date
FROM orders o
LEFT JOIN products p ON o.ProductID = p.ProductID
UNION ALL-- includes repeated values
SELECT o.OrderID, o.Quantity 'Quantity' ,p.ProductID, p.ProductName, o.Date
FROM orders o
RIGHT JOIN products p ON o.ProductID = p.ProductID;


SELECT * FROM meta_lucky_shrub_my3.orders;
SELECT * FROM meta_lucky_shrub_my3.products;

-- ---------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS Clients;

CREATE TABLE Clients (
ClientID VARCHAR(10), 
FullName VARCHAR(100), 
ContactNumber INT, 
AddressID INT);  

DROP TABLE IF EXISTS Addresses;

CREATE TABLE Addresses(
AddressID INT PRIMARY KEY, 
Street VARCHAR(255), 
County VARCHAR(100));  

INSERT INTO Clients(ClientID, FullName, ContactNumber, AddressID) VALUES 
("Cl1", "Takashi Ito", 351786345, 1), 
("Cl2", "Jane Murphy", 351567243, 2), 
("Cl3", "Laurina Delgado", 351342597, 3), 
("Cl4", "Benjamin Clauss", 351342509, 4), 
("Cl5", "Altay Ayhan", 351208983, 5), 
("Cl6", "Greta Galkina", 351298755, 6); 

INSERT INTO Addresses (AddressID, Street, County) VALUES 
(1, "291 Oak Wood Avenue", "Graham County"), 
(2, "724 Greenway Drive", "Pinal County"), 
(3, "102 Sycamore Lane", "Santa Cruz County"), 
(4, "125 Roselawn Close", "Gila County"), 
(5, "831 Beechwood Terrace", "Cochise County"),
(6, "755 Palm Tree Hills", "Mohave County"), 
(7, "751 Waterfall Hills", "Tucson County") , 
(8, "878 Riverside Lane", "Tucson County") , 
(9, "908 Seaview Hills", "Tucson County"), 
(10, "243 Waterview Terrace", "Tucson County"), 
(11, "148 Riverview Lane", "Tucson County"),  
(12, "178 Seaview Avenue", "Tucson County");

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------ Laboratory ---------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
/* TASK 1
Lucky Shrub need to find out how many sycamore trees they’ve sold over the past few years. Sycamore trees have been assigned an ID of P4 in the products table in the database.
Create a query that returns the total quantity of all products with the ID of P4 sold in the years 2020, 2021 and 2022. 
*/

-- Note that the 'Sycamore trees ' copied in the fild has a space saved after the world, so if you don't copy the fild directly from the table you'll end with 0 as the result of the count() function.
-- We can delete the space after the world by updating field to 'Sycamore trees' (with none space):
UPDATE products SET ProductName = 'Sycamore trees' WHERE ProductID = 'P4';
-- Now we can make the Query without problems.


SELECT CONCAT(SUM(Quantity), ' (2020)') AS 'Quantity of Sycamore trees Sold' FROM orders WHERE ProductID = (SELECT ProductID FROM products WHERE ProductName = 'Sycamore trees') AND YEAR(`Date`) = 2020
UNION
SELECT CONCAT(SUM(Quantity), ' (2021)') AS 'Quantity of Sycamore trees Sold' FROM orders WHERE ProductID = (SELECT ProductID FROM products WHERE ProductName = 'Sycamore trees') AND YEAR(`Date`) = 2021
UNION
SELECT CONCAT(SUM(Quantity), ' (2022)') AS 'Quantity of Sycamore trees Sold' FROM orders WHERE ProductID = (SELECT ProductID FROM products WHERE ProductName = 'Sycamore trees') AND YEAR(`Date`) = 2022;


/* TASK 2
Lucky Shrub need information on all their clients and the orders that they placed in the years 2022 and 2021. See if you can help them by extracting the required information from each of the following tables:

• Clients table: The client id and contact number for each client who placed an order
• Addresses table: The street and county for each client’s address
• Orders table: The order id, cost and date of each client’s order.
• Products table: The name of each product ordered.
*/

-- We need to query multiple tables by using multiple inner joins:

SELECT c.ClientID, c.ContactNumber, a.Street, a.County, o.OrderID, p.ProductName, o.Cost, o.Date
FROM addresses a INNER JOIN clients c INNER JOIN orders o INNER JOIN products p
ON(a.AddressID = c.AddressID AND c.ClientID = o.ClientID AND o.ProductID = p.ProductID) 
ORDER BY `Date`;

/* TASK 3
Lucky Shrub needs to analyze the sales performance of their Patio slates (P3) product in the year 2021. Help Lucky Shrub to analyze the performance of this product by developing a function called FindSoldQuantity that enables them to:

Input a ProductID and a year from which they can capture data
and display the total quantity of the product sold in the given year.
*/

DROP FUNCTION IF EXISTS FindSoldQuantity;

DELIMITER //

CREATE FUNCTION FindSoldQuantity(product_id VARCHAR(4), `yeary` INT)

RETURNS INT DETERMINISTIC

BEGIN

DECLARE performance INT;

SET performance = (SELECT SUM(Quantity) FROM orders WHERE ProductID = product_id AND YEAR(`Date`) = yeary);

RETURN performance ;

END //

DELIMITER ;

SELECT FindSoldQuantity('P3', 2021) AS 'Quant. Sales Performance';  -- TEST


-- second option (more simple)

DROP FUNCTION IF EXISTS FindSoldQuantity2;

CREATE FUNCTION FindSoldQuantity2 (product_id VARCHAR(10), YearInput INT)
returns INT DETERMINISTIC 

RETURN (SELECT SUM(Quantity) FROM Orders WHERE ProductID = product_id AND YEAR (Date) = YearInput);

SELECT FindSoldQuantity2 ("P3", 2021);



