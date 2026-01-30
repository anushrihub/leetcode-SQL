CREATE TABLE Failed (
    fail_date DATE
);

-- Insert data into Failed table
INSERT INTO Failed (fail_date) VALUES
('2018-12-28'),
('2018-12-29'),
('2019-01-04'),
('2019-01-05');

-- Create Succeeded table
CREATE TABLE Succeeded (
    success_date DATE
);

-- Insert data into Succeeded table
INSERT INTO Succeeded (success_date) VALUES
('2018-12-30'),
('2018-12-31'),
('2019-01-01'),
('2019-01-02'),
('2019-01-03'),
('2019-01-06');

SELECT * FROM Failed
SELECT * FROM Succeeded

-- combine all the dates
WITH all_states AS (
SELECT 'failed' AS period_state ,fail_date AS dates
FROM Failed 
UNION ALL 
SELECT 'succeeded' AS period_state , success_date AS dates      
FROM Succeeded ),

-- partition the dates as per the states
state_dates AS (
SELECT *,
   row_number() over(partition by period_state order by dates) as rn
FROM all_states
WHERE dates BETWEEN '2019-01-01' AND '2019-01-31')

-- group on the state and date
select period_state, 
       min(dates) as start_date,
       max(dates) as end_date
from state_dates
group by period_state 
, date_sub(dates, INTERVAL rn day)
order by 1
