CREATE TABLE MyNumbers (
    num INT
);

-- Insert data
INSERT INTO MyNumbers (num) VALUES
(8),
(8),
(3),
(3),
(1),
(4),
(5),
(6);

-- using derived table subquery
select max(num) as num from (select num, count(*)from MyNumbers
group by num
having count(*) = 1)t

-- using where subquery
select max(num) as num from MyNumbers 
where num in (select num from MyNumbers group by num having count(*) = 1)
