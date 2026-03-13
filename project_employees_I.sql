SELECT * FROM PojectEmployee

SELECT * FROM Project

SELECT project_id, ROUND(AVG(experience_years), 2) AS average_years FROM PojectEmployee
INNER JOIN Project
ON PojectEmployee.employee_id = Project.employee_id
GROUP BY project_id