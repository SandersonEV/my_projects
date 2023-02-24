CREATE VIEW orders_view AS SELECT orders.OrderID, clients.ClientID, clients.FullName, products.ProductName, orders.Quantity, orders.TotalPrice, delivery.DeliveryStatus, delivery.DeliveryDate,  address.Street 
FROM clients INNER JOIN orders using (ClientID)
INNER JOIN products using (ProductID)
INNER JOIN delivery using (OrderID)
INNER JOIN address using (AddressID);