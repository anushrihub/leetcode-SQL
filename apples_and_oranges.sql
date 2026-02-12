-- https://leetcode.com/problems/apples-oranges/description/

CREATE TABLE Sales (
    sale_date DATE,
    fruit VARCHAR(50),
    sold_num INT
);

-- Insert data into Sales
INSERT INTO Sales (sale_date, fruit, sold_num) VALUES
('2020-05-01', 'apples', 10),
('2020-05-01', 'oranges', 8),
('2020-05-02', 'apples', 15),
('2020-05-02', 'oranges', 15),
('2020-05-03', 'apples', 20),
('2020-05-03', 'oranges', 0),
('2020-05-04', 'apples', 15),
('2020-05-04', 'oranges', 16);

-- using case statement
SELECT sale_date, SUM(
    CASE WHEN fruit = 'apples' THEN sold_num 
    WHEN fruit = 'oranges' THEN (sold_num) *-1 END)
    AS diff
FROM Sales
GROUP BY sale_date
ORDER BY sale_date