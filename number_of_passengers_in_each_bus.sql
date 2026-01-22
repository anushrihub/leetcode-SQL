CREATE TABLE Buses (
    bus_id INT PRIMARY KEY,
    arrival_time INT
);

-- Insert data into Buses
INSERT INTO Buses (bus_id, arrival_time) VALUES
(1, 2),
(2, 4),
(3, 7);

CREATE TABLE Passengers (
    passenger_id INT PRIMARY KEY,
    arrival_time INT
);

INSERT INTO Passengers (passenger_id, arrival_time) VALUES
(11, 1),
(12, 5),
(13, 6),
(14, 7);

-- created an cte to calculate which bus passenger can take  
WITH cte AS (
SELECT p.passenger_id, MIN(b.arrival_time) AS arrival_time FROM Passengers p
INNER JOIN Buses b ON p.arrival_time <= b.arrival_time
GROUP BY passenger_id
)
-- count passengers per bus
SELECT  bus_id ,count(c.arrival_time) AS passengers_cnt
FROM buses b left join  cte c
ON b.arrival_time =c.arrival_time
GROUP BY bus_id 
ORDEr BY bus_id asc  