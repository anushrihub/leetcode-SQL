-- https://leetcode.com/problems/customers-who-bought-all-products/description/

CREATE TABLE Customer (
    customer_id INT,
    product_key INT
);

CREATE TABLE Product (
    product_key INT PRIMARY KEY
);

-- Insert data into Product table
INSERT INTO Product (product_key) VALUES
(5),
(6);



-- Insert data into Customer table
INSERT INTO Customer (customer_id, product_key) VALUES
(1, 5),
(2, 6),
(3, 5),
(3, 6),
(1, 6);

SELECT customer_id FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) =
(SELECT COUNT(product_key) FROM
Product)