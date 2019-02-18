#!/bin/sh
../start.sh
/usr/local/hadoop/bin/hdfs dfs -rm -r /logstat3/input/
/usr/local/hadoop/bin/hdfs dfs -rm -r /logstat3/output/
/usr/local/hadoop/bin/hdfs dfs -mkdir -p /logstat3/input/
/usr/local/hadoop/bin/hdfs dfs -copyFromLocal ../../../mapreduce-test/mapreduce-test-data/access.log /logstat3/input/
/usr/local/hadoop/bin/hadoop jar /usr/local/hadoop/share/hadoop/tools/lib/hadoop-streaming-2.9.2.jar \
-file ../../../LAB1/lab1/logstat3/mapper.py -mapper ../../../LAB1/lab1/logstat3/mapper.py \
-file ../../../LAB1/lab1/logstat3/reducer.py -reducer ../../../LAB1/lab1/logstat3/reducer.py \
-input /logstat3/input/* -output /logstat3/output/
/usr/local/hadoop/bin/hdfs dfs -cat /logstat3/output/part-00000
/usr/local/hadoop/bin/hdfs dfs -rm -r /logstat3/input/
/usr/local/hadoop/bin/hdfs dfs -rm -r /logstat3/output/
../stop.sh
