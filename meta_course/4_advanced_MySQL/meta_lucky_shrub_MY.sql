-- ----------------------------------------------------------------------------------------- ADVANCED MYSQL TOPICS -----------------------------------------------------------------------------------------
-- FUNCTIONS, PROCEDURES, VARIABLES... (BEGIN)

-- DOING BY MYSELF: This D2 is not the task but is one that i'm seeing in the current lesson so I want to create the database using only the output of the tables to practice while i'm watching the lesson.
-- I'll Type the command DROP (database and table) a lot of times but this is just for the propouse of learn. Because i'll modify the table and the database sometimes.

DROP DATABASE IF EXISTS meta_lucky_shrub_MY;

CREATE DATABASE meta_lucky_shrub_MY;

USE meta_lucky_shrub_MY; 

DROP TABLE IF EXISTS orders;

CREATE TABLE orders(
OrderID INT PRIMARY KEY,
ClientID VARCHAR(4) NOT NULL,
ProductID VARCHAR(3) NOT NULL,
Quantity INT NOT NULL,
Cost DECIMAL(10,2),
`Date` DATE NOT NULL
);

TRUNCATE TABLE orders;

INSERT INTO orders VALUES 
(1,'Cl1','P1', 10, 500, '2020-09-01'),
(2,'Cl2','P2', 5, 100, '2020-09-05'),
(3,'Cl3','P3', 20, 800, '2020-09-03'),
(4,'Cl4','P4', 15, 150, '2020-09-07'),
(5,'Cl5','P5', 10, 450, '2020-09-08'),
(6,'Cl6','P6', 5, 800, '2020-09-09'),
(7,'Cl7','P7', 22, 1200, '2020-09-10'),
(8,'Cl8','P8', 15, 150, '2020-09-10'),
(9,'Cl9','P9', 10, 500, '2020-09-12'),
(10,'Cl10','P10', 5, 100, '2020-09-13')
;

CREATE TABLE products (
ProductID VARCHAR(4) PRIMARY KEY,
ProductName VARCHAR(255) NOT NULL,
Price DECIMAL(10,2)  NOT NULL,
NumberOfItems INT
);

INSERT INTO products VALUES
('P1','Artificial Grass Bags',50,100),
('P2','Wood Panels',20,250),
('P3','Patio Slates',40,60),
('P4','Sycamore Trees',10,50),
('P5','Trees and Shrubs',50,75),
('P6','Water Fountain',80,15);

-- ---------------------------------------------------------------------------------------------- functions ---------------------------------------------------------------------------------

-- 1 - This function is to apply a discount based in the Amount of the Product:

-- You should determine the data type to output. deterministic function means that this function always result in the same output every time they are called
-- The propouse of this function is to apply a discount in the Cost and the IFs should select the right discount deppending of the Amount of the Cost.

DELIMITER //
CREATE FUNCTION GetTotalCost(Cost DECIMAL(10,2)) 
RETURNS DECIMAL(10,2) DETERMINISTIC 
BEGIN
	IF (Cost >= 100 AND Cost < 500) THEN 
		SET Cost = Cost - (Cost * 0.1);
	ELSEIF (Cost >= 500) THEN 
		SET Cost = Cost - (Cost * 0.2);
	END IF;
RETURN (Cost); -- The variable to return
END// 
DELIMITER ; 
-- Restart de delimiter to the original ';'

SELECT GetTotalCost(400); -- As the cost is greater then 100 and less then 500 the function will apoly 10% of discount.
SELECT GetTotalCost(800); -- As the cost is greater then 500 the function will apply 20% of discount.

DROP FUNCTION GetTotalCost; -- To DROP the FUNCTION

-- -------------------------------------------------------------------------------------- More complex Procedures ----------------------------------------------------------------------------------
-- GetProductSummary
-- This procedure return the quantity of the produts that cost less than 50 dolars and the quantity of the products that cost more or equal a 50 dolars.

