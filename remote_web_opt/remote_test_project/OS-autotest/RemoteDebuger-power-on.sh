#/bin/bash

#----------------------------------------------------------------
cmdStr=''
retCode=0
#----------------------------------------------------------------
cmdEndStr="Remote Test:start the remote node End----------------------------"
DebugerIP='10.20.42.220'
DebugerUser='root'
DebugerPass='loongson'
cmdLine=''
retCode=0
#----------------------------------------------------------------------------------
source ./shell-log.sh
logFile=$logFile
#echo $logFile
write_log=$write_log
#----------------------------------------------------------------------------------
source ./exceptionTrap.sh
exit_end=$exit_end
exit_err=$exit_err
exit_int=$exit_int
#----------------------------------------------------------------------------------
trap 'exit_end "${cmdEndStr}"' EXIT
trap 'exit_err $LINENO $?'     ERR
trap 'exit_int $LINENO'        INT
#----------------------------------------------------------------------------------

write_log "INFO" "Remote Test:start the remote node Begin--------------------------"
echo "Remote Test:start the remote node..."

#Exit the script if an error happens
#set -e

#====================================================================================================
#sshpass -p 'loongson' ssh root@10.20.42.220 'pwd'

#sshpass -p 'loongson' ssh  -o StrictHostKeyChecking=no root@$10.20.42.220 $dest_path/$script_name

#sshpass -p 'loongson' ssh  -o StrictHostKeyChecking=no root@$10.20.42.220 /tmp/3B_Ctrl/3B_on.sh
#sshpass -p 'loongson' ssh  -o StrictHostKeyChecking=no root@$10.20.42.220 /tmp/3B_Ctrl/3B_off.sh

#====================================================================================================

echo "Remote connection Test..."

sh RemoteConnTest.sh

#cmdLine='pwd'
#sshpass -p $DebugerPass ssh $DebugerUser@$DebugerIP $cmdLine

#trap - ERR
#
#sshpass -p $DebugerPass ssh $DebugerUser@$DebugerIP $cmdLine
#retCode=$?
#echo "=====remote execute:pwd.retCode:$retCode"
#
#trap 'exit_err $LINENO $?'     ERR
#
#if [ $retCode -eq 0 ]; then
#  cmdStr="remote cmd executed success."
#  #echo $cmdStr
#  write_log "INFO" "${cmdStr}"
#  echo ${cmdStr}
#else
#  cmdStr="Error:remote cmd executed failed!Please check it!"
#  echo $cmdStr
#  write_log "ERROR" "${cmdStr}"
#  exit 1
#fi
#
#cmdStr="Remote connection Test success."
#echo $cmdStr
#write_log "INFO" "${cmdStr}"

#====================================================================================================

curtimeBegin=`echo $(date +"%F %T")`
echo "===================current time is:$curtimeBegin"
echo ""

cmdLine='/tmp/3B_Ctrl/3B_on.sh'

#sshpass -p 'loongson' ssh  root@$10.20.42.220 /tmp/3B_Ctrl/3B_on.sh
#sshpass -p $DebugerPass ssh $DebugerUser@$DebugerIP $cmdLine

trap - ERR

sshpass -p $DebugerPass ssh $DebugerUser@$DebugerIP $cmdLine
retCode=$?
echo "=====remote execute:power on.retCode:$retCode"

trap 'exit_err $LINENO $?'     ERR

if [ $retCode -eq 0 ]; then
  cmdStr="=====remote cmd executed success."
  write_log "INFO" "${cmdStr}"
  echo ${cmdStr}
  echo ""
  curtimeEnd=`echo $(date +"%F %T")`
  echo "===================current time is:$curtimeEnd"
else
  cmdStr="Error:remote cmd executed failed!Please check it!"
  echo $cmdStr
  write_log "ERROR" "${cmdStr}"
  exit 1
fi

cmdStr="Remote cmd [Power-on] executed success."
echo $cmdStr
write_log "INFO" "${cmdStr}"

