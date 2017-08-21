from __future__ import absolute_import, print_function, unicode_literals

from collections import Counter
from streamparse.bolt import Bolt

import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT



class WordCounter(Bolt):

    def initialize(self, conf, ctx):
        self.counts = Counter()
        self.dump_count=0;

    def update_table(self):       
        conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")
        cur = conn.cursor()


        for word in list(self.counts):
            count = self.counts[word]
            self.log('Updating db---> %s %d' % (word,count))
            select = 'SELECT word, count from tweetwordcount where word=%s'
            vals = [word]
            cur.execute(select,vals)
            if cur.fetchone() is None:
                insert = 'INSERT into tweetwordcount (word, count) values(%s, %s)'
                vals = [word,count]
                cur.execute(insert,vals)
            else:
                update = 'UPDATE tweetwordcount SET count=%s WHERE word=%s';
                vals = [count,word]
                cur.execute(update,vals)
            conn.commit()
        self.dump_count = 0;
        conn.close()


    def process(self, tup):
        word = tup.values[0]

        # Write codes to increment the word count in Postgres
        # Use psycopg to interact with Postgres
        # Database name: Tcount 
        # Table name: Tweetwordcount 
        # you need to create both the database and the table in advance.
        

        # Increment the local count
        self.counts[word] += 1
        self.emit([word, self.counts[word]])

        # Log the count - just to see the topology running
        self.log('%s: %d' % (word, self.counts[word]))
        
        #increment dump_count
        self.dump_count = self.dump_count + 1;

        if self.dump_count >= 100:
            #serialize
            self.update_table()

