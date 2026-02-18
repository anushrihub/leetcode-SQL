CREATE TABLE Employee_Manager (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    managerId INT
);

-- Insert data into Employee table
INSERT INTO Employee_Manager (id, name, salary, managerId) VALUES
(1, 'Joe', 70000, 3),
(2, 'Henry', 80000, 4),
(3, 'Sam', 60000, NULL),
(4, 'Max', 90000, NULL);

-- using self join
SELECT E.name as Employee FROM Employee_Manager E JOIN
Employee_Manager M
ON E.managerId = M.id
WHERE E.salary > M.salary
