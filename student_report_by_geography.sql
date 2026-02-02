CREATE TABLE Student (
    name VARCHAR(50),
    continent VARCHAR(50)
);

INSERT INTO Student (name, continent) VALUES
('Jane', 'America'),
('Pascal', 'Europe'),
('Xi', 'Asia'),
('Jack', 'America');

-- using subquery
SELECT
        MAX(CASE WHEN continent = 'America' THEN name END )AS America,
        MAX(CASE WHEN continent = 'Asia' THEN name END )AS Asia,
        MAX(CASE WHEN continent = 'Europe' THEN name END )AS Europe  
FROM (SELECT *, ROW_NUMBER()OVER(PARTITION BY continent ORDER BY name) AS row_id FROM student) AS t
GROUP BY row_id

-- using CTE
WITH CTE AS (
SELECT * , ROW_NUMBER() OVER(PARTITION BY continent ORDER BY name) AS 
row_id FROM student
)

SELECT 
MAX(CASE WHEN continent = 'America' THEN name END )AS America,
        MAX(CASE WHEN continent = 'Asia' THEN name END )AS Asia,
        MAX(CASE WHEN continent = 'Europe' THEN name END )AS Europe  
FROM CTE
GROUP BY row_id