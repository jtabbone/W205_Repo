import psycopg2
import sys

conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")
cur = conn.cursor()
if len(sys.argv) == 3:
    # dump all
    lo = sys.argv[1]
    hi = sys.argv[2]
    select = 'SELECT word, count from tweetwordcount where count >= %s and count <= %s order by count'
    vals = [lo,hi]
    cur.execute( select,vals)
    op_list = list()
    records = cur.fetchall()
    for rec in records:
        print rec

conn.commit()
conn.close()
