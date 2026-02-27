CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

-- Create Student table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    gender CHAR(1),
    dept_id INT
);


-- Insert data into Department table
INSERT INTO Departments (dept_id, dept_name) VALUES
(1, 'Engineering'),
(2, 'Science'),
(3, 'Law');

-- Insert data into Student table
INSERT INTO Students (student_id, student_name, gender, dept_id) VALUES
(1, 'Jack', 'M', 1),
(2, 'Jane', 'F', 1),
(3, 'Mark', 'M', 2);

SELECT dept_name, COUNT(Students.dept_id) AS student_number FROM Students 
RIGHT OUTER JOIN Departments
ON Students.dept_id = Departments.dept_id
GROUP BY dept_name
ORDER BY student_number DESC, dept_name ASC 