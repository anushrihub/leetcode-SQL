import sqlite3

conn = sqlite3.connect('insurance.db')

cursor = conn.cursor()

cursor.execute(
    """
        CREATE TABLE IF NOT EXISTS Insurance(
            pid INT,
    tiv_2015 INT,
    tiv_2016 INT,
    lat INT,
    lon INT)
    """
)

cursor.executemany(
    """INSERT INTO Insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (?, ?, ?, ?, ?)""",
    [(1, 10, 5, 10, 10),
(2, 20, 20, 20, 20),
(3, 10, 30, 20, 20),
(4, 10, 40, 40, 40)]
)

cursor.execute(""" select round(sum(tiv_2016),2) as tiv_2016 from Insurance
               where tiv_2015 in (select tiv_2015 from Insurance
               group by tiv_2015
               having count(*) > 1) and (lat, lon) in 
               (select lat, lon from Insurance
               group by lat, lon
               having count(*) = 1 )
               """)
rows = cursor.fetchall()

print(f"tiv_2016")
for row in rows:
    print(f"{row[0]}")