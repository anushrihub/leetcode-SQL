-- Create Employee table
CREATE TABLE PojectEmployee (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    experience_years INT
);

-- Insert data into Employee table
INSERT INTO PojectEmployee (employee_id, name, experience_years) VALUES
(1, 'Khaled', 3),
(2, 'Ali', 2),
(3, 'John', 1),
(4, 'Doe', 2);

-- Create Project table
CREATE TABLE Project (
    project_id INT,
    employee_id INT
);

-- Insert data into Project table
INSERT INTO Project (project_id, employee_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 4);

WITH CTE AS(
    SELECT project_id, count(*) as CNT FROM Project
    GROUP BY project_id
)
SELECT project_id FROM CTE
WHERE CNT = (SELECT MAX(CNT) FROM CTE )