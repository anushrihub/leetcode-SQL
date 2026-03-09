CREATE TABLE Cinema(
    seat_id INT,
    free BOOLEAN
)

INSERT INTO Cinema(seat_id, free) VALUES
(1,1),
(2,0),
(3,1),
(4,1),
(5,1)

WITH CTE AS(
SELECT seat_id, free, lag(free,1) OVER(ORDER BY seat_id) AS prev_ava, 
lead(free,1) OVER(ORDER BY seat_id) AS next_ava
FROM Cinema)

SELECT seat_id FROM CTE
WHERE free = 1 AND (prev_ava = 1 or next_ava = 1)