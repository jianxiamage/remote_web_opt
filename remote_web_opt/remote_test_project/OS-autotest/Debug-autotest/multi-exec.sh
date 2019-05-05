#!/bin/bash
set -e
success=0
failed=0
while read  ip username passwd
do
   ip=$ip
   username=$username
   passwd=$passwd
   #sshpass -p $passwd  ssh -n -o "StrictHostKeyChecking no" $username@$ip "free -m"
   sshpass -p $passwd  ssh -n -o "StrictHostKeyChecking no" $username@$ip "pwd"
   if [ $? -eq 0 ];then
      success=$(($success+1))
      echo -e "\n\033[32m$ip | success\033[0m\n"
   else
       failed=$(($failed+1))
       echo -e "\n\033[32m$ip | failed\033[0m\n"
   fi
 
done < ip_user_passwd.txt
echo -e '\n-------------------------'
echo -e "\033[32msuccess: $success | failed: $failed \033[0m"
