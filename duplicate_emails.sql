-- https://leetcode.com/problems/duplicate-emails/description/

CREATE TABLE Person_Email (
    id INT PRIMARY KEY,
    email VARCHAR(255)
);

-- Insert the sample data
INSERT INTO Person_Email (id, email) VALUES
(1, 'a@b.com'),
(2, 'c@d.com'),
(3, 'a@b.com');

select email from Person_Email
group by email
having count(*) > 1