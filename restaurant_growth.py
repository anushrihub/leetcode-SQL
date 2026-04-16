import sqlite3

conn = sqlite3.connect('restaurant growth.db')

cursor = conn.cursor()

cursor.execute( """
    CREATE TABLE IF NOT EXISTS Customer(
               customer_id int,
               name char,
               visited_on date,
               amount int
               )
               """
)

cursor.executemany(
    """
        INSERT INTO Customer (customer_id, name, visited_on, amount) VALUES (?, ?, ?, ?)
    """,
    [(1, 'Jhon', '2019-01-01', 100),
(2, 'Daniel', '2019-01-02', 110),
(3, 'Jade', '2019-01-03', 120),
(4, 'Khaled', '2019-01-04', 130),
(5, 'Winston', '2019-01-05', 110),
(6, 'Elvis', '2019-01-06', 140),
(7, 'Anna', '2019-01-07', 150),
(8, 'Maria', '2019-01-08', 80),
(9, 'Jaze', '2019-01-09', 110),
(1, 'Jhon', '2019-01-10', 130),
(3, 'Jade', '2019-01-10', 150)]
)
cursor.execute(""" 
               WITH daily as (
                select visited_on, sum(amount) as daily_amount from Customer
                group by visited_on),
                d7sum as(
               select sum(daily_amount)over(order by visited_on rows between 6 preceding and current row) as amountsum, 
               ROW_NUMBER() OVER (ORDER BY visited_on) as Day,
               visited_on from daily)

                select visited_on, Day, amountsum, Round(amountsum/ 7,2) from d7sum
                where Day >= 7
                order by visited_on
               
 """)

df = cursor.fetchall()

print(f"{'visited_on':<15}{'amount':<15}{'average_amount'}")
for row in df:
    print(f'{row[0]:<15} {row[1]:<15} {row[2]}')

conn.close()