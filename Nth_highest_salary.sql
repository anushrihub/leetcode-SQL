CREATE TABLE Employee (
    id INT PRIMARY KEY,
    salary INT
);

INSERT INTO Employee (id, salary) VALUES
(1, 100),
(2, 200),
(3, 300);

-- Derived Table Approach

SELECT salary
FROM (
        SELECT salary,
            ROW_NUMBER() OVER (
                ORDER BY salary DESC
            ) AS rnk
        FROM Employee
    ) t
WHERE rnk = 2 


-- CTE Approach

WITH CTE AS(
    select salary,
        ROW_NUMBER() OVER(
            ORDER BY salary DESC
        ) AS rnk
    FROM Employee
)
select salary
from CTE
where rnk = 2