-- OBS: I'll ALTER the table to add a new row of data so we can see differents amouts when We make the CALL Procedure:
REPLACE INTO products VALUES ('P7','Cama Box',150,10); -- The replace function is used because maybe i'll repeat the execution of this code, I don't want the error when use the INSERT and the primary key exists in the table.

DROP PROCEDURE IF EXISTS GetProductSummary;
-- When creating complex stored procedures, you must change the delimiter from a semi-colon to another delimiter sign so that MySQL can compile your code in a BEGIN-END block as one compound statement.

-- IMPORTANT: During the procedure creation you should avoid to make a comments, only after and before the DELIMITER.

DELIMITER // 
CREATE PROCEDURE GetProductSummary (OUT NumberOfLowPriceProducts INT, OUT NumberOfHighPriceProducts INT)
BEGIN 
	SELECT COUNT(ProductID) INTO NumberOfLowPriceProducts FROM products WHERE Price < 50;
	SELECT COUNT(ProductID) INTO NumberOfHighPriceProducts FROM products WHERE Price >= 50;
END //
DELIMITER ;

CALL GetProductSummary(@Quant_low_price_products,@Qaunt_high_price_products); -- The response to this procedure will be stored in this two variables.

SELECT @Quant_low_price_products 'Produtos abaixo de 50 dolares', @Qaunt_high_price_products 'Produtos de dolares ou mais'; -- To look the variable.

/* -------------------------------------------------------------------- Difference of Functions and Procedures ----------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

A function returns a single value, whereas a procedure may return a single value, multiple values or no value. 

Typically, functions encapsulate common formulas or generic business rules that are reusable among SQL statements and stored procedures. Procedures, on the other hand, are used mainly to process, 
manipulate and modify data in the database.

Functions only accept input parameters, while stored procedures can accept IN, OUT and INOUT parameters.

Functions can be invoked from anywhere, including SELECT statements and stored procedures. Stored procedures are invoked using the CALL statement only.   

 A stored function is created using the CREATE FUNCTION statement. A stored procedure is created using the CREATE PROCEDURE statement. 

To build a function, you should specify if it is a DETERMINISTIC function or not. This means that you need to decide if the function always returns the same result for the same input parameters.
If you don't use DETERMINISTIC, then MySQL uses the NOT DETERMINISTIC option by default.     

To build functions you must specify the data type of the return value in the RETURNS statement. This can be any valid MySQL data type. However, there’s no need to do this with stored procedures. 
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
*/
/* Task 1: Create a SQL function that prints the cost value of a specific order based on the user input of the OrderID. The expected output result should be the same as the result in the screenshot below when you
 call the function with an OrderID of 5. */
 
DROP FUNCTION IF EXISTS FindCost;
 
DELIMITER //
CREATE FUNCTION FindCost(id INT) 
RETURNS DECIMAL(10,2) DETERMINISTIC
	BEGIN
		DECLARE cost2 DECIMAL(10,2);
        SELECT cost FROM orders WHERE OrderID = id INTO cost2;
		RETURN (cost2);
	END //
DELIMITER ;
 
SELECT FindCost(3); -- test
SELECT OrderID, FindCost(OrderId) 'Custo' FROM orders; -- test

DROP FUNCTION IF EXISTS FindCost;

-- ------------------------------------------------------------------------- SECOND OPTION TO COMPLETE THE TASK 1:

DROP FUNCTION IF EXISTS FindCost2;

DELIMITER //
CREATE FUNCTION FindCost2(id INT) 
RETURNS DECIMAL(10,2) DETERMINISTIC
	BEGIN
		DECLARE cost2 DECIMAL(10,2);
        SET cost2 = (SELECT cost FROM orders WHERE OrderID = id);
		RETURN (cost2);
	END //
DELIMITER ;
 
SELECT FindCost2(3); -- test
SELECT OrderID, FindCost2(OrderId) 'Custo' FROM orders; -- test

