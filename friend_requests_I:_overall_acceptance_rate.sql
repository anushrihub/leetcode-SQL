CREATE TABLE FriendRequest (
    sender_id INT,
    send_to_id INT,
    request_date DATE
);

INSERT INTO FriendRequest (sender_id, send_to_id, request_date) VALUES
(1, 2, '2016-06-01'),
(1, 3, '2016-06-01'),
(1, 4, '2016-06-01'),
(2, 3, '2016-06-02'),
(3, 4, '2016-06-09');

CREATE TABLE RequestAccepted_I (
    requester_id INT,
    accepter_id INT,
    accept_date DATE
);

-- Insert data into RequestAccepted
INSERT INTO RequestAccepted_I (requester_id, accepter_id, accept_date) VALUES
(1, 2, '2016-06-03'),
(1, 3, '2016-06-08'),
(2, 3, '2016-06-08'),
(3, 4, '2016-06-09');

-- acceptance rate
SELECT
ROUND(
(IFNULL(
    (SELECT COUNT(*) FROM (SELECT DISTINCT accept_date, requester_id, accepter_id FROM RequestAccepted) AS accepter)
    /
    (SELECT COUNT(*) FROM (SELECT DISTINCT request_date, sender_id, send_to_id FROM FriendRequest
    ) AS sender),0)),2)

-- acceptance rate by everymonth

-- cummulative acceptance rate for every day
