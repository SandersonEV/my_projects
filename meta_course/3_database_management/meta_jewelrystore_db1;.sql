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

CREATE TABLE clients 
(ClientID int NOT NULL, 
ClientName varchar(255) DEFAULT NULL, 
Address varchar(255) DEFAULT NULL, 
ContactNo varchar(10) DEFAULT NULL, 
PRIMARY KEY (ClientID));

INSERT INTO clients VALUES 
(1, 'Kishan Hughes','223 Golden Hills, North Austin, TX','387986345'), 
(2, 'Indira Moncada','119 Silver Street, Bouldin Creek, TX','334567243'), 
(3, 'Mosha Setsile','785 Bronze Lane, East Austin, TX','315642597'), 
(4, 'Laura Mills','908 Diamond Crescent, South Lamar, TX','300842509'), 
(5, 'Henrik Kreida','345, Golden Hills, North Austin, TX','358208983'), 
(6, 'Millicent Blou','812, Diamond Crescent, North Burnet, TX','347898755');

CREATE TABLE client_orders 
(OrderID INT NOT NULL, 
ClientID INT DEFAULT NULL, 
ItemID INT DEFAULT NULL, 
Cost INT DEFAULT NULL, 
PRIMARY KEY (OrderID));

INSERT INTO client_orders VALUES 
(1,1,1,2500), 
(2,2,2,400), 
(3,3,3,350), 
(4,4,4,1250), 
(5,5,5,800), 
(6,6,6,1500), 
(7,2,4,400), 
(8,3,4,1250), 
(9,4,2,400), 
(10,1,3,350); 


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

SELECT DATE_FORMAT(DeliveryDate,'%W') 'Dia da Entrega' FROM mg_orders WHERE !ISNULL(DeliveryDate); -- another way to query

-- ------------------------------------------------------------------------------------ EXTRA tasks -------------------------------------------------------------------------------------------------

/* Task 1: Use the MySQL CEIL function to express the cost after the discount in the form of the smallest integer as follows:
Give a 5% discount to the clients who have ordered luxury watches. Express the cost after the discount in the form of the smallest integer, which is not less than the value shown in the afterDiscount
 column in the result table given below. Use the MySQL CEIL function to do this */

SELECT itemID, ClientID, CEIL(Cost*0.95) AfterDisccount 
FROM client_orders 
WHERE ItemID = (SELECT itemID FROM item WHERE Name = 'Luxury watch');

-- Task 2: Format the afterDiscount column value from the earlier result for 5% discount in '#,###,###.##' format rounded to 2 decimal places using the FORMAT function.
-- The FORMAT function works by formating as a Number (with ',' and '.') and also by input the number of decimals places.

SELECT itemID, ClientID, FORMAT(Cost*0.95, 2) AfterDisccount 
FROM client_orders 
WHERE ItemID = (SELECT itemID FROM item WHERE Name = 'Luxury watch');

-- Task 3: Find the expected delivery dates for their orders. The scheduled delivery date is 30 days after the order date. Use the ADDDATE function.

SELECT OrderID, DATE_FORMAT((ADDDATE(OrderDate, 10)), '%d' ' of ' '%M') 'Scheduled Delivery - 2022', OrderStatus 'Status'
FROM mg_orders
WHERE OrderStatus = 'In progress';

/* Task 4: Generate data required for a report with details of all orders that have not yet been delivered. The DeliveryDate column has a NULL value for orders not yet delivered. 
It would help if you showed a value of 'NOT DELIVERED' instead of showing NULL for orders that are not yet delivered. Use the COALESCE function to do this. */

SELECT OrderID, ItemId, Quantity, Cost, OrderDate, COALESCE(DeliveryDate, 'NOT DELIVERED') 'Delivered Date', OrderStatus
FROM mg_orders
WHERE OrderStatus <> 'Delivered';

-- Task 5: Generate data required for the report by retrieving a list of M&G orders yet to be delivered. These orders have an 'In Progress' status using the NULLIF function.

SELECT OrderID, NULLIF(OrderStatus, 'In progress') 'Status'
FROM mg_orders;