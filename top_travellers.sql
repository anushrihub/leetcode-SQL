-- https://leetcode.com/problems/top-travellers/

CREATE TABLE Users (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Insert into Users
INSERT INTO Users (id, name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Alex'),
(4, 'Donald'),
(7, 'Lee'),
(13, 'Jonathan'),
(19, 'Elvis');


-- Create Rides table
CREATE TABLE Rides (
    id INT PRIMARY KEY,
    user_id INT,
    distance INT,
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

-- Insert into Rides
INSERT INTO Rides (id, user_id, distance) VALUES
(1, 1, 120),
(2, 2, 317),
(3, 3, 222),
(4, 7, 100),
(5, 13, 312),
(6, 19, 50),
(7, 7, 120),
(8, 19, 400),
(9, 7, 230);

SELECT name, COALESCE(SUM(distance),0) AS travelled_distance 
FROM Users 
LEFT JOIN Rides ON 
Users.id = Rides.user_id
GROUP BY user_id
ORDER BY travelled_distance DESC,
name ASC


SELECT name, ifnull(SUM(distance),0) AS travelled_distance 
FROM Users 
LEFT JOIN Rides ON 
Users.id = Rides.user_id
GROUP BY user_id
ORDER BY travelled_distance DESC,
name ASC