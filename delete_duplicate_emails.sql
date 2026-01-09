CREATE TABLE Person (
    id INT PRIMARY KEY,
    email VARCHAR(255)
);

SELECT * FROM Person

INSERT INTO Person (id, email) VALUES
(1, 'john@example.com'),
(2, 'bob@example.com'),
(3, 'john@example.com');

-- To find out the duplicates from the table
SELECT email, COUNT(id) FROM Person
GROUP BY email
HAVING COUNT(id) > 1

-- To delete the duplicates from the table
DELETE FROM Person
WHERE id IN (
    SELECT id FROM (SELECT id, email, ROW_NUMBER() OVER(PARTITION BY email) as rnk FROM Person ) t 
    WHERE rnk > 1
);
