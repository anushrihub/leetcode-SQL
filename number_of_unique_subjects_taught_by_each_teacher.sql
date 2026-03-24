CREATE TABLE Teacher (
    teacher_id INT,
    subject_id INT,
    dept_id INT
);

-- Insert data
INSERT INTO Teacher (teacher_id, subject_id, dept_id) VALUES
(1, 2, 3),
(1, 2, 4),
(1, 3, 3),
(2, 1, 1),
(2, 2, 1),
(2, 3, 1),
(2, 4, 1);


SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt FROM Teacher
GROUP BY teacher_id