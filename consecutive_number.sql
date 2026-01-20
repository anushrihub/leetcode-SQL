CREATE TABLE Logs (
    id INT PRIMARY KEY,
    num INT
);

INSERT INTO Logs (id, num) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 1),
(6, 2),
(7, 2);

SELECT DISTINCT num as ConsecutiveNums
from (
        SELECT id,
            num,
            LEAD(num) OVER(
                ORDER BY id
            ) as num1,
            LEAD(num, 2) OVER(
                ORDER BY id
            ) as num2
        FROM Logs
    ) t
where num = num1
    and num1 = num2