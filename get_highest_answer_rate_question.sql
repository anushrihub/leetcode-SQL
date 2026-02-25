CREATE TABLE SurveyLog (
    id INT,
    action VARCHAR(20),
    question_id INT,
    answer_id INT,
    q_num INT,
    timestamp BIGINT
);

INSERT INTO SurveyLog (id, action, question_id, answer_id, q_num, timestamp) VALUES
(5, 'show',   285, NULL,    1, 123),
(5, 'answer', 285, 124124,  1, 124),
(5, 'show',   369, NULL,    2, 125),
(5, 'skip',   369, NULL,    2, 126);


SELECT question_id AS survey_log FROM(
SELECT question_id,
SUM(CASE WHEN action = 'answer' THEN 1 ELSE 0 END)
/ SUM(CASE WHEN action = 'show' THEN 1 ELSE 0 END) AS rate
FROM SurveyLog
GROUP BY question_id
ORDER BY rate DESC,question_id ASC )t
LIMIT 1
