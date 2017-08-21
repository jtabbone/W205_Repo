import psycopg2
import sys


conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")
cur = conn.cursor()
if len(sys.argv) == 1:
    # dump all
    cur.execute('SELECT word, count from tweetwordcount order by word')
    op_list = list()
    records = cur.fetchall()
    for rec in records:
        op_list.append((rec[0],rec[1]))
    print op_list

if len(sys.argv) == 2:
    word = sys.argv[1] 
    select = 'SELECT count from tweetwordcount where word=%s'
    vals = [word]
    cur.execute(select,vals)
    rec = cur.fetchone()
    count = rec[0]
    print("Total number of occurances of {} is {}".format(word,count))

conn.commit()
conn.close()
