import sqlite3

conn = sqlite3.connect('fix_names.db')

cursor = conn.cursor()

cursor.execute(
    """
        CREATE TABLE IF NOT EXISTS Users(
            user_id int,
            name varchar
        )
    """
)

cursor.executemany(""" INSERT INTO Users(user_id, name) VALUES(?,?)
                   """,[
                       (1, 'aLice'),
                       (2, 'bOB')
                   ])
cursor.execute(
    """
        select user_id, concat(upper(substring(name, 1, 1)), lower(substring(name, 2))) as name
        from Users
    """
)

rows = cursor.fetchall()

print(f"{'user_id':<10} {'name'}" )
for row in rows:
    print(f"{row[0]:<10} {row[1]}")