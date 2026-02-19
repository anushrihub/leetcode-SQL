CREATE TABLE Department_Employee (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

-- Create Employee table
CREATE TABLE Employee_Names (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    departmentId INT
);

INSERT INTO Department_Employee (id, name) VALUES
(1, 'IT'),
(2, 'Sales');

-- Insert data into Employee
INSERT INTO Employee_Names (id, name, salary, departmentId) VALUES
(1, 'Joe', 70000, 1),
(2, 'Jim', 90000, 1),
(3, 'Henry', 80000, 2),
(4, 'Sam', 60000, 2),
(5, 'Max', 90000, 1);

SELECT Department, Employee, Salary
FROM (SELECT DE.name AS Department,EN.name AS Employee, salary, DENSE_RANK() OVER(PARTITION BY departmentId ORDER BY salary DESC) as RNK FROM Department_Employee DE
INNER JOIN Employee_Names EN ON
DE.id = EN.departmentId)t
WHERE RNK = 1
