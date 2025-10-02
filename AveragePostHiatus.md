## Given a table of Facebook posts, for each user who posted at least twice in 2021, write a query to find the number of days between each user’s first post of the year and last post of the year in the year 2021. Output the user and number of the days between each user's first and last post.

*PostgreSQL Solution* 

SELECT user_id, max(post_date :: DATE)-  min(post_date :: DATE) FROM posts
where EXTRACT(year from post_date) = 2021
group by user_id
having count(post_id) > 1
# to exclude users who have posted only once during the year

*MySQL Solution*

SELECT 
    user_id, 
    DATEDIFF(MAX(DATE(post_date)), MIN(DATE(post_date))) AS days_between
FROM posts
WHERE YEAR(post_date) = 2021
GROUP BY user_id
HAVING COUNT(post_id) > 1;