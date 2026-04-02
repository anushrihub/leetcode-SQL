CREATE TABLE Triangle (
    x INT,
    y INT,
    z INT
);

-- Insert data
INSERT INTO Triangle (x, y, z) VALUES
(13, 15, 30),
(10, 20, 15);   


SELECT x, y, z,
CASE WHEN x + y > z AND y + z > x AND x + z > y 
THEN 'Yes' Else 'No' END AS triangle
FROM Triangle