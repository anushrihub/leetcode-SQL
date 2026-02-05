CREATE TABLE Activity_II (
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT
);

INSERT INTO Activity_II (player_id, device_id, event_date, games_played) VALUES
(1, 2, '2016-03-01', 5),
(1, 2, '2016-05-02', 6),
(2, 3, '2017-06-25', 1),
(3, 1, '2016-03-02', 0),
(3, 4, '2018-07-03', 5);

-- using subquery
SELECT
  A1.player_id,
  A1.device_id
FROM
  Activity_II A1
WHERE
  (A1.player_id, A1.event_date) IN (
    SELECT
      A1.player_id,
      MIN(A1.event_date)
    FROM
      Activity_II A1
    GROUP BY
      A1.player_id
  );

-- using CTE
WITH Min_Data AS (
        SELECT
      player_id,
      MIN(event_date) AS event_date
    FROM
      Activity_II
    GROUP BY
      player_id
)

SELECT Activity_II.player_id, Activity_II.device_id FROM
Min_Data INNER JOIN Activity_II
ON Min_Data.event_date = Activity_II.event_date

-- using Window function
SELECT player_id, device_id 
FROM (
  SELECT
  player_id,
  device_id,
  MIN(event_date) AS event_date,
  ROW_NUMBER() OVER (
    PARTITION BY player_id
    ORDER BY MIN(event_date) 
  ) AS rnk
FROM Activity_II
GROUP BY player_id, device_id )d
WHERE rnk = 1