-- --------------------------------------------------------------------------- THIRD OPTION TO COMPLETE THE TASK 1:

DROP FUNCTION IF EXISTS FindCost3;

DELIMITER //
CREATE FUNCTION FindCost3(id INT) 
RETURNS DECIMAL(10,2) DETERMINISTIC
	BEGIN
	RETURN (SELECT cost FROM orders WHERE OrderID = id);
	END //
DELIMITER ;
 
SELECT FindCost3(3); -- test
SELECT OrderID, FindCost3(OrderId) 'Custo' FROM orders; -- test
 
-- --------------------------------------------------------------------------- FOURTH OPTION TO COMPLETE THE TASK 1:
 
DROP FUNCTION IF EXISTS FindCost4;

DELIMITER //
CREATE FUNCTION FindCost4(id INT) 
RETURNS DECIMAL(10,2) DETERMINISTIC
	BEGIN
    DECLARE cost2 DECIMAL(10,2);
     SELECT cost INTO cost2 FROM orders WHERE OrderID = id;
	RETURN (cost2);
	END //
DELIMITER ;
 
SELECT FindCost4(3); -- test
SELECT OrderID, FindCost4(OrderId) 'Custo' FROM orders; -- test


/*  Task 2: Create a stored procedure called GetDiscount. This stored procedure must return the final cost of the customer's order after the discount value has been deducted

The procedure should take one parameter that accepts a user input value of an OrderID. 

The procedure must find the order quantity of the specificOrderID. 

If the value of the order quantity is more than or equal to 20 then the procedure should return the new cost after a 20% discount. 

If the value of the order quantity is less than 20 and more than or equal to 10 then the procedure should return the new cost after a 10% discount.
*/


DROP PROCEDURE IF EXISTS GetDiscount1;

DELIMITER // 

CREATE PROCEDURE GetDiscount1(OrderIdInput INT)
BEGIN
	DECLARE current_price DECIMAL(10,2);
	DECLARE priceAfterDiscount1 DECIMAL(10,2);
	DECLARE quantity2 INT;
    SELECT Quantity INTO quantity2 FROM orders WHERE orders.OrderID = OrderIdInput;
    SELECT Cost INTO current_price FROM orders WHERE orders.OrderID = OrderIdInput;
		IF (quantity2 >= 20) THEN
		SET priceAfterDiscount1 = current_price * 0.8;
		ELSEIF (quantity2 < 20 AND quantity2 = 10) THEN
        SET priceAfterDiscount1 = current_price * 0.9;
		ELSE SET priceAfterDiscount1 = current_price;
        END IF;
        SELECT priceAfterDiscount1;
END //

DELIMITER ;

CALL GetDiscount1(5); -- TEST

-- --------------------------------------------------------------------------- SECOND OPTION TO COMPLETE THE TASK 2:
-- Now i'll try to output a variable @priceAfterDiscount2 and delete the SELECT statement in the past procedure to call the variable after the call of the procedure (at the end)
-- Maybe you can replace the OUT parameter using a variable inside of the procedure:

DROP PROCEDURE IF EXISTS GetDiscount2;

DELIMITER //

CREATE PROCEDURE GetDiscount2(OrderIdInput INT)
BEGIN
	DECLARE current_price DECIMAL(10,2);
	DECLARE quantity2 INT;
    SELECT Quantity INTO quantity2 FROM orders WHERE orders.OrderID = OrderIdInput;
    SELECT Cost INTO current_price FROM orders WHERE orders.OrderID = OrderIdInput;
		IF (quantity2 >= 20) THEN
		SET @priceAfterDiscount2 := current_price * 0.8;
		ELSEIF (quantity2 < 20 AND quantity2 = 10) THEN
        SET @priceAfterDiscount2 := current_price * 0.9;
		ELSE SET @priceAfterDiscount2 := current_price;
        END IF;
