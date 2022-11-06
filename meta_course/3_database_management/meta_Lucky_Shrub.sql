DROP DATABASE IF EXISTS meta_Lucky_Shrub;

CREATE DATABASE meta_Lucky_Shrub;

USE meta_Lucky_Shrub;

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
OrderID INT NOT NULL PRIMARY KEY,
ClientID VARCHAR(10),
ProductID VARCHAR(10),
Quantity   INT,
Cost DECIMAL(6,2)
);

INSERT INTO orders (OrderID, ClientID, ProductID , Quantity, Cost) VALUES 
(1, "Cl1", "P1", 10, 500), 
(2, "Cl2", "P2", 5, 100), 
(3, "Cl3", "P3", 20, 800), 
(4, "Cl4", "P4", 15, 150), 
(5, "Cl3", "P3", 10, 450), 
(6, "Cl2", "P2", 5, 800), 
(7, "Cl1", "P4", 22, 1200), 
(8, "Cl3", "P1", 15, 150), 
(9, "Cl1", "P1", 10, 500), 
(10, "Cl2", "P2", 5, 100);

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
  EmployeeID int NOT NULL,
  EmployeeName varchar(150) DEFAULT NULL,
  Department varchar(150) DEFAULT NULL,
  ContactNo varchar(12) DEFAULT NULL,
  Email varchar(100) DEFAULT NULL,
  AnnualSalary int DEFAULT NULL,
  PRIMARY KEY (EmployeeID)
);

INSERT INTO employees VALUES /* You don't need to specify the columns name after the table name if you'll insert values into in all the columns */
(1,'Seamus Hogan', 'Recruitment', '351478025', 'Seamus.h@luckyshrub.com',50000), 
(2,'Thomas Eriksson', 'Legal', '351475058', 'Thomas.e@ luckyshrub.com',75000), 
(3,'Simon Tolo', 'Marketing', '351930582','Simon.t@ luckyshrub.com',40000), 
(4,'Francesca Soffia', 'Finance', '351258569','Francesca.s@ luckyshrub.com',45000), 
(5,'Emily Sierra', 'Customer Service', '351083098','Emily.s@ luckyshrub.com',35000), 
(6,'Maria Carter', 'Human Resources', '351022508','Maria.c@ luckyshrub.com',55000),
(7,'Rick Griffin', 'Marketing', '351478458','Rick.G@luckyshrub.com',50000);

DROP TABLE IF EXISTS clients;

CREATE TABLE clients(
ClientID CHAR(3) PRIMARY KEY,
FullName VARCHAR (100),
ContactNumber INT (9),
Address VARCHAR (255)
);

INSERT INTO clients VALUES 
('Cl1','Takashi Ioto', 351786345,'724 Greenway Drive'),
('Cl2','Jane Murphy', 351567243,'102 Sycamore Lane'),
('Cl3','Laurina Delgado', 351342597,'291 Oak Wood Avenue'),
('Cl4','Benjamin Clauss', 351342509,'831 Beechwood Terrace'),
('Cl5','Altay Ayhan', 351208983,'755 Palm Tree Hills'),
('Cl6','Greta Galkina', 351298755,'831 Beechwood Terrace');


-- Just some basic commands down here ---------------------------------------------------------------------------------------------------------------------------------------

/* Task 1: Write a SQL statement to print all records of orders where the cost is $250 or less */
SELECT * FROM Orders WHERE Cost <= 250;

/* Task 2: Write a SQL statement to print all records of orders where the cost is between $50 and $750 */
SELECT * FROM Orders WHERE Cost BETWEEN 50 AND 750;
SELECT * FROM Orders WHERE Cost >= 50 AND COST <= 750;

/* Task 3: Write a SQL statement to print all records of orders that have been placed by the client with the id of Cl3 and where the cost of the order is more than $100 */
SELECT * FROM Orders WHERE ClientID = 'Cl3' and Cost > 100;

/* Task 4: Write a SQL statement to print all records of orders that have a product id of p1 or p2 and the order quantity is more than 2 */
SELECT * FROM Orders WHERE Quantity > 2 AND ProductID IN ('p1','p2');
SELECT * FROM Orders WHERE ProductID = "P1" OR ProductID = "P2" AND Quantity > 2;

/*  AND, Aliases, NOT, IN, BETWEEN, LIKE ----------------------------------------- SAME DATABASE BUT A DIFFERENT TABLE (employees) -------------------------------------------------------------------------------- */
/* Aliases can rename a column or a TABLE */
/* Aliases can be used with the CONCAT function. Ex: SELECT CONCAT(column1, ' ', cloumn2) AS 'new column name' */
/* Aliases with speces between names should have quotation mark "" or '' */

-- Task 1: Use the AND operator to find employees who earn an annual salary of $50,000 or more attached to the Marketing department.
SELECT EmployeeID AS Identificação, EmployeeName AS 'Nome do Funcionário' FROM employees WHERE AnnualSalary >= 50000 AND Department = 'Marketing' ;

-- Task 2: Use the NOT operator to find employees not earning over $50,000 across all departments.
SELECT EmployeeID Identificação, EmployeeName 'Nome do Funcionário' FROM employees WHERE NOT AnnualSalary > 50000 ;
SELECT EmployeeID Identificação, EmployeeName 'Nome do Funcionário' FROM employees WHERE AnnualSalary <= 50000 ;
 
-- Task 3: Use the IN operator to find Marketing, Finance, and Legal employees whose annual salary is below $50,000. 
SELECT EmployeeID Identificação, EmployeeName 'Nome do Funcionário' FROM employees WHERE AnnualSalary < 50000 AND Department IN ('Marketing', 'Finance', 'Legal')  ;

-- Task 4: Use the BETWEEN operator to find employees who earn annual salaries between $10,000 and $50,000.
SELECT EmployeeID Identificação, EmployeeName 'Nome do Funcionário' FROM employees WHERE AnnualSalary BETWEEN 10000 AND 50000  ;

-- Task 5: Use the LIKE operator to find employees whose names start with ‘S’ and are at least 4 characters in length.
SELECT EmployeeID Identificação, EmployeeName 'Nome do Funcionário' FROM employees WHERE EmployeeName LIKE 'S___%';

/* When using the LIKE operator in conjuction with '_' or '%' :

_ = only holds one letter
% = can be zero o more letters
*/

/* SQL Alias for multiple tables:

SELECT x.clumn1, x.cloumn2, y.column1, y.column2
FROM table_1 AS c, table_2 AS y 
WHERE x.column2 < 12 AND column2 < 5;

(Usually is used when you have a Join that obrigates you to express the tables when you declaring the columns that you need in the query)
*/
-- --------------------------------------------------------------------------------------- JOINs ---------------------------------------------------------------------------------------------------------

SELECT * FROM X

