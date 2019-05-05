#!/bin/bash
#----------------------------------------------------------------
cmdStr=''
retCode=0
#----------------------------------------------------------------
IP=10.20.42.220
Netmask=255.255.255.0
Gateway=10.20.42.254
#----------------------------------------------------------------
#Exit the script if an error happens
set -e

if [ "$USER" != "root" ];then
    echo "The current user is not root,exit..."
    exit 1
else
    echo "The current user is root,continue..."
fi

if [ $# -eq 0 ];then
    echo "You are using the default ip config."
    echo "You may input the IP configuration Like the default settings:"
elif [ $# -eq 3 ];then
    IP=$1
    Netmask=$2
    Gateway=$3
else
    echo "Input parameter error!"
    echo "usage:IP-config.sh IP Netmask Gateway"
    exit 1  
fi
#================================================================
#such as default value：
#ifconfig eth0 10.20.42.220 netmask 255.255.255.0
#route add default gw 10.20.42.254 eth0
#================================================================
echo "The IP configuration will be setted:"
echo "IP:$IP"
echo "Netmask:$Netmask"
echo "Gateway:$Gateway"

read -p "Please confirm your input information" choose

case $choose in
y|yes)
    echo "You have confirmed that you can continue..."
    ;;

n|no)
    echo "You have denied,exit..."
    exit 1
    ;;
*)
    echo "Your answer should be yes or no!exit..."
    exit 1
    ;;
esac

echo "IP and netmask setting..."
ifconfig eth0 $IP netmask $Netmask

echo "Gateway setting..."
route add default gw $Gateway eth0
