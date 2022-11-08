DROP DATABASE IF EXISTS meta_luckyshrub_db3; 
CREATE DATABASE meta_luckyshrub_db3; 
USE meta_luckyshrub_db3; 
CREATE TABLE employees (
  EmployeeID int NOT NULL,
  EmployeeName varchar(150) DEFAULT NULL,
  Department varchar(150) DEFAULT NULL,
  ContactNo varchar(12) DEFAULT NULL,
  Email varchar(100) DEFAULT NULL,
  AnnualSalary int DEFAULT NULL,
  PRIMARY KEY (EmployeeID)
);

CREATE TABLE orders (
  OrderID int NOT NULL,
  Department varchar(100) DEFAULT NULL,
  OrderDate date DEFAULT NULL,
  OrderQty int DEFAULT NULL,
  OrderTotal int DEFAULT NULL,
  PRIMARY KEY (OrderID)
);

CREATE TABLE employee_orders (
 OrderID int NOT NULL,
 EmployeeID int NOT NULL,
 Status VARCHAR(150),
 HandlingCost int DEFAULT NULL,
 PRIMARY KEY (EmployeeID,OrderID),
 FOREIGN KEY (EmployeeID) REFERENCES employees(EmployeeID),
 FOREIGN KEY (OrderID) REFERENCES orders(OrderID)
);

INSERT INTO employees VALUES 
(1,'Seamus Hogan', 'Recruitment', '351478025', 'Seamus.h@luckyshrub.com',50000), 
(2,'Thomas Eriksson', 'Legal', '351475058', 'Thomas.e@luckyshrub.com',75000), 
(3,'Simon Tolo', 'Marketing', '351930582','Simon.t@luckyshrub.com',40000), 
(4,'Francesca Soffia', 'Finance', '351258569','Francesca.s@luckyshrub.com',45000), 
(5,'Emily Sierra', 'Customer Service', '351083098','Emily.s@luckyshrub.com',35000), 
(6,'Maria Carter', 'Human Resources', '351022508','Maria.c@luckyshrub.com',55000),
(7,'Rick Griffin', 'Marketing', '351478458','Rick.G@luckyshrub.com',50000);

INSERT INTO orders VALUES(1,'Lawn Care','2022-05-05',12,500),
(2,'Decking','2022-05-22',150,1450),
(3,'Compost and Stones','2022-05-27',20,780),
(4,'Trees and Shrubs','2022-06-01',15,400),
(5,'Garden Decor','2022-06-10',2,1250),
(6,'Lawn Care','2022-06-10',12,500),
(7,'Decking','2022-06-25',150,1450),
(8,'Compost and Stones','2022-05-29',20,780),
(9,'Trees and Shrubs','2022-06-10',15,400),
(10,'Garden Decor','2022-06-10',2,1250),
(11,'Lawn Care','2022-06-25',10,400), 
(12,'Decking','2022-06-25',100,1400),
(13,'Compost and Stones','2022-05-30',15,700), 
(14,'Trees and Shrubs','2022-06-15',10,300), 
(15,'Garden Decor','2022-06-11',2,1250),
(16,'Lawn Care','2022-06-10',12,500), 
(17,'Decking','2022-06-25',150,1450), 
(18,'Trees and Shrubs','2022-06-10',15,400), 
(19,'Lawn Care','2022-06-10',12,500), 
(20,'Decking','2022-06-25',150,1450), 
(21,'Decking','2022-06-25',150,1450); 

INSERT INTO employee_orders 
VALUES(1,3,"In Progress",200), 
(1,5,"Not Recieved",300), 
(1,4,"Not Recieved",250), 
(2,3,"Completed",200), 
(2,5,"Completed",300), 
(2,4,"In Progress",250), 
(3,3,"In Progress",200), 
(3,5,"Not Recieved",300), 
(3,4,"Not Recieved",250), 
(4,3,"Completed",200), 
(4,5,"In Progress",300), 
(4,4,"In Progress",250), 
(5,3,"Completed",200), 
(5,5,"In Progress",300), 
(5,4,"Not Recieved",250), 
(11,3,"Completed",200), 
(11,5,"Completed",300), 
(11,4,"Not Recieved",250), 
(14,3,"Completed",200), 
(14,5,"Not Recieved",300), 
(14,4,"Not Recieved",250); 

-- Task1: Use the ANY operator to identify all employees with the Order Status status 'Completed'. 
/* 
The ANY operator returns a boolean value following a comparison operation. It returns a TRUE value if ANY subquery values meet the given condition. 
In other words, the condition will be TRUE if the operation is true for any of the values in the range.
*/

