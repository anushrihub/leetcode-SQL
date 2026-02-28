CREATE TABLE Cust_Orders(
    order_name INT,
    customer_number INT
)

INSERT INTO Cust_Orders(order_name, customer_number) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 3)

SELECT customer_number FROM Cust_Orders
GROUP BY customer_number
ORDER BY COUNT(1) DESC
LIMIT 1
