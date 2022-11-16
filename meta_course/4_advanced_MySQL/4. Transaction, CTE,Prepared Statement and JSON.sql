--  Transactions 
-- The objective of this transaction is to create a new order of 10 products (P1) and then reduce the total amout of products using the productID to make the relation between the two tables. 

USE meta_lucky_shrub_my;
SELECT * FROM meta_lucky_shrub_my.orders; -- Inspect the rows and the columns of the table.
SELECT * FROM meta_lucky_shrub_my.products;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------- Transaction ROLLBACK -----------------------------------------------------------------------
START TRANSACTION;

INSERT INTO orders VALUES (12,'C11','P1', 10, 500, '2022-09-30'); -- create a new order
UPDATE products SET NumberOfItems = (NumberOfItems - 10) WHERE ProductID ='P1'; -- Update the amout of products after placing the order

SELECT o.OrderID 'ID do Pedido', o.Quantity 'Quant. Pedido', o.ClientID 'ID do Cliente', o.ProductID 'ID do Produto', p.ProductName 'Nome do Produto', p.NumberOfItems 'Quant. Total'
FROM orders o INNER JOIN products p ON o.ProductID = p.ProductID; -- check the modification

ROLLBACK; -- I'll reverse the modification to the original database because I've inserted the ClientID = 'C11' and was supposed to be ClientID = C1 (The ROLLBACK command is to reverse the transaction)

SELECT * FROM meta_lucky_shrub_my.orders; -- check the rollback
SELECT * FROM meta_lucky_shrub_my.products; 

/* You can see that everything that modifies the database between the START TRANSACTION and the ROLLBACK was undone. 
The ROLLBACK is to reverse the database modifications maked in the transaction
*/
-- ----------------------------------------------------------------- Transaction COMMIT -----------------------------------------------------------------------
START TRANSACTION;

INSERT INTO orders VALUES (12,'C1','P1', 10, 500, '2022-09-30'); -- create a new order with the correct ClientID
UPDATE products SET NumberOfItems = (NumberOfItems - 10) WHERE ProductID ='P1'; -- Update the amout of products after placing the order

SELECT o.OrderID 'ID do Pedido', o.Quantity 'Quant. Pedido', o.ClientID 'ID do Cliente', o.ProductID 'ID do Produto', p.ProductName 'Nome do Produto', p.NumberOfItems 'Quant. Total'
FROM orders o INNER JOIN products p ON o.ProductID = p.ProductID; -- check the modification

COMMIT; -- Now We'll use the commit is to confirm the modification and set as everthing okay

SELECT * FROM meta_lucky_shrub_my.orders; -- check the commit
SELECT * FROM meta_lucky_shrub_my.products; 

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------- CTE -----------------------------------------------------------------------------
-- ------------------------------------------------------------- Common Table expression query -----------------------------------------------------------------


/* Syntax for a Single CTE (Common Table expression query)

WITH cte_name1 AS (query1),
SELECT * FROM cte_name1

*/

/* Syntax for a  CTE with multiple queries.
WITH 
		cte_name1 AS (query1),
		cte_name2 AS (query2),
		cte_name3 AS (query3),
SELECT * FROM cte_name1 -- The union is not always necessary 
UNION
SELECT * FROM cte_name2
UNION
SELECT * FROM cte_name3,
*/
-- Exemple: They need to know the average cost order of each year separately

USE meta_lucky_shrub_my2; -- for the exemple i'll use the meta_lucky_shrub_my2.oders (database.table).
SELECT * FROM orders;

-- The commom way to make this is by creating a union between queries to use one time.
SELECT CONCAT(AVG(Cost),' (2020)') 'Average Sale' FROM orders WHERE YEAR(`Date`) = 2020
UNION
SELECT CONCAT(AVG(Cost),' (2021)') 'Average Sale' FROM orders WHERE YEAR(`Date`) = 2021
UNION
SELECT CONCAT(AVG(Cost),' (2022)') 'Average Sale' FROM orders WHERE YEAR(`Date`) = 2022;

-- Using the CTE:

WITH
avg2020 AS (SELECT CONCAT(AVG(Cost),' (2020)') 'Average Sale' FROM orders WHERE YEAR(`Date`) = 2020),
avg2021 AS (SELECT CONCAT(AVG(Cost),' (2021)') 'Average Sale' FROM orders WHERE YEAR(`Date`) = 2021),
avg2022 AS (SELECT CONCAT(AVG(Cost),' (2022)') 'Average Sale' FROM orders WHERE YEAR(`Date`) = 2022)
SELECT * FROM avg2020
UNION
SELECT * FROM avg2021
UNION
SELECT * FROM avg2022;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------ Prepared Statement -----------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Is a prepared Statement just waiting for a variable to fill out the query

PREPARE GetOrderStatement FROM 'SELECT ClientID, ProductId, Quantity, Cost FROM Orders WHERE OrderID = ?';

SET @order_id = 10;

EXECUTE GetOrderStatement USING @order_id;
SELECT ClientID, ProductId, Quantity, Cost FROM orders WHERE OrderID = @order_id; -- check (This is the same thing but now i wrote the entire code)

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------- JSON -----------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Activity(
ActivityID INT PRIMARY KEY,
Properties JSON -- JSON provides database optimization by storing data in simple text format.
);

INSERT INTO Activity(ActivityID, Properties) VALUES
(1, '{"ClientID": "Cl1", "ProductID":"P1", "Order": "True"}'),
(2, '{"ClientID": "Cl2", "ProductID":"P2", "Order": "False"}'),
(3, '{"ClientID": "Cl3", "ProductID":"P3", "Order": "True"}'); -- (The use of ' or " metters here)

-- To retrieve de data inside of the JSON list in the table:

SELECT ActivityID, Properties->'$.ClientID' 'ClientID', Properties->'$.ProductID' AS 'ProductID', Properties->'$.Order' FROM Activity;








