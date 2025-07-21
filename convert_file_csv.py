import mysql.connector
import csv

conn = mysql.connector.connect ( 
    host = "localhost",
    user ="root",
    password = "root",
    database = "training"
)

cursor = conn.cursor()

cursor.execute("SELECT * FROM daywise_sales_tbl")

with open('daywise_sales.csv', 'w', newline='') as f:
    writer = csv.writer(f)
    # Write the header
    writer.writerow([i[0] for i in cursor.description])
    writer.writerows(cursor.fetchall())


cursor.close()
conn.close()
