CREATE TABLE EmpSal(
    id INT,
    salary INT
)

INSERT INTO EmpSal(id, salary) VALUES
(1, 100),
(2, 200),
(3, 300)

-- Using Offset
SELECT(SELECT Salary AS SecondHighestSalary FROM Employee
ORDER BY salary DESC
-- the number of rows required in result set
LIMIT 1
-- the number of rows to skip
Offset 1) AS SecondHighestSalary

-- Using subquery
SELECT Max(salary) AS SecondHighestSalary FROM EmpSal
WHERE salary < (SELECT MAX(salary) FROM EmpSal)

-- Using Window Function
-- if rnk = 2 is not present, then MAX returns null
SELECT MAX(salary) AS SecondHighestSalary
FROM (
    SELECT salary,
           DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM Employee
) t
WHERE rnk = 2;
    