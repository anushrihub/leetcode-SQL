import sqlite3

# opens the connection to a sqlite database file game.db
# conn is the connection object between Python and Database file game.db
conn = sqlite3.connect('game.db')

# Instead of saving to a file, this creates the database entirely in RAM
# sqlite3.connect(":memory:")

# can not run queries directly on conn, need cursor for that
cursor = conn.cursor()

# 2. Create table
cursor.execute("""
    CREATE TABLE IF NOT EXISTS Activity_I (
        player_id INTEGER,
        event_date TEXT
    )
""")

# 3. Insert sample data
cursor.executemany("""
    INSERT INTO Activity_I (player_id, event_date) VALUES (?, ?)
""", [
    (1, '2023-01-01'),
    (1, '2023-03-15'),
    (1, '2023-06-20'),
    (2, '2023-02-10'),
    (2, '2023-05-05'),
    (3, '2023-04-01'),
])

conn.commit()

# 4. Run the query
cursor.execute("""
    SELECT player_id, MIN(event_date) AS first_login
    FROM Activity_I
    GROUP BY player_id
""")

# 5. Fetch and print results
# fetch all retrieves all the query results as a list of tuples
# rows = [
#     (1, '2023-01-01'),
#     (2, '2023-02-10'),
#     (3, '2023-04-01'),
# ]
rows = cursor.fetchall()
# :<12 is an f-string alignment specifier — it left-aligns the text and pads it to 12 characters wide. 
print(f"{'player_id':<10} {'first_login'}")
# just prints 25 dashes in line
print("-" * 25)
# loops through each row and print both columns
for row in rows:
    print(f"{row[0]:<12} {row[1]}")

# 6. Close connection
conn.close()