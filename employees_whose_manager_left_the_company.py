import sqlite3
import pandas as pd

conn = sqlite3.connect(":memory:")

cursor = conn.cursor()

cursor.execute("""
        Create table IF NOT EXISTS Employee(employee_id INT PRIMARY KEY,
        name VARCHAR(50),
        manager_id INT NULL,
        salary INT)
        """
)

cursor.executemany("""
        INSERT INTO Employee (employee_id, name, manager_id, salary) VALUES (?, ?, ?, ?)
    """, [
        (3, 'Mila', 9, 60301),
        (12, 'Antonella', None, 31000),
        (13, 'Emery', None, 67084),
        (1, 'Kalel', 11, 21241),
        (9, 'Mikaela', None, 50937),
        (11, 'Joziah', 6, 28485),
    ])

cursor.execute(
        """
            select employee_id from Employee
            where manager_id not in (select employee_id from Employee) and 
            salary < 30000
        """
)
rows = cursor.fetchall()

for row in rows:
    print(f"{'employee_id'}")
    print(f"{row[0]}")

conn.close()