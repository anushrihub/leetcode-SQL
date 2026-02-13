-- https://leetcode.com/problems/product-sales-analysis-iii/description/

CREATE TABLE Product_Sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    year INT,
    quantity INT,
    price INT
);

INSERT INTO Product_Sales (sale_id, product_id, year, quantity, price)
VALUES
(1, 100, 2008, 10, 5000),
(2, 100, 2009, 12, 5000),
(7, 200, 2011, 15, 9000);

SELECT product_id, year as first_year,quantity, price
FROM Product_Sales WHERE (product_id, year) IN
(SELECT product_id ,min(year) FROM Product_Sales
GROUP BY product_id)

