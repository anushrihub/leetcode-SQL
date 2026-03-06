CREATE TABLE ActivityV (
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT
);

INSERT INTO ActivityV (player_id, device_id, event_date, games_played) VALUES
(1, 2, '2016-03-01', 5),
(1, 2, '2016-03-02', 6),
(2, 3, '2017-06-25', 1),
(3, 1, '2016-03-01', 0),
(3, 4, '2016-07-03', 5);

WITH CTE AS(
    SELECT player_id, event_date,
    lead(event_date) over(partition by player_id order by event_date) as next_date, 
min(event_date) over(partition by player_id order by event_date) as install_date
from ActivityV
)

SELECT install_date AS install_dt, COUNT(DISTINCT player_id) AS installs,
ROUND(SUM(CASE WHEN datediff(next_date, install_date) = 1 THEN 1 ELSE 0 END)/
COUNT(DISTINCT player_id),2) AS Day1_retention FROM CTE
GROUP BY install_dt

