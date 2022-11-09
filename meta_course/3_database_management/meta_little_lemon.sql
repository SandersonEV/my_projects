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
(5, "Diana Pinto", 0757536374);

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
(10, '2021-11-11', 7, 5, 1),
(11, '2021-11-10', 5, 2, 2),
(12, '2021-11-10', 3, 2, 4);

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



 