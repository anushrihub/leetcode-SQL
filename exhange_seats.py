import sqlite3

conn = sqlite3.connect(":memory:")

cursor = conn.cursor()

cursor.execute(

    """
     CREATE TABLE IF NOT EXISTS Seat (
    id INT PRIMARY KEY,
    student VARCHAR(50)
); """
)

cursor.executemany(
    """
        INSERT INTO Seat (id, student) VALUES (?, ?)
    """, [
(1, 'Abbot'),
(2, 'Doris'),
(3, 'Emerson'),
(4, 'Green'),
(5, 'Jeames')]
)

cursor.execute(
    """SELECT id, CASE
           WHEN id % 2 = 1 AND LEAD(student) OVER (ORDER BY id) IS NOT NULL
               THEN LEAD(student) OVER (ORDER BY id)
           WHEN id % 2 = 0
               THEN LAG(student) OVER (ORDER BY id)
           ELSE student
       END AS student
FROM seat
ORDER BY id"""
)

rows = cursor.fetchall()


print(f"{'id':<10}{'student'}")
for row in rows:
    print(f"{row[0]:<10}{row[1]}")