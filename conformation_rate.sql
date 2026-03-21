CREATE TABLE Signups (
    user_id INT,
    time_stamp DATETIME
);

-- Insert data into Signups
INSERT INTO Signups (user_id, time_stamp) VALUES
(3, '2020-03-21 10:16:13'),
(7, '2020-01-04 13:57:59'),
(2, '2020-07-29 23:09:44'),
(6, '2020-12-09 10:39:37');


-- Create Confirmations table
CREATE TABLE Confirmations (
    user_id INT,
    time_stamp DATETIME,
    action VARCHAR(20)
);

-- Insert data into Confirmations
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES
(3, '2021-01-06 03:30:46', 'timeout'),
(3, '2021-07-14 14:00:00', 'timeout'),
(7, '2021-06-12 11:57:29', 'confirmed'),
(7, '2021-06-13 12:58:28', 'confirmed'),
(7, '2021-06-14 13:59:27', 'confirmed'),
(2, '2021-01-22 00:00:00', 'confirmed'),
(2, '2021-02-28 23:59:59', 'timeout');

-- using case and group by 
SELECT Signups.user_id,
IFNULL(ROUND(SUM(CASE WHEN action = 'confirmed' THEN 1 ELSE 0 END)/COUNT(action),2),0) AS confirmation_rate FROM Signups
LEFT JOIN Confirmations
ON Signups.user_id = Confirmations.user_id  
GROUP BY Signups.user_id

-- using CTE
with CTES as (select S.user_id, S.time_stamp, action, case when action = 'confirmed' then 1
when action = 'timeout' then 0 
when action is null then 0 end as status from Signups S left join Confirmations C
on S.user_id = C.user_id)
select user_id, round(sum(status)/ count(status),2) as confirmation_rate  from CTES
group by user_id