SELECT EmployeeID ID, EmployeeName Nome
FROM employees
WHERE EmployeeID = ANY (SELECT EmployeeID FROM employee_orders WHERE Status = "Completed" ); /* Verify if exists any matches between the results of the subquery that uses the employee_orders table
in the EmployeeID from the employees table. Subqueries works like a Join in some cases but i don't need keys */

-- Other three optins to complete the Task1:
SELECT EmployeeID ID, EmployeeName Nome
FROM employees
WHERE EmployeeID IN (SELECT EmployeeID FROM employee_orders WHERE Status = "Completed" ); /* You can also have the same results using the 'IN' operator */

SELECT e.EmployeeID ID, e.EmployeeName 'Nome do Funcionário', COUNT(e.EmployeeName) 'Nº de Pedidos Completos'
FROM employees e
INNER JOIN employee_orders eo ON e.EmployeeID = eo.EmployeeID
WHERE eo.Status = "Completed"
GROUP BY e.EmployeeName
ORDER BY COUNT(e.EmployeeName) DESC;

SELECT e.EmployeeID ID, e.EmployeeName 'Nome do Funcionário', COUNT(e.EmployeeName) 'Nº de Pedidos Completos'
FROM employees e
RIGHT JOIN employee_orders eo ON e.EmployeeID = eo.EmployeeID
WHERE eo.Status = "Completed"
GROUP BY e.EmployeeName
ORDER BY COUNT(e.EmployeeName) DESC; /* You can also make this task using the RIGHT JOIN because he asks to everyone with the status completed in the right table (this option looks more correct for me) */

-- Task 2: Use the ALL operator to identify the IDs of employees who earned a handling cost of "more than 20% of the order value" from all orders they have handled.
/* 
Use the ALL operator for the same purpose as the ANY operator. However, the way it works is a little bit different. It returns a boolean value as a result of performing a comparison operation.
 It returns TRUE only if ALL subquery values meet the given condition. In other words, the condition will be TRUE only if the operation is true for all values in the range. 
*/
SELECT DISTINCT EmployeeID Identificação
FROM employee_orders
WHERE HandlingCost > ALL(SELECT ROUND(o.OrderTotal* 0.2) FROM orders o); 

-- Other ways to complete this task:
SELECT EmployeeID Identificaçao, EmployeeName Nome, Department Departamento
FROM employees
WHERE
EmployeeID IN (SELECT DISTINCT EmployeeID Identificação
FROM employee_orders
WHERE HandlingCost > ALL(SELECT ROUND(o.OrderTotal* 0.2) FROM orders o)
); 

-- In this question I understood that I should calculate the SUM() and not every item separeted. So i did something more difficut and i'll keep beacause is a good query to learn

/* It's a subquery with a LEFT JOIN - the propouse is of this query is too see if the SUM(n.HandlingCost) from the employees_orders table is greater 
than the SUM(n.OrderTotal)*0.2 from the orders table
*/
SELECT n.EmployeeID ID, 
CASE WHEN SUM(n.OrderTotal)*0.2 > SUM(n.HandlingCost) = 1 THEN 'Yes' ELSE 'No' END AS 'Foi maior?'
FROM (
SELECT eo.EmployeeID, o.OrderTotal,eo.HandlingCost
FROM employee_orders eo
LEFT JOIN orders o ON eo.OrderID = o.OrderID
) AS n
GROUP BY n.EmployeeID
HAVING SUM(n.HandlingCost) > SUM(n.OrderTotal)*0.2;

-- 1 - in the subquery with the JOIN I create another table 'n' with the important data to answer the task. 
-- 2 - in the out query I grouped usind the ID as the parameter and maked the sum of the others
-- 3 - Than I've use a filter (HAVING - when the filter has agregation function) to filter using the requested filter in the task
-- Extra: Basically, you use CASE statment to convert from bit answer (1 or 0) to the values yes or no.
-- (Obs: This query don't answer exactly the task because he makes the SUM() of all HandlingCost and OrderTotal of each specified EmployeeID and make the calculation of the Total)

-- Task 3: Use the GROUP BY clause to summarize the duplicate records with the same column values into a single record by grouping them based on those columns.

/*
SELECT EmployeeID,HandlingCost   
FROM employee_orders   
WHERE HandlingCost > ALL(SELECT ROUND(OrderTotal/100 * 20) FROM orders) GROUP BY EmployeeID,HandlingCost;
*/

-- Task 4: Use the HAVING clause to filter the grouped data in the subquery that you wrote in task 3 to filter the 20% OrderTotal values to only retrieve values that are more than $100.

/*
SELECT EmployeeID,HandlingCost 
FROM employee_orders  
WHERE HandlingCost > ALL(SELECT ROUND(OrderTotal/100 * 20) AS twentyPercent FROM orders  GROUP BY OrderTotal  
HAVING twentyPercent > 100)  GROUP BY EmployeeID,HandlingCost;     
*/