#!/usr/bin/env bash

cd /LAB1/lab1-2/part1/
mvn clean package
/usr/local/hadoop/bin/hdfs dfs -rm -r /lab1_p2/input/
/usr/local/hadoop/bin/hdfs dfs -rm -r /lab1_p2/output/
/usr/local/hadoop/bin/hdfs dfs -mkdir -p /lab1_p2/input/
/usr/local/hadoop/bin/hdfs dfs -copyFromLocal /mapreduce-test/mapreduce-test-data/access.log /lab1_p2/input/
/usr/local/hadoop/bin/hadoop jar /usr/local/hadoop/share/hadoop/tools/lib/hadoop-streaming-2.9.2.jar \
-file /LAB1/lab1-2/part1/mapper.py -mapper /LAB1/lab1-2/part1/mapper.py \
-file /LAB1/lab1-2/part1/reducer.py -reducer /LAB1/lab1-2/part1/reducer.py \
-input /lab1_p2/input/* -output /lab1_p2/output/ \
-cmdenv param_h0=0 -cmdenv param_h1=13
/usr/local/hadoop/bin/hdfs dfs -cat /lab1_p2/output/part-00000
/usr/local/hadoop/bin/hdfs dfs -rm -r /lab1_p2/input/
/usr/local/hadoop/bin/hdfs dfs -rm -r /lab1_p2/output/
mvn clean
