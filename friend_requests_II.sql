CREATE TABLE RequestAccepted (
    requester_id INT,
    accepter_id INT,
    accept_date DATE
);

-- Insert data
INSERT INTO RequestAccepted (requester_id, accepter_id, accept_date) VALUES
(1, 2, '2016-06-03'),
(1, 3, '2016-06-08'),
(2, 3, '2016-06-08'),
(3, 4, '2016-06-09');

SELECT * FROM RequestAccepted

-- find all ids
WITH All_Requests AS (
SELECT requester_id AS id FROM RequestAccepted
UNION ALL
SELECT accepter_id AS id FROM RequestAccepted)
-- find the count of the ids have most friends 
SELECT id, num FROM
   (SELECT id, 
      COUNT(id) AS num,
      RANK () OVER(ORDER BY COUNT(id) DESC) AS rnk
   FROM All_Requests
   GROUP BY id
   )t
WHERE rnk = 1