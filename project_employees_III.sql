CREATE TABLE EmployeeIII (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    experience_years INT
);

-- Insert data into Employee table
INSERT INTO EmployeeIII (employee_id, name, experience_years) VALUES
(1, 'Khaled', 3),
(2, 'Ali', 2),
(3, 'John', 3),
(4, 'Doe', 2);

-- use existing project table 
-- SELECT * FROM Project

WITH CTE AS
(
SELECT project_id, Project.employee_id AS employee_id , experience_years,
RANK() OVER(PARTITION BY project_id ORDER BY experience_years DESC) AS rnk
FROM Project INNER JOIN 
EmployeeIII ON
Project.employee_id = EmployeeIII.employee_id
)
SELECT project_id, employee_id
FROM CTE
WHERE rnk = 1