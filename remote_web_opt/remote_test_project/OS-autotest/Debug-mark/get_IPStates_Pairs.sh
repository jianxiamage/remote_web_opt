#!/bin/bash

# ==========================================
# 功能：批量在多台服务器上执行命令
# 方法：./RemoteConnTest-bat.sh <cmd_to_exec>
# 返回：各服务器执行命令返回的结果列表
# 前提：在待执行命令的各个服务器上设置了免密登录
# 警告：禁止执行删除、格式化等这样的可能造成严重后果的命令
# 其他：设置免密登录参考：https://blog.csdn.net/zoombinde/article/details/51902208
# 文件：RemoteConnTest-bat.sh
# ==========================================
#-----------------------------------------------------------------
username=root
passwd=loongson

DebugerIP=''
ServerIP=''
#-----------------------------------------------------------------
IP_List_File='hostlist.txt'
tmpIP_List_File='hostlist_filter.tmp'
#-----------------------------------------------------------------
retCode=0
success=0
failed=0
debugerSuccess=0
debugerFailed=0
serverSuccess=0
serverFailed=0
DebugerStat=''
ServerStat=''
ip_pairs_stat=''
#-----------------------------------------------------------------
do_command()
{
        #hosts=`sed -n '/^[^#]/p' hostlist.txt`
        #hosts=`cat hostlist.txt |awk '{print $0}'`
        #cat hostlist.txt|while read host
        #echo "hosts:$hosts"
        #for host in $hosts
        #FINDFILE='hostlist.txt'
        tmpIP_List_File='hostlist_filter.tmp'
        exec 3<$tmpIP_List_File
        while read host <&3
        do
		echo "--------------------------------------------------------"
		DebugerIP=`echo $host|awk '{print $1}'`
		ServerIP=`echo $host|awk '{print $2}'`
		echo "DebugerIP:[$DebugerIP]"
		echo "ServerIP: [$ServerIP]"
		#ssh $host "$@"
		#sshpass -p $passwd  ssh -n -o "StrictHostKeyChecking no" $username@$host "$@"
		sh RemoteConnTest-param.sh $DebugerIP "$@" > /dev/null 2>&1
		retCode=$?

		if [ $retCode -eq 0 ]; then
		  debugerSuccess=$(($debugerSuccess+1))
                  echo -e "\n\033[32m$DebugerIP | success\033[0m\n"
                  #echo "debugerSuccess:$debugerSuccess"
		  echo $DebugerIP >> ip_debuger_active.list
		  DebugerStat='active'
		else
		  debugerFailed=$(($debugerFailed+1))
		  echo -e "\n\033[32m$DebugerIP | failed\033[0m\n"
		  echo $DebugerIP >> ip_debuger_dead.list
		  DebugerStat='dead'
		fi

		#sh RemoteConnTest-param.sh $ServerIP "$@" > /dev/null 2>&1
		sh check-boot.sh $ServerIP > /dev/null 2>&1
		if [ $? -eq 0 ];then
		  serverSuccess=$(($serverSuccess+1))
		  #echo "serverSuccess:$serverSuccess"
		  echo -e "\n\033[32m$ServerIP | success\033[0m\n"
		  echo $ServerIP >> ip_server_active.list
		  ServerStat='active'
		else
		  serverFailed=$(($serverfailed+1))
		  echo -e "\n\033[32m$ServerIP | failed\033[0m\n"
		  echo $ServerIP >> ip_server_dead.list
		  ServerStat='dead'
                fi
                ip_pairs_stat="$DebugerIP:$DebugerStat | $ServerIP:$ServerStat"
                echo $ip_pairs_stat >> ip_pairs_all_stat.txt
        done < $tmpIP_List_File

        return 0
}


rm -f ip_debuger_active.list
rm -f ip_debuger_dead.list
rm -f ip_server_active.list
rm -f ip_server_dead.list
rm -f ip_pairs_all_stat.txt

#Delete the space lines and comment lines
sed '/^#.*\|^[[:space:]]*$/d' $IP_List_File > $tmpIP_List_File

if [ $# != 1 ]
then
        echo "=========================================="
        echo "功能：批量在多台服务器上执行命令"
        echo "方法：$0 \"<cmd_to_exec>\""
        echo "返回：各服务器执行命令返回的结果列表"
        echo "前提：在待执行命令的各个服务器上设置了免密登录"
        echo "警告：禁止执行删除、格式化等这样的可能造成严重后果的命令"
        echo "=========================================="
        exit 1
fi


echo "确定要执行命令？[yes/no]：$@ "
read to_run

#local_ip=10.20.42.41

if [ $to_run = "yes" -o $to_run = "YES" -o $to_run = "y" -o $to_run = "Y" ]
then
        echo -e "\033[31m执行命令 : $@ \033[0m"
        do_command "$@"
else
        echo "取消执行命令!"
        exit 0
fi

#echo -e '\n========================================================'
echo  '========================================================'
echo -e "\033[32mDebuger -> success: $debugerSuccess | failed: $debugerFailed \033[0m"
echo -e "\033[32mServer  -> success: $serverSuccess | failed: $serverFailed \033[0m"
echo ""
