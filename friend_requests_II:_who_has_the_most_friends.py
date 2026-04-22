import sqlite3
import pandas as pd

conn = sqlite3.connect(':memory:')

cursor = conn.cursor()

cursor.execute(
    """
        CREATE TABLE IF NOT EXISTS RequestAccepted
        (requester_id INT,
         accepter_id INT,
         accept_date DATE
        )
    """
)

cursor.executemany(
    """ INSERT INTO RequestAccepted(requester_id, accepter_id, accept_date) 
    VALUES (?, ?, ?)
    """,[
    (1, 2, '2016-06-03'),
    (1, 3, '2016-06-08'),
    (2, 3, '2016-06-08'),
    (3, 4, '2016-06-09')
    ]
)

DF = pd.read_sql(
    """
    WITH CTE AS (
        SELECT requester_id AS id FROM RequestAccepted
        UNION ALL
        SELECT accepter_id AS id FROM RequestAccepted )
        SELECT id, count(id) as num FROM CTE
        GROUP BY id
        ORDER BY 2 DESC
        LIMIT 1
    """,conn
)


print(DF.to_string(index= False))