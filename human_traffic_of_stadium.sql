CREATE TABLE Stadium (
    id INT PRIMARY KEY,
    visit_date DATE,
    people INT
);

-- Insert data
INSERT INTO Stadium (id, visit_date, people) VALUES
(1, '2017-01-01', 10),
(2, '2017-01-02', 109),
(3, '2017-01-03', 150),
(4, '2017-01-04', 99),
(5, '2017-01-05', 145),
(6, '2017-01-06', 1455),
(7, '2017-01-07', 199),
(8, '2017-01-09', 188);

-- Using window function
WITH base AS (
        SELECT *,
            LEAD(id, 1) OVER(ORDER BY id) AS next_id,
            LEAD(id, 2) OVER(ORDER BY id) AS second_next_id,
            LAG(id, 1) OVER(ORDER BY id) AS last_id,
            LAG(id, 2) OVER(ORDER BY id) AS second_last_id
        FROM stadium
        WHERE people >= 100 
        )
SELECT visit_date, people, id, next_id,
second_next_id, last_id FROM base
WHERE (next_id - id = 1 AND  id - last_id = 1)
OR (second_next_id - next_id = 1 AND next_id - id = 1)
OR (id - last_id = 1 AND last_id - second_last_id = 1)
ORDER BY visit_date