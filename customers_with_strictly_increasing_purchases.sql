CREATE TABLE Customer_Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    price INT
);

-- Insert data into Orders table
INSERT INTO Customer_Orders (order_id, customer_id, order_date, price) VALUES
(1, 1, '2019-07-01', 1100),
(2, 1, '2019-11-01', 1200),
(3, 1, '2020-05-26', 3000),
(4, 1, '2021-08-31', 3100),
(5, 1, '2022-12-07', 4700),
(6, 2, '2015-01-01', 700),
(7, 2, '2017-11-07', 1000),
(8, 3, '2017-01-01', 900),
(9, 3, '2018-11-07', 900);


-- My logic
WITH YEARLY AS (
    SELECT customer_id, YEAR(order_date) as y, SUM(price) as total
    FROM Orders
    GROUP BY customer_id, y
),
DIFF AS(
    SELECT customer_id, y, total,
           LAG(y) OVER (PARTITION BY customer_id ORDER BY y) AS diff,
           LAG(total) OVER (PARTITION BY customer_id ORDER BY y) AS incre_total
    FROM YEARLY
)
SELECT customer_id
FROM DIFF
GROUP BY customer_id
HAVING SUM(
    CASE 
        WHEN diff IS NOT NULL 
             AND (y - diff != 1 OR total <= incre_total)
        THEN 1
        ELSE 0
    END
) = 0;

-- With slight changes
WITH yearly AS (
    SELECT 
        customer_id,
        YEAR(order_date) AS y,
        SUM(price) AS total
    FROM Customer_Orders
    GROUP BY customer_id, YEAR(order_date)
),
DIFF AS (
    SELECT 
        customer_id,
        y,
        LAG(y) OVER (PARTITION BY customer_id ORDER BY y) AS last,
        RANK() OVER (PARTITION BY customer_id ORDER BY y) AS rnky,
        RANK() OVER (PARTITION BY customer_id ORDER BY total) AS rnkp
    FROM yearly
)

SELECT DISTINCT customer_id
FROM DIFF
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM DIFF
    WHERE last IS NOT NULL
      AND ((y - last) != 1 OR rnky != rnkp)
);