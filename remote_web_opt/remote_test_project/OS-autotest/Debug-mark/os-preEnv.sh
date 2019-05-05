#!/bin/bash

#set -e

#------------------------------
cmdStr=''
retCode=0
#-------------------------------
cmdEndStr="OS Test:Be ready for test.End------------------------------------"
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
trap 'exit_int'                INT
#----------------------------------------------------------------------------------
write_log "INFO" "OS Test:Be ready for test.Begin---------------------------------"

#Install the package:sshpass,for auto connection of the remote Server
yum install sshpass -y

#trap - ERR
#
#retCode=$?
#
#if [ ${retCode} -ne 0 ]; then
#   echo "Error:please check it!"
#   exit ${retCode}
#fi
#
#trap 'exit_err $LINENO $?'     ERR



#write_log "INFO" "OS Test:Be ready for test.End------------------------------------"
