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

-- using subquery
SELECT product_id, year as first_year,quantity, price
FROM Product_Sales WHERE (product_id, year) IN
(SELECT product_id ,min(year) FROM Product_Sales
GROUP BY product_id)

-- using join
SELECT Sales.product_id, Sales.year AS first_year,quantity, price FROM Sales
INNER JOIN 
(SELECT product_id,MIN(YEAR) AS first_year FROM Sales
GROUP BY product_id) AS Sales2
ON Sales.product_id = Sales2.product_id AND
Sales.year = Sales2.first_year

-- using CTE
WITH CTE AS (
    SELECT product_id, MIN(year) AS first_year FROM Product_Sales
    GROUP BY product_id
)

SELECT CTE.product_id, first_year, quantity, price FROM CTE INNER JOIN Product_Sales
ON CTE.product_id = Product_Sales.product_id AND CTE.first_year = Product_Sales.year