CREATE TABLE Department (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE DepartmentEmployee (
    id INT,
    name VARCHAR(50),
    salary INT,
    departmentId INT,
    FOREIGN KEY (departmentId) REFERENCES Department(id)
);

INSERT INTO Department (id, name) VALUES
(1, 'IT'),
(2, 'Sales');

INSERT INTO DepartmentEmployee (id, name, salary, departmentId) VALUES
(1, 'Joe', 85000, 1),
(2, 'Henry', 80000, 2),
(3, 'Sam', 60000, 2),
(4, 'Max', 90000, 1),
(5, 'Janet', 69000, 1),
(6, 'Randy', 85000, 1),
(7, 'Will', 70000, 1);

SELECT * FROM Department
SELECT * FROM DepartmentEmployee

WITH
  EmployeesWithRankInDepartment AS (
    SELECT
      Department.name AS department,
      dept.name AS employee,
      dept.salary,
      DENSE_RANK() OVER(
        PARTITION BY dept.departmentId
        ORDER BY dept.salary DESC
      ) AS `rank`
    FROM Department
    INNER JOIN Employee dept
      ON (Department.id = dept.departmentId )
  )
SELECT
  department AS Department,
  employee AS Employee,
  salary AS Salary
FROM EmployeesWithRankInDepartment
WHERE `rank` <= 3;
