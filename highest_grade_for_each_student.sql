CREATE TABLE Enrollments (
    student_id INT,
    course_id INT,
    grade INT
);

INSERT INTO Enrollments (student_id, course_id, grade) VALUES
(2, 2, 95),
(2, 3, 95),
(1, 1, 90),
(1, 2, 99),
(3, 1, 80),
(3, 2, 75),
(3, 3, 82);

WITH CTE AS(
SELECT student_id, course_id, grade,
RANK() OVER(PARTITION BY student_id ORDER BY grade DESC, course_id ASC) AS rnk
 FROM Enrollments)

SELECT student_id, course_id, grade FROM CTE 
WHERE rnk = 1