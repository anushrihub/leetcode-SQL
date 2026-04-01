CREATE TABLE Primary_Dept_Employee (
    employee_id INT,
    department_id INT,
    primary_flag CHAR(1)
);

-- Insert data
INSERT INTO Primary_Dept_Employee (employee_id, department_id, primary_flag) VALUES
(1, 1, 'N'),
(2, 2, 'N'),
(2, 1, 'Y'),
(3, 3, 'N'),
(4, 2, 'N'),
(4, 3, 'Y'),
(4, 4, 'N');



select employee_id,department_id from Primary_Dept_Employee
where primary_flag = 'Y'
Union
-- used SUM because we have to return the department id
select employee_id, SUM(department_id) as department_id  from Primary_Dept_Employee
group by employee_id
-- keeps the department with count 1
having count(department_id) = 1
order by employee_id asc