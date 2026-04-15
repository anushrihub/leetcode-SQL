import sqlite3
import pandas as pd

conn = sqlite3.connect(':memmory')

cursor = conn.cursor()

cursor.execute(
    """
        CREATE TABLE IF NOT EXISTS Movies (
        movie_id int,
        title varchar
        )
    """
)

cursor.execute(
    """
        CREATE TABLE IF NOT EXISTS Users (
            user_id INTEGER PRIMARY KEY,
            name VARCHAR
        )
    """
)

cursor.execute(
    """
        CREATE TABLE IF NOT EXISTS MovieRating (
            movie_id INTEGER,
            user_id INTEGER,
            rating INTEGER,
            created_at DATE
        )
    """
)

cursor.executemany(
    """
        INSERT INTO MOVIES(movie_id, title) VALUES(?, ?)
    """,[
         (1, 'Avengers'),
        (2, 'Frozen 2'),
        (3, 'Joker')
    ]
)
cursor.executemany(
    """
        INSERT INTO Users (user_id, name) VALUES (?, ?)""",
    [
        (1, 'Daniel'),
        (2, 'Monica'),
        (3, 'Maria'),
        (4, 'James')
    ]
)

cursor.executemany(
    """INSERT INTO MovieRating (movie_id, user_id, rating, created_at) VALUES (?, ?, ?, ?)""",
    [
        (1, 1, 3, '2020-01-12'),
        (1, 2, 4, '2020-02-11'),
        (1, 3, 2, '2020-02-12'),
        (1, 4, 1, '2020-01-01'),
        (2, 1, 5, '2020-02-17'),
        (2, 2, 2, '2020-02-01'),
        (2, 3, 2, '2020-03-01'),
        (3, 1, 3, '2020-02-22'),
        (3, 2, 4, '2020-02-25')
    ]
)

df = pd.read_sql(
"""
select name as results 
from 
(select name,
        count(distinct movie_id) as rated_movies
from MovieRating a 
inner join Users b 
    on a.user_id = b.user_id
group by 1 
order by rated_movies desc, name 
limit 1)  a

UNION

select title as results from
(select title, avg(rating) from Movies a
inner join MovieRating b on
a.movie_id = b.movie_id 
where strftime('%Y%m', created_at) = '202002'
group by title
order by avg(rating) desc, title
limit 1) a
""",conn
)

print(df)