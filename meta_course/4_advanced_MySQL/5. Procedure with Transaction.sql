/*
In This activity you'll create a transaction to check if the stock (products.NumberOfItems) has enough itens before of commit of the creation of the order. 

(Probably it's a better option if i put some commands (SET, SELECT, INSERT) inside of the IF statment to be more optimezed and don't make some unnecessary steps if there is no stock.But writing the code like 
this i can see more clearly the use of the ROLLBACK AND COMMIT commands)
*/

USE meta_lucky_shrub_my;

DROP PROCEDURE IF EXISTS pedido;

DELIMITER //

CREATE PROCEDURE peedido (client_id VARCHAR(4), product_id VARCHAR(4), quant_order INT) 

BEGIN

DECLARE quant_disponivel INT;
DECLARE cost INT;
DECLARE order_id INT;

SET quant_disponivel = (SELECT NumberOfItems FROM products WHERE ProductID = product_id);
-- SELECT NumberOfItems INTO quant_disponivel FROM products WHERE ProductID = product_id; -- second option

START TRANSACTION; -- You can also use the 'BEGIN' or 'BEGIN WORK' to start the transanction 

	SET cost = (SELECT SellPrice * quant_order FROM products WHERE ProductID = product_id);
	SELECT OrderID + 1 INTO order_id FROM orders ORDER BY OrderID DESC LIMIT 1; -- second option 
    
	INSERT INTO orders VALUES (order_id, client_id, product_id, quant_order, cost, NOW());
	UPDATE products SET NumberOfItems = (NumberOfItems - quant_order) WHERE ProductID = product_id;

IF (quant_disponivel - quant_order) >= 0 THEN

	SELECT 'Pedido realizado com sucesso';
	COMMIT;
    
ELSE

	SELECT 'Não existem itens suficientes no estoque para executar o seu pedido';
	ROLLBACK;
    
END IF;
END //

DELIMITER ;

CALL pedido('Cl12','P4',40); -- test
SELECT * FROM products;
SELECT * FROM orders;

-- OK
