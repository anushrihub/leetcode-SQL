select * from Accounts

CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    income INT NOT NULL
);

INSERT INTO Accounts (account_id, income) VALUES
(3, 108939),
(2, 12747),
(8, 87709),
(6, 91796);

select  'Low Salary' AS category, count(*) As accounts_count from Accounts
where income < 20000
UNION
select  'Average Salary' AS category, count(*) As accounts_count from Accounts
where income between 20000 and 50000
UNION
select  'High Salary' AS category, count(*) As accounts_count from Accounts
where income > 50000


-- using CTE
with cte1 as (
select "Low Salary" as category, count(*) as accounts_count
from Accounts
where income < 20000
order by account_id),
cte2 as (
select "Average Salary" as category, count(*) as accounts_count
from Accounts
where income between 20000 and 50000
order by account_id),
cte3 as (
select "High Salary" as category, count(*) as accounts_count from Accounts
where income > 50000)
select * from cte3
union 
select * from cte1
union 
select * from cte2