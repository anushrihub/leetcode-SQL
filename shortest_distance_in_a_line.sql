CREATE TABLE Point(
 x INT
)

INSERT INTO Point(x) VALUES
(-1),
(0),
(2)

-- my query
SELECT MIN(shortest) AS shortest FROM (
SELECT abs(p1.x - p2.x) AS shortest FROM Point p1 JOIN
Point p2
WHERE p1.x != p2.x
)t

-- optimised query
SELECT MIN(abs(p1.x - p2.x)) AS shortest FROM Point p1 JOIN
Point p2
WHERE p1.x != p2.x