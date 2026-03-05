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
With T1 as (
    Select count(distinct sender_id, send_to_id) as sr
    from FriendRequest
),
T2 as (
    Select count(distinct requester_id, accepter_id) as ar from 
    RequestAccepted
)
Select round(ifnull(ar/ sr, 0),2) AS accept_rate from T1 join T2

-- acceptance rate by everymonth


With T1 as (
    Select MONTH(request_date) AS m,count(distinct sender_id, send_to_id) as sr
    from FriendRequest
    GROUP BY m
),
T2 as (
    Select MONTH(accept_date) AS m ,count(distinct requester_id, accepter_id) as ar from 
    RequestAccepted
    GROUP BY m
)
Select round(ifnull(ar/ sr, 0),2) AS accept_rate from T1 inner join T2
on T1.m = T2.m


-- cummulative acceptance rate for every day
