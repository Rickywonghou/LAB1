#!/bin/bash

echo "Please type the hour in the format of h-h (e.g. 5-6), followed by [ENTER]:"
while true; do
    read hour
    IFS='-' read -ra list <<< "$hour"
    if [ ${#list[@]} -eq 2 ]; then
        h0=${list[0]}; h1=${list[1]}
        if (( ($h0 < $h1) && ($h0 >= 0) && ($h1 <= 24) )); then
            break
        fi
    fi
    echo "Wrong format! Please type the hour in the format of h-h (e.g. 5-6), followed by [ENTER]:"
done

/LAB1/lab1/start.sh
/usr/local/hadoop/bin/hdfs dfs -rm -r /lab1_p2/input/
/usr/local/hadoop/bin/hdfs dfs -rm -r /lab1_p2/output/
/usr/local/hadoop/bin/hdfs dfs -mkdir -p /lab1_p2/input/
/usr/local/hadoop/bin/hdfs dfs -copyFromLocal /mapreduce-test/mapreduce-test-data/access.log /lab1_p2/input/
/usr/local/hadoop/bin/hadoop jar /usr/local/hadoop/share/hadoop/tools/lib/hadoop-streaming-2.9.2.jar \
-file /LAB1/lab1-2/part1/mapper.py -mapper /LAB1/lab1-2/part1/mapper.py \
-file /LAB1/lab1-2/part1/reducer.py -reducer /LAB1/lab1-2/part1/reducer.py \
-input /lab1_p2/input/* -output /lab1_p2/output/ \
-cmdenv param_h0=$h0 -cmdenv param_h1=$h1
/usr/local/hadoop/bin/hdfs dfs -cat /lab1_p2/output/part-00000
/usr/local/hadoop/bin/hdfs dfs -rm -r /lab1_p2/input/
/usr/local/hadoop/bin/hdfs dfs -rm -r /lab1_p2/output/
/LAB1/lab1/stop.sh
