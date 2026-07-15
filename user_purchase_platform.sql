-- https://leetcode.com/problems/user-purchase-platform/description/

CREATE TABLE Spending (
    user_id INT,
    spend_date DATE,
    platform VARCHAR(10),
    amount INT
);

INSERT INTO Spending (user_id, spend_date, platform, amount) VALUES
(1, '2019-07-01', 'mobile', 100),
(1, '2019-07-01', 'desktop', 100),
(2, '2019-07-01', 'mobile', 100),
(2, '2019-07-02', 'mobile', 100),
(3, '2019-07-01', 'desktop', 100),
(3, '2019-07-02', 'desktop', 100);


-- SELECT spend_date, user_id,
-- SUM(amount) AS total_amount
-- FROM Spending
-- where platform in ('desktop', 'mobile')
-- GROUP BY spend_date, user_id



with cte as
(
    select distinct spend_date, 'desktop' as platform from spending
    union
    select distinct spend_date, 'mobile' as platform from spending
    union
    select distinct spend_date, 'both' as platform from spending
),
cte2 as(
select spend_date, user_id
, case  WHEN COUNT(DISTINCT platform) = 1 THEN MAX(platform) 
    when count( distinct platform) = 2 then 'both' end as plat,
    sum(amount) amt
    from Spending
    group by spend_date, user_id)
    
select c.spend_date, c.platform, sum(coalesce(amt,0)) total_amount, count(distinct user_id) total_users
from cte c left join cte2 c2
on c.spend_date = c2.spend_date
and c.platform = c2.plat
group by spend_date, platform