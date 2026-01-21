CREATE TABLE activity (
    user_id INT,
    session_id INT,
    activity_date DATE,
    activity_type VARCHAR(50)
);

INSERT INTO activity (user_id, session_id, activity_date, activity_type) VALUES
(1, 1, '2019-07-20', 'open_session'),
(1, 1, '2019-07-20', 'scroll_down'),
(1, 1, '2019-07-20', 'end_session'),
(2, 4, '2019-07-20', 'open_session'),
(2, 4, '2019-07-21', 'send_message'),
(2, 4, '2019-07-21', 'end_session'),
(3, 2, '2019-07-21', 'open_session'),
(3, 2, '2019-07-21', 'send_message'),
(3, 2, '2019-07-21', 'end_session'),
(4, 3, '2019-06-25', 'open_session'),
(4, 3, '2019-06-25', 'end_session');

SELECT * FROM activity

SELECT activity_date as day,
    COUNT(DISTINCT user_id) AS active_users
FROM activity
where activity_date BETWEEN DATE_SUB('2019-07-27', INTERVAL 29 DAY)
    AND '2019-07-27'
GROUP BY day
