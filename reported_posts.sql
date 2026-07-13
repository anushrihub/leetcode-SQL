CREATE TABLE Actions (
    user_id INT,
    post_id INT,
    action_date DATE,
    action VARCHAR(20),
    extra VARCHAR(50)
);


INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES
(1, 1, '2019-07-01', 'view', NULL),
(1, 1, '2019-07-01', 'like', NULL),
(1, 1, '2019-07-01', 'share', NULL),
(2, 4, '2019-07-04', 'view', NULL),
(2, 4, '2019-07-04', 'report', 'spam'),
(3, 4, '2019-07-04', 'view', NULL),
(3, 4, '2019-07-04', 'report', 'spam'),
(4, 3, '2019-07-02', 'view', NULL),
(4, 3, '2019-07-02', 'report', 'spam'),
(5, 2, '2019-07-04', 'view', NULL),
(5, 2, '2019-07-04', 'report', 'racism'),
(5, 5, '2019-07-04', 'view', NULL),
(5, 5, '2019-07-04', 'report', 'racism');

SELECT extra as report_reason, count(distinct post_id) as report_count 
FROM Actions
where datediff('2019-07-05',action_date) = 1 
and action = 'report'
group by report_reason

