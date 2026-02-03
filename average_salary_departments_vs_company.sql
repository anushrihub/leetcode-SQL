CREATE TABLE Salary (
    id INT PRIMARY KEY,
    employee_id INT NOT NULL,
    amount INT NOT NULL,
    pay_date DATE NOT NULL
);

INSERT INTO Salary (id, employee_id, amount, pay_date) VALUES
(1, 1, 9000, '2017-03-31'),
(2, 2, 6000, '2017-03-31'),
(3, 3, 10000, '2017-03-31'),
(4, 1, 7000, '2017-02-28'),
(5, 2, 6000, '2017-02-28'),
(6, 3, 8000, '2017-02-28');


-- Employee table
CREATE TABLE Employee_Salary (
    employee_id INT PRIMARY KEY,
    department_id INT NOT NULL
);

INSERT INTO Employee_Salary (employee_id, department_id) VALUES
(1, 1),
(2, 2),
(3, 2);

SELECT * FROM Employee_Salary
SELECT * FROM Salary

WITH dept_avg AS (
    SELECT
        DATE_FORMAT(s.pay_date, '%Y-%m') AS pay_month,
        es.department_id,
        AVG(s.amount) AS dept_avg_salary
    FROM Employee_Salary es
    JOIN Salary s
        ON es.employee_id = s.employee_id
    GROUP BY pay_month, es.department_id
),
company_avg AS (
    SELECT
        DATE_FORMAT(pay_date, '%Y-%m') AS pay_month,
        AVG(amount) AS company_avg_salary
    FROM Salary
    GROUP BY pay_month
)

SELECT
    d.pay_month,
    d.department_id,
    CASE
        WHEN d.dept_avg_salary > c.company_avg_salary THEN 'higher'
        WHEN d.dept_avg_salary < c.company_avg_salary THEN 'lower'
        ELSE 'same'
    END AS comparison
FROM dept_avg d
JOIN company_avg c
    ON d.pay_month = c.pay_month;