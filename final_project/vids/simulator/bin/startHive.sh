#!/bin/bash
HADOOP_HOME=/your/path/to/hadoop
HIVE_HOME=/your/path/to/hive
 
echo -e '1\x01foo' > /tmp/a.txt
echo -e '2\x01bar' >> /tmp/a.txt
 
HADOOP_CORE={{ls $HADOOP_HOME/hadoop-*-core.jar}}
CLASSPATH=.:$HADOOP_CORE:$HIVE_HOME/conf
 
for i in ${HIVE_HOME}/lib/*.jar ; do
    CLASSPATH=$CLASSPATH:$i
done
 
java -cp $CLASSPATH HiveJdbcClient