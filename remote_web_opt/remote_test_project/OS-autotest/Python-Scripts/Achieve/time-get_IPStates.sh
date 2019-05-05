#!/bin/bash

curtimeBegin=`echo $(date +"%F %T")`
echo "===================current time is:$curtimeBegin"
start_seconds=$(date --date="$curtimeBegin" +%s);
echo "start_seconds:$start_seconds"

python get_IPStates_Pairs.py
echo ""
curtimeEnd=`echo $(date +"%F %T")`
echo "===================current time is:$curtimeEnd"

end_seconds=$(date --date="$curtimeEnd" +%s);
echo "本次运行时间： "$((end_seconds-start_seconds))"s"
echo "end_seconds:$end_seconds"