END //

DELIMITER ;

CALL GetDiscount2(5); -- TEST
SELECT @priceAfterDiscount2; -- ok (output a variable in the procedure but fist you'll need to call the procedure with an OrderId)

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------- TRIGGERS -------------------------------------------------------------------------------------------
-- Actions that happens after alteration on database this action can be: INSERT, UPDATE OR DELETE.alter.

/* A TRIGGER can be invoked before of ater an action:
    -> BEFORE = TRIGGER -> ACTION -> ROW (
    -> AFTER  = ACTION  -> ROW    -> TRIGGER
The syntax from both (bafore and after) triggers are the same.
*/
/* MySQL TRIGGER syntax:
CREATE TRIGGER trigger_name
BEFORE INSERT -- Here you should specify when the TRIGGER will work (before or after) and the command to look (insert, delete or update)
ON table_name FOR EACH ROW -- A table to watch and how the trigger will perform (in each row of the table)
BEGIN
	
END

*/

-- For exemple: let's say that Luck Shrub need that none negative number can be inputed in the orders.Quantity field and if it's a negative number you'll update to 0:

DROP TRIGGER IF EXISTS no_negativeQ;

DELIMITER //

CREATE TRIGGER no_negativeQ
BEFORE INSERT 
ON orders FOR EACH ROW
BEGIN
	IF NEW.Quantity < 0 THEN -- In a trigger you'll have two operators to track the value modification (NEW and OLD).
		SET NEW.Quantity = 0;
	END IF;
END //

DELIMITER ;

INSERT INTO orders VALUES (11, 'Cl11','P11',-5,69,'2020-04-26');  -- TEST the trigger
SELECT * FROM meta_lucky_shrub_my.orders; -- check if it's working (OK)

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------- SCHEDULED EVENTS --------------------------------------------------------------------------------------------
-- Events that must be completed at a specific time (creation of reports or logs)
-- They can be executed onw time or recurring

/* One-time scheduled event syntax -----------------------------------------------------------------------------------------
CREATE event_name
ON SCHEDULE AT CURRENT_TIMESTAMP [+ INTERVAL]
DO
BEGIN
	Evente_body
END
*/

-- This table should be created to make the Report of the data obout the orders table.
-- IN the current date and time the schedule event will insert into the reportdata table all records of the orders table filtered by dates specified.

DROP TABLE IF EXISTS reportdata;  -- This table was created just to help with tasks of the Scheduled event.
CREATE TABLE reportdata (OrderID INT, ClientID VARCHAR(4), ProductID VARCHAR(4), Quantity INT, Cost DECIMAL(10,2), `Date` DATE);

-- Example:

DROP EVENT IF EXISTS RevenueReport1one; -- One time scheduled event.

DELIMITER //

CREATE EVENT RevenueReport1one
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 2 MINUTE
DO
BEGIN
	INSERT INTO reportdata (OrderID, ClientID, ProductID, Quantity, Cost, `Date`)
	SELECT *
    FROM orders
    WHERE `Date` BETWEEN '2020-09-01' AND '2020-09-07';
END //

DELIMITER ;

SELECT * FROM meta_lucky_shrub_my.reportdata; -- check if it's working (OK)

/* Recurring scheduled event syntax ----------------------------------------------------------------------------------------------

CREATE EVENT event_name
ON SCHEDULE
EVERY [+ INTERVAL]
DO
BEGIN
	event_body
END
*/

-- Example:

DROP EVENT IF EXISTS DailyRestock;

DELIMITER //

CREATE EVENT recurringEvent
ON SCHEDULE EVERY 1 DAY DO -- To set a recurring event you should use the 'EVERY'  (Every one day this evente occours)
BEGIN
	IF (products.NumberOfItems) < 50 THEN
		UPDATE products SET NumberOfItems = 50; 
	END IF;

END //


SELECT * FROM meta_lucky_shrub_my.products;
