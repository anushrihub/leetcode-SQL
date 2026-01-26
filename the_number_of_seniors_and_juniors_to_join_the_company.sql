CREATE TABLE Candidates (
    employee_id INT PRIMARY KEY,
    experience   VARCHAR(10),
    salary       INT
);

INSERT INTO Candidates (employee_id, experience, salary) VALUES
(1,  'Junior', 10000),
(9,  'Junior', 10000),
(2,  'Senior', 20000),
(11, 'Senior', 20000),
(13, 'Senior', 50000),
(4,  'Junior', 40000);

SELECT * FROM Candidates

-- Rank_Table to calculate the cummulative_salary
WITH Rank_Table AS (
  SELECT  experience, 
    SUM(salary) OVER (PARTITION BY experience ORDER BY salary
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cummulative_salary
  FROM Candidates c),
-- Senior_Hired to calculate the hiring number of seniors
Senior_Hired AS (
  SELECT MAX(cummulative_salary) AS senior_salary,COUNT(*) AS num_of_seniors 
    FROM RANK_TABLE
    WHERE experience = 'Senior'
    AND cummulative_salary <= 70000
   ),
-- Junior_Hired to calculate the hiring number of juniors
Junior_Hired AS (
SELECT  MAX(cummulative_salary) AS junior_salary, COUNT(*) AS num_of_juniors FROM Rank_Table
WHERE experience = 'Junior' AND 
cummulative_salary <= (SELECT 70000 - ifnull(senior_salary,0) FROM
Senior_Hired ))
-- To calculate the Senior and Junior candidate number
SELECT 'Senior' as experience, num_of_seniors as accepted_candidates FROM Senior_Hired
UNION 
SELECT 'Junior' as experience, num_of_juniors as accepted_candidates FROM Junior_Hired

