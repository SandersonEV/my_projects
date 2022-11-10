DROP DATABASE IF exists meta_little_lemon;

CREATE DATABASE meta_little_lemon;

USE meta_little_lemon;

CREATE TABLE Customers(
CustomerID INT NOT NULL PRIMARY KEY,
FullName VARCHAR(100) NOT NULL, 
PhoneNumber INT NOT NULL UNIQUE -- The unique constraint means that no other row in the column can hold the same data.
);

INSERT INTO Customers(CustomerID, FullName, PhoneNumber) VALUES 
(1, "Vanessa McCarthy", 0757536378), 
(2, "Marcos Romero", 0757536379), 
(3, "Hiroki Yamane", 0757536376), 
(4, "Anna Iversen", 0757536375), 
(5, "Diana Pinto", 0757536374),     
(6, "Altay Ayhan", 0757636378),      
(7, "Jane Murphy", 0753536379),      
(8, "Laurina Delgado", 0754536376),      
(9, "Mike Edwards", 0757236375),     
(10, "Karl Pederson", 0757936374);

CREATE TABLE Bookings (
BookingID INT NOT NULL PRIMARY KEY,
BookingDate DATE NOT NULL,
TableNumber INT NOT NULL,
NumberOfGuests INT NOT NULL CHECK (NumberOfGuests <= 8), -- The CHECK is used to limit the value that you can place in the column.
CustomerID INT NOT NULL,
FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID) ON DELETE CASCADE ON UPDATE CASCADE); /* This means that if the CustumerID in the Custumers table is deleted or updated the CustumerID
in the Booking table also do the same thing (delete or update) */

-- DELETE CASCADE: When we create a foreign key using this option, it deletes the referencing rows in the child table when the referenced row is deleted in the parent table which has a primary key.
-- UPDATE CASCADE: When we create a foreign key using UPDATE CASCADE the referencing rows are updated in the child table when the referenced row is updated in the parent table which has a primary key.

INSERT INTO Bookings (BookingID, BookingDate, TableNumber, NumberOfGuests, CustomerID) VALUES 
(10, '2021-11-10', 7, 5, 1),  
(11, '2021-11-10', 5, 2, 2),  
(12, '2021-11-10', 3, 2, 4), 
(13, '2021-11-11', 2, 5, 5),  
(14, '2021-11-11', 5, 2, 6),  
(15, '2021-11-11', 3, 2, 7), 
(16, '2021-11-11', 3, 5, 1),  
(17, '2021-11-12', 5, 2, 2),  
(18, '2021-11-12', 3, 2, 4), 
(19, '2021-11-13', 7, 5, 6),  
(20, '2021-11-14', 5, 2, 3),  
(21, '2021-11-14', 3, 2, 4);

CREATE TABLE Courses (
CourseName VARCHAR(255) PRIMARY KEY,
Cost Decimal(4,2)
);

INSERT INTO Courses (CourseName, Cost) VALUES 
("Greek salad", 15.50), 
("Bean soup", 12.25), 
("Pizza", 15.00), 
("Carbonara", 12.50), 
("Kabasa", 17.00), 
("Shwarma", 11.30);

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* Task 1: Little Lemon want a list of all customers who have made bookings. Write an INNER JOIN SQL statement to combine the full name and the phone number of each customer
 from the Customers table with the related booking date and 'number of guests' from the Bookings table. */
 
SELECT c.FullName Nome, c.PhoneNumber Telefone, b.BookingDate 'Data da Reserva', b.NumberOfGuests 'Número de Convidados'
FROM customers c INNER JOIN bookings b 
ON c.CustomerID = b.CustomerID;
 
 /* Task 2: Little Lemon want to view information about all existing customers with bookings that have been made so far. This data must include customers who haven’t made any booking yet. */
 
SELECT c.FullName Nome, c.PhoneNumber Telefone, b.TableNumber , b.BookingDate 'Data da Reserva', b.NumberOfGuests 'Número de Convidados'
FROM customers c LEFT JOIN bookings b 
ON c.CustomerID = b.CustomerID;

-- ----------------------------------------------------------- WEEK 2 - constraints ------------------------------------------
/*
1- KEY CONSTRAINTS - PRIMARY KEY, FOREIGN KEY, UNIQUE...
2- DOMAIN CONSTRAINTS - INT (3)
3- REFERENTIAL INTEGRITY CONSTRAINTS -In a relational database, tables are connected via a foreign key in one table linked to a primary key (or a unique key) in another table. 
This implies that the value of the foreign key column in the ‘referencing’ table must also exist in the referenced table. Otherwise, you will end up with a problem as the 
“connection” between the records of the tables will cease.  
*/

-- ------------------------------------------------------------------------------- EXTRA TASKS USING ALTER TABLE variations --------------------------------------------------------------------

-- Create a new table in the Little Lemon restaurant database to store information about customers' orders. The new “Food Orders” table includes three columns:

CREATE TABLE FoodOrders (
OrderID INT, 
Quantity INT, 
Cost Decimal(4,2));
SHOW COLUMNS FROM FoodOrders;

-- Task 1: Use the ALTER TABLE statement with MODIFY command to make the OrderID the primary key of the 'FoodOrders' table. 
ALTER TABLE foodorders MODIFY OrderID INT NOT NULL PRIMARY KEY;
SHOW COLUMNS FROM FoodOrders;

-- Task 2: Apply the NOT NULL constraint to the quantity and cost columns.
ALTER TABLE foodorders MODIFY Quantity INT NOT NULL DEFAULT 0;
SHOW COLUMNS FROM FoodOrders;

