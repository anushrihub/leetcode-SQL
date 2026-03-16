CREATE TABLE Employeebonus (
    empId INT PRIMARY KEY,
    name VARCHAR(50),
    supervisor INT,
    salary INT
);

INSERT INTO Employeebonus (empId, name, supervisor, salary) VALUES
(3, 'Brad', NULL, 4000),
(1, 'John', 3, 1000),
(2, 'Dan', 3, 2000),
(4, 'Thomas', 3, 4000);

CREATE TABLE Bonus (
    empId INT,
    bonus INT
);

INSERT INTO Bonus (empId, bonus) VALUES
(2, 500),
(4, 2000);

SELECT name, bonus FROM Employeebonus
LEFT JOIN Bonus ON
Employeebonus.empId = Bonus.empId
WHERE bonus < 1000 or bonus is NULL