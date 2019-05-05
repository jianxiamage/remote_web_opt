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
DebugerIP=''
ServerIP=''
#-----------------------------------------------------------------
IP_List_File='hostlist.txt'
tmpIP_List_File='hostlist_filter.tmp'
#-----------------------------------------------------------------
retCode=0
success=0
failed=0
cmdLine=''
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
                        #echo Host $host
                        #ssh $host "$@"
                        #sshpass -p $passwd  ssh -n -o "StrictHostKeyChecking no" $username@$host "$@"
                        sh RemoteConnTest-param.sh $DebugerIP $cmdLine  > /dev/null 2>&1
                        retCode=$?

			if [ $retCode -eq 0 ]; then

                             sh check-boot.sh $ServerIP > /dev/null 2>&1

			     if [ $? -eq 0 ];then
                                success=$(($success+1))
                                #echo "success:$success"
                                echo -e "\n\033[32m$host | success\033[0m\n"
                                echo $ServerIP >> ip_server_ok.list
                                echo "$DebugerIP $ServerIP">> ip_pairs_active.list
                                #echo "--------------------------------------------------------"
			     else
                                failed=$(($failed+1))
                                echo -e "\n\033[32m$host | failed\033[0m\n"
                                echo $ServerIP >> ip_server_error.list
                                echo "$DebugerIP $ServerIP">> ip_pairs_dead.list
                                #echo "--------------------------------------------------------"
			     fi

                          echo $DebugerIP >> ip_debuger_active.list
                          #echo "--------------------------------------------------------"
			else
                          failed=$(($failed+1))
                          echo -e "\n\033[32m$host | failed\033[0m\n"
                          echo $DebugerIP >> ip_debuger_dead.list
                          #echo "--------------------------------------------------------"
			fi
        done < $tmpIP_List_File
        return 0
}


#ip_server_ok.list:调试器开机可连状态下，server也能ping通
#ip_server_error.list:调试器开机可连状态下，server不能ping通

rm -f ip_server_ok.list
rm -f ip_pairs_active.list
rm -f ip_server_error.list
rm -f ip_debuger_active.list
rm -f ip_debuger_dead.list

#Delete the space lines and comment lines
sed '/^#.*\|^[[:space:]]*$/d' $IP_List_File > $tmpIP_List_File

#local_ip=10.20.42.41
cmdLine='pwd'
echo -e "\033[31m执行命令 : $cmdLine \033[0m"
#do_command "$@"
do_command $cmdLine

#echo -e '\n========================================================'
echo  '========================================================'
echo -e "\033[32msuccess: $success | failed: $failed \033[0m"
echo ""
