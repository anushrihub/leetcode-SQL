CREATE TABLE EmpSalary(
    id INT ,
    name CHAR,
    sex CHAR ,
    salary INT
)


INSERT INTO EmpSalary (id, name, sex, salary)
VALUES
(1, 'A', 'm', 2500),
(2, 'B', 'f', 1500),
(3, 'C', 'm', 5500),
(4, 'D', 'f', 500);

SELECT * FROM EmpSalary

UPDATE EmpSalary
SET sex = CASE WHEN sex = 'm' THEN 'f'
WHEN sex = 'f' THEN 'm'
END