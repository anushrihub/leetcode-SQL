CREATE TABLE Queue (
    person_id INT PRIMARY KEY,
    person_name VARCHAR(100),
    weight INT,
    turn INT
);

INSERT INTO Queue (person_id, person_name, weight, turn) VALUES
(5, 'Alice', 250, 1),
(4, 'Bob', 175, 5),
(3, 'Alex', 350, 2),
(6, 'John Cena', 400, 3),
(1, 'Winston', 500, 6),
(2, 'Marie', 200, 4);

select person_name
from(select Turn, person_name, person_id, sum(Weight) Over(Order by Turn) as cum_sum from Queue
ORDER BY Turn ASC)t
where cum_sum <= 1000 
ORDER BY turn DESC
LIMIT 1