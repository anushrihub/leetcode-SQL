-- https://leetcode.com/problems/trips-and-users/description/
CREATE TABLE Trip_Users (
    users_id INT PRIMARY KEY,
    banned VARCHAR(3) NOT NULL,
    role VARCHAR(10) NOT NULL
);
INSERT INTO Trip_Users (users_id, banned, role)
VALUES (1, 'No', 'client'),
    (2, 'Yes', 'client'),
    (3, 'No', 'client'),
    (4, 'No', 'client'),
    (10, 'No', 'driver'),
    (11, 'No', 'driver'),
    (12, 'No', 'driver'),
    (13, 'No', 'driver');
CREATE TABLE Trips (
    id INT PRIMARY KEY,
    client_id INT NOT NULL,
    driver_id INT NOT NULL,
    city_id INT NOT NULL,
    status VARCHAR(20) NOT NULL,
    request_at DATE NOT NULL
);
INSERT INTO Trips (
        id,
        client_id,
        driver_id,
        city_id,
        status,
        request_at
    )
VALUES (1, 1, 10, 1, 'completed', '2013-10-01'),
    (2, 2, 11, 1, 'cancelled_by_driver', '2013-10-01'),
    (3, 3, 12, 6, 'completed', '2013-10-01'),
    (4, 4, 13, 6, 'cancelled_by_client', '2013-10-01'),
    (5, 1, 10, 1, 'completed', '2013-10-02'),
    (6, 2, 11, 6, 'completed', '2013-10-02'),
    (7, 3, 12, 6, 'completed', '2013-10-02'),
    (8, 2, 12, 12, 'completed', '2013-10-03'),
    (9, 3, 10, 12, 'completed', '2013-10-03'),
    (
        10,
        4,
        13,
        12,
        'cancelled_by_driver',
        '2013-10-03'
    );


-- 
SELECT request_at AS DAY,
    ROUND (SUM(status != 'completed') / COUNT(*), 2) AS 'Cancellation Rate'
FROM Trips
    LEFT JOIN Trip_Users AS Clients ON Trips.client_id = Clients.users_id
    LEFT JOIN Trip_Users AS Drivers ON Trips.driver_id = Drivers.users_id
WHERE Clients.banned = 'No'
    AND Drivers.banned = 'No'
    AND request_at Between '2013-10-01' AND '2013-10-03'
GROUP BY DAY

-- using subquery
SELECT 
  request_at AS Day, 
  ROUND(
    SUM(status != 'completed') / COUNT(status), 
    2
  ) AS 'Cancellation Rate' 
FROM 
  Trips 
WHERE 
  request_at BETWEEN '2013-10-01' 
  AND '2013-10-03' 
  AND driver_id NOT IN (
    SELECT 
      users_id 
    FROM 
      Trip_Users 
    WHERE 
      banned = 'Yes'
  ) 
  AND client_id NOT IN (
    SELECT 
      users_id 
    FROM 
      Trip_Users 
    WHERE 
      banned = 'Yes'
  ) 
GROUP BY 
  Day