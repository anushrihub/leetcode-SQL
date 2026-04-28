import sqlite3
import pandas as pd

conn = sqlite3.connect(':memory:')

cursor = conn.cursor()

cursor.execute(
    """ 
        CREATE TABLE IF NOT EXISTS Employee(
            id INT,
            name VARCHAR(50),
            salary INT,
            departmentId INT
        )
    """
)

cursor.execute(
    """ 
        CREATE TABLE IF NOT EXISTS Department(
            id INT PRIMARY KEY,
            name VARCHAR(50)
        )
    """
)

cursor.executemany(
    """INSERT INTO Employee(id, name, salary, departmentId) VALUES (?, ?, ?, ?)""",
    [(1, 'Joe', 85000, 1),
(2, 'Henry', 80000, 2),
(3, 'Sam', 60000, 2),
(4, 'Max', 90000, 1),
(5, 'Janet', 69000, 1),
(6, 'Randy', 85000, 1),
(7, 'Will', 70000, 1)]
)

cursor.executemany(
    """INSERT INTO Department(id, name) VALUES (?, ?)""",
    [(1, 'IT'),
     (2, 'Sales')]
)


df = pd.read_sql("select Department, Employee, Salary from(         SELECT departmentId, Employee.name AS Employee, Department.name AS Department, salary AS Salary, DENSE_RANK() OVER (PARTITION BY Department.name ORDER BY salary DESC) AS dnrank FROM Department INNER JOIN Employee ON Department.id = Employee.departmentId  ) t WHERE dnrank <= 3", conn)   

print(df)