#!/bin/sh

cd shell
./capacity.sh
/yarn-test/start.sh
starttime=`date +'%Y-%m-%d %H:%M:%S'`
echo "Test cost time:"$((end_seconds-start_seconds))"s"
./test-logstat.sh&
./test-grep.sh&
./test-selflogstat.sh&
./test-wordcount.sh&
wait
endtime=`date +'%Y-%m-%d %H:%M:%S'`
start_seconds=$(date --date="$starttime" +%s);
end_seconds=$(date --date="$endtime" +%s);
echo "======> [CAPACITY] All Test cost time:"$((end_seconds-start_seconds))"s"
/yarn-test/stop.sh
