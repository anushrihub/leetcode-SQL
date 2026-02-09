CREATE TABLE Point2D(
    x INT,
    y INT
)

INSERT INTO Point2D (x, y) VALUES
(-1, -1),
(0, 0), 
(-1, -2)

-- using CTE
WITH CTE AS (
SELECT P1.x as x1, P1.y as y1, 
P2.x as x2, P2.y as y2  FROM Point2D P1
CROSS JOIN Point2D P2
WHERE P1.x != P2.x OR P1.y != P2.y
)

SELECT ROUND(SQRT(MIN((POWER((x2 - x1), 2) +
POWER((y2 - y1), 2)))),2) FROM CTE

-- normal query
SELECT
    ROUND(SQRT(MIN((POW(p1.x - p2.x, 2) + POW(p1.y - p2.y, 2)))), 2) AS shortest
FROM
    Point2D p1
        JOIN
    Point2D p2 ON p1.x != p2.x OR p1.y != p2.y

