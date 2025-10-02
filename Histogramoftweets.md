## Assume you're given a table Twitter tweet data, write a query to obtain a histogram of tweets posted per user in 2022. Output the tweet count per user as the bucket and the number of Twitter users who fall into that bucket.

## In other words, group the users by the number of tweets they posted in 2022 and count the number of users in each group.

*PostgreSQL Solution*

select tweet_count_per_user as tweet_bucket, count( users_num) as users_num
from (SELECT user_id as users_num,count(tweet_id) as tweet_count_per_user FROM tweets
WHERE EXTRACT(year FROM TWEET_DATE) = 2022
group by user_id) a
group by tweet_bucket

*MySQL Solution*

select users_num, count(tweet_bucket)  from (select user_id as tweet_bucket, count(tweet_id) as users_num  from tweets
WHERE EXTRACT(year FROM TWEET_DATE) = 2022
group by user_id) 
group by users_num