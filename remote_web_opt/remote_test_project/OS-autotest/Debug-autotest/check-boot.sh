#!/bin/bash

#sleep 120s

IP=127.0.0.1


if [ $# -ne 1 ];then
    echo "Parameter error,usage:check-boot.sh IP"
    exit 1
fi

IP=$1

total="0"
i="0"

while [ $i -lt 10 ]; do

  pingCmd=""
  #echo "ping $IP"
  pingCmd=`ping $IP -c 1 -s 1 -W 1 | grep "100% packet loss" | wc -l`

  if [ "${pingCmd}" != "0" ]; then
    #echo "ping failed!"
    echo -e "Times:[$((i+1))],ping IP:[\033[32m$IP\033[0m] failed!"
    total=$((total+1))
  else
    #echo "ping IP:[$IP] OK!"
    total="0"
    break
  fi
  i=$((i+1))
  sleep 5s
done

if [ $total -gt 5 ]; then
  echo -e "ping IP:[\033[32m$IP\033[0m] failed!"
  exit 1
else
  echo -e "ping IP:[\033[32m$IP\033[0m] success."
  exit 0
fi
