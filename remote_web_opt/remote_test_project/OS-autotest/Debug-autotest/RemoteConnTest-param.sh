#/bin/bash

#----------------------------------------------------------------
cmdStr=''
retCode=0
#----------------------------------------------------------------
cmdEndStr="Remote Test:Remote connection Test End---------------------------"
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

write_log "INFO" "Remote Test::Remote connection Test Begin------------------------"

#Exit the script if an error happens
#set -e

DebugerIP=$1
cmdLine=$2
#====================================================================================================
#sshpass -p 'loongson' ssh root@10.20.42.220 'pwd'

#sshpass -p 'loongson' ssh  -o StrictHostKeyChecking=no root@$10.20.42.220 $dest_path/$script_name

#sshpass -p 'loongson' ssh  -o StrictHostKeyChecking=no root@$10.20.42.220 /tmp/3B_Ctrl/3B_on.sh
#sshpass -p 'loongson' ssh  -o StrictHostKeyChecking=no root@$10.20.42.220 /tmp/3B_Ctrl/3B_off.sh

#====================================================================================================

#sh check-boot.sh $DebugerIP

trap - ERR

sh check-boot.sh $DebugerIP
retCode=$?

trap 'exit_err $LINENO $?'     ERR

if [ $retCode -eq 0 ]; then
  cmdStr="=====Connect to IP:$DebugerIP success."
  #echo $cmdStr
  write_log "INFO" "${cmdStr}"
else
  cmdStr="Error:Connect to IP:$DebugerIP failed!Please check it!"
  #echo $cmdStr
  write_log "ERROR" "${cmdStr}"
  exit 1
fi

#echo "Remote connection test Begin..."

curtimeBegin=`echo $(date +"%F %T")`
echo "===================current time is:$curtimeBegin"

#cmdLine='pwd'
#sshpass -p $DebugerPass ssh $DebugerUser@$DebugerIP $cmdLine

echo "=====remote execute cmd:[$cmdLine] begin..."

trap - ERR

sshpass -p $DebugerPass ssh $DebugerUser@$DebugerIP $cmdLine
retCode=$?
#echo "=====remote execute cmd:[pwd].retCode:$retCode"

trap 'exit_err $LINENO $?'     ERR

if [ $retCode -eq 0 ]; then
  cmdStr="=====remote execute:cmd [$cmdLine] success."
  echo $cmdStr
  write_log "INFO" "${cmdStr}"
  curtimeEnd=`echo $(date +"%F %T")`
  echo "===================current time is:$curtimeEnd"
else
  cmdStr="Error:remote cmd executed failed!Please check it!"
  echo $cmdStr
  write_log "ERROR" "${cmdStr}"
  exit 1
fi

cmdStr="Remote connection test success."
echo $cmdStr
write_log "INFO" "${cmdStr}"

#====================================================================================================