-- Task 3: Create two new columns, OrderDate with a DATE datatype and CustomerID with an INT datatype. Declare both must as NOT NULL. Declare the CustomerID as a foreign key in the FoodOrders table to reference the CustomerID column existing in the Customers table.
ALTER TABLE foodorders ADD COLUMN OrderDate DATE NOT NULL, ADD COLUMN CustomerID INT NOT NULL, ADD FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID);
SHOW COLUMNS FROM FoodOrders;

-- Task 4: Use the DROP command with ALTER statement to delete the OrderDate column from the 'FoodOrder' table. 
ALTER TABLE foodorders DROP COLUMN OrderDate;
SHOW COLUMNS FROM FoodOrders;

-- Task 5: Use the CHANGE command with ALTER statement to rename the COLUMN Quantity in the foodorders table to Quant. 
ALTER TABLE foodorders CHANGE Quantity Quant INT NOT NULL DEFAULT 0;
SHOW COLUMNS FROM FoodOrders;

-- Task 6: Use the RENAME command with ALTER statement to change the TABLE NAME from foodorders to ifood.
ALTER TABLE foodorders RENAME ifood;
SHOW COLUMNS FROM ifood;

-- -------------------------------------------------------------------------------------- COURSE RECAP ------------------------------------------------------------------------------------
-- In this task you can find a recap of some of the commands learned during this course.


/* Task 1: Filter data using the WHERE clause and logical operators.

Create SQL statement to print all records from Bookings table for the following bookings dates using the BETWEEN operator: 2021-11-11 and 2021-11-13. 
*/

SELECT *
FROM bookings
WHERE BookingDate BETWEEN '2021-11-11' AND '2021-11-13';


/* Task 2: Create a JOIN query.

Create a JOIN SQL statement on the Customers and Bookings tables. The statement must print the customers full names and related bookings IDs from the date 2021-11-11.
*/

SELECT c.FullName, b.BookingID
FROM customers c
RIGHT JOIN bookings b ON c.CustomerID = b.CustomerID -- RIGHT JOIN to show every booking ID from the bookings table
WHERE BookingDate = '2021-11-11';

/* Task 3: Create a GROUP BY query.

Create a SQL statement to print the bookings dates from Bookings table. The statement must show the total number of bookings placed on each of the printed dates using the GROUP BY BookingDate. 
*/

SELECT BookingDate, COUNT(BookingDate) 'Quantidade de Marcações'
FROM bookings
GROUP BY BookingDate;

/* Task 4: Create a REPLACE statement.

Create a SQL REPLACE statement that updates the cost of the Kabsa course from $17.00 to $20.00. The expected output result should be the same as that shown in the following screenshot:
*/

REPLACE INTO courses (CourseName, Cost) VALUES ('Kabasa', 19);
REPLACE INTO courses SET CourseName = 'Kabasa', Cost = 20; -- other way

-- For me the best way to do this is to update the value without change all the valuews in the colum:
UPDATE courses SET Cost = 10 WHERE CourseName = 'Kabasa'; -- this function only change one fiel in the row.


/* Task 5: Create constraints

Create a new table called "DeliveryAddress" in the Little Lemon database with the following columns and constraints:

ID: INT PRIMARY KEY
Address: VARCHAR(255) NOT NULL
Type: NOT NULL DEFAULT "Private"
CustomerID: INT NOT NULL FOREIGN KEY referencing CustomerID in the Customers table
*/

DROP TABLE IF EXISTS DeliveryAddress;

CREATE TABLE DeliveryAddress (
DeliveryAddressID INT PRIMARY KEY,
Address VARCHAR(255) NOT NULL,
Type VARCHAR(55) NOT NULL DEFAULT 'Private',
CustomerID INT NOT NULL,
FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID)
);


/* Task 6: Alter table structure

Create a SQL statement that adds a new column called 'Ingredients' to the Courses table.
*/

ALTER TABLE courses ADD COLUMN Ingredients VARCHAR(255);

/* Task 7: Create a subquery

Create a SQL statement with a subquery that prints the full names of all customers who made bookings in the restaurant on the following date: 2021-11-11.
*/

SELECT FullName 
FROM customers
WHERE CustomerID IN (SELECT CustomerID FROM bookings WHERE BookingDate = '2021-11-11');


/* Task 8: Create a virtual table

Create the "BookingsView" virtual table to print all bookings IDs, bookings dates and the number of guests for bookings made in the restaurant before 2021-11-13 and where number of guests is larger than 3.
*/

DROP VIEW IF EXISTS BookingsView;
CREATE VIEW BookingsView AS
SELECT BookingID, BookingDate, NumberOfGuests
FROM bookings
WHERE BookingDate < '2021-11-13' AND NumberOfGuests > 3;

SELECT * FROM BookingsView; -- Just to test

/* Task 9: Create a stored procedure

Create a stored procedure called 'GetBookingsData'. The procedure must contain one date parameter called "InputDate". This parameter retrieves all data from the Bookings table based on the user input of the date.

After executing the query, call the "GetBookingsData" with '2021-11-13' as the input date passed to the stored procedure to show all bookings made on that date.
*/

DROP PROCEDURE IF EXISTS GetBookingsData;
CREATE PROCEDURE GetBookingsData(InputDate DATE)
SELECT *
FROM bookings
WHERE BookingDate = InputDate;

CALL GetBookingsData('2021-11-13');

/* Task 10: Use the String function

Create a SQL SELECT query using appropriate MySQL string function to list "Booking Details" including booking ID, booking date and number of guests. The data must be listed in the same format as the following example:
ID: 10, 
Date: 2021-11-10, 
Number of guests: 5
*/

SELECT CONCAT("ID: ", BookingID,', Date: ', BookingDate,', Number of guests: ', NumberOfGuests) AS "Booking Details" FROM Bookings;

