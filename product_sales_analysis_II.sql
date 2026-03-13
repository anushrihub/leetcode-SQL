CREATE TABLE ProductI (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL
);

-- Insert data into Product table
INSERT INTO ProductI (product_id, product_name) VALUES
(100, 'Nokia'),
(200, 'Apple'),
(300, 'Samsung');

CREATE TABLE SalesI (
    sale_id INT PRIMARY KEY,
    product_id INT NOT NULL,
    year INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

-- Insert data into Sales table
INSERT INTO SalesI (sale_id, product_id, year, quantity, price) VALUES
(1, 100, 2008, 10, 5000),
(2, 100, 2009, 12, 5000),
(7, 200, 2011, 15, 9000);

SELECT S.product_id,SUM(quantity) AS total_quantity FROM SalesI S INNER JOIN ProductI P
ON S.product_id = P.product_id 
GROUP BY product_id