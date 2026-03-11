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
            DENSE_RANK() OVER (
                ORDER BY salary DESC
            ) AS rnk
        FROM Employee
    ) t
WHERE rnk = 2 


-- CTE Approach

WITH CTE AS(
    select salary,
        DENSE_RANK() OVER(
            ORDER BY salary DESC
        ) AS rnk
    FROM Employee
)
select salary
from CTE
where rnk = 2

-- Function
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  DECLARE offset_val INT;

  SET offset_val = N - 1;
  RETURN (
      SELECT salary
      FROM (
          SELECT DISTINCT salary
          FROM employee
          ORDER BY salary DESC
          LIMIT 1 OFFSET offset_val
      ) t
  );
END


