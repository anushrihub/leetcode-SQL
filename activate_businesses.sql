CREATE TABLE Events (
    business_id INT,
    event_type VARCHAR(50),
    occurrences INT
);

INSERT INTO Events (business_id, event_type, occurrences)
VALUES
    (1, 'reviews', 7),
    (3, 'reviews', 3),
    (1, 'ads', 11),
    (2, 'ads', 7),
    (3, 'ads', 6),
    (1, 'page views', 3),
    (2, 'page views', 12);
    
WITH CTE AS (
    SELECT event_type,
           AVG(occurrences) AS avg_occurrences
    FROM Events
    GROUP BY event_type
)
SELECT business_id
FROM Events e
JOIN CTE c
ON e.event_type = c.event_type
WHERE e.occurrences > c.avg_occurrences
GROUP BY business_id
HAVING COUNT(*) > 1;
