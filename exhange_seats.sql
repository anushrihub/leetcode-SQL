CREATE TABLE Seat (
    id INT PRIMARY KEY,
    student VARCHAR(50)
);


INSERT INTO Seat (id, student) VALUES
(1, 'Abbot'),
(2, 'Doris'),
(3, 'Emerson'),
(4, 'Green'),
(5, 'Jeames');


SELECT id, CASE
        -- Only swap odd rows if there is a next student available
           WHEN id % 2 = 1 AND LEAD(student) OVER (ORDER BY id) IS NOT NULL
               THEN LEAD(student) OVER (ORDER BY id)
           WHEN id % 2 = 0
               THEN LAG(student) OVER (ORDER BY id)
           ELSE student
       END AS student
FROM seat
ORDER BY id;