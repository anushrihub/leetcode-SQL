-- Create Product table

CREATE TABLE SalesProduct (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    unit_price INT NOT NULL
);


-- Insert data into Product
INSERT INTO SalesProduct (product_id, product_name, unit_price)
VALUES
    (1, 'S8', 1000),
    (2, 'G4', 800),
    (3, 'iPhone', 1400);

-- Create Sales table
CREATE TABLE SalesAnalysis (
    seller_id INT NOT NULL,
    product_id INT NOT NULL,
    buyer_id INT NOT NULL,
    sale_date DATE NOT NULL,
    quantity INT NOT NULL,
    price INT NOT NULL
);

-- Insert data into Sales
INSERT INTO SalesAnalysis (seller_id, product_id, buyer_id, sale_date, quantity, price)
VALUES
    (1, 1, 1, '2019-01-21', 2, 2000),
    (1, 2, 2, '2019-02-17', 1, 800),
    (2, 2, 3, '2019-06-02', 1, 800),
    (3, 3, 4, '2019-05-13', 2, 2800);


-- Sales Analysis I
WITH SalesTotal AS (
    SELECT seller_id, SUM(price) as Prize from SalesAnalysis
    GROUP BY seller_id
)
SELECT seller_id from SalesTotal
where Prize = (select max(Prize) from SalesTotal)

-- Sales Analysis II
SELECT buyer_id FROM SalesProduct INNER JOIN SalesAnalysis
ON SalesProduct.product_id = SalesAnalysis.product_id
group by buyer_id
having sum(product_name = 'S8') > 0 and 
sum(product_name = 'iphone') =0 

-- Sales Analysis III

select product_id, product_name from SalesProduct
where product_id in (
    select product_id from SalesAnalysis
    GROUP BY product_id
    having min(sale_date) >= '2019-01-01' and
    MAX(sale_date) <= '2019-03-31'
)
