## Assume you're given two tables containing data about Facebook Pages and their respective likes (as in "Like a Facebook Page").

## Write a query to return the IDs of the Facebook pages that have zero likes. The output should be sorted in ascending order based on the page IDs.

*PostgreSQL Solution*

SELECT page_id FROM pages
where page_id not in (select page_id from page_likes where page_id 
is not null)

*MySQL Solution*

SELECT page_id FROM pages
where page_id not in (select page_id from page_likes where page_id 
is not null)

* Using Join*
SELECT pages.page_id
FROM pages
LEFT OUTER JOIN page_likes AS likes
  ON pages.page_id = likes.page_id
WHERE likes.page_id IS NULL
order by page_id;