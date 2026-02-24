CREATE TABLE Candidate(
    id INT,
    name CHAR
)

CREATE TABLE Vote(
    id INT,
    candidateId INT
)

INSERT INTO Candidate (id, name) VALUES
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E');

INSERT INTO Vote(id, candidateId) VALUES
(1, 2),
(2, 4),
(3, 3),
(4, 2),
(5, 5);

-- using subquery
WITH CTE AS(
SELECT name, count(*) AS total FROM Candidate INNER JOIN Vote
ON Candidate.id = Vote.candidateId
GROUP BY name)
SELECT name FROM CTE
WHERE total = (SELECT max(total) FROM CTE)
