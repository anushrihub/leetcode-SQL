-- https://leetcode.com/problems/median-employee-salary/description/

CREATE TABLE Median_Employee(
    id INT PRIMARY KEY,
    company VARCHAR(10),
    salary INT
);

INSERT INTO Median_Employee (id, company, salary) VALUES
(1, 'A', 2341),
(2, 'A', 341),
(3, 'A', 15),
(4, 'A', 15314),
(5, 'A', 451),
(6, 'A', 513),
(7, 'B', 15),
(8, 'B', 13),
(9, 'B', 1154),
(10, 'B', 1345),
(11, 'B', 1221),
(12, 'B', 234),
(13, 'C', 2345),
(14, 'C', 2645),
(15, 'C', 2645),
(16, 'C', 2652),
(17, 'C', 65);


WITH CTE AS (
SELECT *, ROW_NUMBER()OVER(PARTITION BY company ORDER BY salary) AS rnk,
count(*)OVER(PARTITION BY company) AS count
FROM Median_Employee
)
SELECT id, company, salary FROM
CTE
WHERE (count % 2 = 0 and rnk = count/2 + 1) 
OR (count % 2 = 0 and rnk = count/2)
OR (count % 2 = 1 and rnk = (count + 1)/2)
