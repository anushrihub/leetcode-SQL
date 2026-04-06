CREATE TABLE ProductsPrice (
    product_id INT,
    new_price INT,
    change_date DATE
);

-- Insert data
INSERT INTO ProductsPrice (product_id, new_price, change_date) VALUES
(1, 20, '2019-08-14'),
(2, 50, '2019-08-14'),
(1, 30, '2019-08-15'),
(1, 35, '2019-08-16'),
(2, 65, '2019-08-17'),
(3, 20, '2019-08-18');

-- using windows function
SELECT product_id, new_price AS price from( 
select product_id, new_price, DENSE_RANK()OVER(PARTITION BY product_id ORDER BY change_date desc) as RNK from ProductsPrice
where change_date <= '2019-08-16')t
WHERE RNK = 1
Union
-- find the dates which are greater than 16 and provide product_id 10
select product_id, 10 AS price
from ProductsPrice
group by product_id
having min(change_date) > '2019-08-16'




-- using subquery
select product_id, new_price as price from Products
where (product_id, change_date) in 
(select product_id, max(change_date) from Products
where change_date <= '2019-08-16'
group by product_id)
union 
select product_id, 10 as price
from Products
group by product_id
having min(change_date) > '2019-08-16'


