CREATE TABLE Employee_Cumulative(
    id INT,
    month INT,
    salary INT
)

INSERT INTO Employee_Cumulative(id, month, salary) VALUES
(1, 1, 20),
(2, 1, 20),
(1, 2, 30),
(2, 2, 30),
(3, 2, 40),
(1, 3, 40),
(3, 3, 60),
(1, 4, 60),
(3, 4, 70),
(1, 7, 90),
(1, 8, 90);

-- remove the last month's data 
WITH cte1 AS (
select * from Employee_Cumulative where (month, id) not in
    (select max(month) as m, id from Employee_Cumulative group by id)),
-- find the salary for last 3 months
cte2 AS ( 
select *, lag(salary,1,0)OVER(PARTITION BY id ORDER BY month) as prev_sal,
lag(salary,2,0)OVER(PARTITION BY id ORDER BY month) as second_prev_sal,
lag(month,1,0)OVER(PARTITION BY id ORDER BY month) as prev_month,
lag(month,2,0)OVER(PARTITION BY id ORDER BY month) as second_prev_month
FROM cte1
)
-- find the 
SELECT id, month, 
CASE WHEN month - prev_month = 1 and prev_month - second_prev_month = 1 THEN
salary + prev_sal + second_prev_sal
WHEN month - prev_month = 1 then salary + prev_sal ELSE salary END AS Salary
FROM cte2
ORDER BY id ASC, month DESC