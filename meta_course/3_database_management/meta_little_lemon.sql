DROP DATABASE IF exists meta_little_lemon;

CREATE DATABASE meta_little_lemon;

USE meta_little_lemon;

CREATE TABLE Customers(
CustomerID INT NOT NULL PRIMARY KEY,
FullName VARCHAR(100) NOT NULL,
PhoneNumber INT NOT NULL UNIQUE
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
NumberOfGuests INT NOT NULL CHECK (NumberOfGuests <= 8),
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
 
 




