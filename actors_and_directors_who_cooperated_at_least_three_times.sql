CREATE TABLE ActorDirector (
    actor_id INT NOT NULL,
    director_id INT NOT NULL,
    timestamp INT NOT NULL
);

-- Insert data into ActorDirector
INSERT INTO ActorDirector (actor_id, director_id, timestamp) VALUES
(1, 1, 0),
(1, 1, 1),
(1, 1, 2),
(1, 2, 3),
(1, 2, 4),
(2, 1, 5),
(2, 1, 6);

SELECT current, previous, next  FROM(
    SELECT actor_id AS current, 
    LAG(actor_id) OVER(ORDER BY timestamp) AS previous, 
    LEAD(actor_id) OVER(ORDER BY timestamp) AS next,
    LAG(director_id) OVER(ORDER BY timestamp) AS previousd,
    director_id as currentd,
    LEAD(director_id) OVER(ORDER BY timestamp) AS nextd

    FROM ActorDirector )t

WHERE (current = previous AND current = next) AND 
(currentd = previousd AND currentd = nextd)


SELECT actor_id, director_id FROM 
ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT(*) >= 3