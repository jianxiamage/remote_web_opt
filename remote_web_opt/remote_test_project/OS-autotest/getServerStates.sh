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
#-----------------------------------------------------------------
ServerIP=''
ServerIP=''
#-----------------------------------------------------------------
IP_List_File='hostlist.txt'
tmpIP_List_File='hostlist_filter.tmp'
#-----------------------------------------------------------------
retCode=0
success=0
failed=0
cmdLine='pwd'
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
		#echo "DebugerIP:[$ServerIP]"
		echo "ServerIP: [$ServerIP]"
		#ssh $host "$@"
		#sshpass -p $passwd  ssh -n -o "StrictHostKeyChecking no" $username@$host "$@"
		sh RemoteConnTest-param.sh $ServerIP $cmdLine > /dev/null 2>&1
		retCode=$?

		if [ $retCode -eq 0 ]; then
		  success=$(($success+1))
                  echo -e "\n\033[32m$ServerIP | success\033[0m\n"
                  #echo "success:$success"
		  echo $ServerIP >> ip_server_state_ok.list
		else
		  failed=$(($failed+1))
		  echo -e "\n\033[32m$ServerIP | failed\033[0m\n"
		  echo $ServerIP >> ip_server_state_error.list
		fi

        done < $tmpIP_List_File

        return 0
}

rm -f ip_server_state_ok.list
rm -f ip_server_state_error.list

#Delete the space lines and comment lines
sed '/^#.*\|^[[:space:]]*$/d' $IP_List_File > $tmpIP_List_File

#local_ip=10.20.42.41
cmdLine='pwd'
echo -e "\033[31m执行命令 : $cmdLine \033[0m"
do_command $cmdLine

#echo -e '\n========================================================'
echo  '========================================================'
echo -e "\033[32msuccess: $success | failed: $failed \033[0m"
echo ""
