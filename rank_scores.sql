CREATE TABLE Scores (
    id INT,
    score DECIMAL(3,2)
);


INSERT INTO scores (id, score) VALUES
(1, 3.50),
(2, 3.65),
(3, 4.00),
(4, 3.85),
(5, 4.00),
(6, 3.65);

SELECT * FROM Scores

-- Window Function Approach
SELECT score, DENSE_RANK() OVER(order by score DESC) as `rank` FROM Scores