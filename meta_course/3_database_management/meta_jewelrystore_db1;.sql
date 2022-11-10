DROP DATABASE IF EXISTS meta_jewelrystore_db1;

CREATE DATABASE meta_jewelrystore_db1;

USE meta_jewelrystore_db1;

CREATE TABLE item(
ItemID INT, Name VARCHAR(150), 
Cost INT, 
PRIMARY KEY(ItemID)
);

INSERT INTO item VALUES
(1,'Engagement ring',2500),
(2,'Silver brooch',400),
(3,'Earrings',350),
(4,'Luxury watch',1250),
(5,'Golden bracelet',800),
(6,'Gemstone',1500);

CREATE TABLE mg_orders(
OrderID INT, 
ItemID INT,
Quantity INT, 
Cost INT, 
OrderDate DATE, 
DeliveryDate DATE, 
OrderStatus VARCHAR(50), 
PRIMARY KEY(OrderID));

INSERT INTO mg_orders VALUES
(1,1,50,122000,'2022-04-05','2022-05-25', 'Delivered'),
(2,2,75,28000,'2022-03-08',NULL, 'In progress'), 
(3,3,80,25000,'2022-05-19','2022-06-08', 'Delivered'), 
(4,4,45,100000,'2022-01-10',NULL, 'In progress'),
(5,5,70,56000,'2022-05-19',NULL, 'In progress'),
(6,6,60,90000,'2022-06-10','2022-06-18', 'Delivered');

SELECT * FROM meta_jewelrystore_db1.mg_orders;
SELECT * FROM meta_jewelrystore_db1.item;

-- ------------------------------------------------------------------------------------ STRING, MATH and DATE functions -------------------------------------------------------------------------------------------------
/* The main objectives of this activity:
Work with MySQL String, Math, Date and Comparison functions. */

-- Task 1: Write a SQL SELECT query using appropriate MySQL string functions to list items, quantities and order status in the following format:
-- 1 row ex = 'engagement ring-50-DELIVERED'

SELECT CONCAT(LCASE(i.Name), '-',mg.Quantity,'-', UCASE(mg.OrderStatus)) 'Task 1'
FROM item i
INNER JOIN mg_orders mg ON i.ItemID = mg.ItemID;

/* This second option was writhe by Meta teacher - is just a query for two table and don't use a join
SELECT CONCAT(LCASE(Name),'-',Quantity,'-', UCASE(OrderStatus)) 
FROM item,mg_orders 
WHERE item.ItemID = mg_orders.ItemID;
*/
-- Task 2: Write a SQL SELECT query using an appropriate date function and a format string to find the name of the weekday on which M&G’s orders are to be delivered.

SELECT date_format(DeliveryDate, '%W') 'Dia da Entrega' FROM mg_orders;

-- Task 3: Write a SQL SELECT query that calculates the cost of handling each order. This should be 5% of the total order cost. Use an appropriate math function to round that value to 2 decimal places.

SELECT OrderID ID, ROUND(Cost*0.05,2) HandlingCost FROM mg_orders;

-- Task 4: Review the query that you wrote in the second task. Use an appropriate comparison function to filter out the records that do not have a NULL value in the delivery date column.

SELECT date_format(DeliveryDate, '%W') 'Dia da Entrega' FROM mg_orders WHERE DeliveryDate IS NOT NULL;

SELECT DATE_FORMAT(DeliveryDate,'%W') FROM mg_orders WHERE !ISNULL(DeliveryDate) -- another way to query