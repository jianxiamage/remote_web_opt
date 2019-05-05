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
retCode=0
success=0
failed=0
#-----------------------------------------------------------------
do_command()
{
        hosts=`sed -n '/^[^#]/p' hostlist.txt`
        for host in $hosts
                do
                        echo "--------------------------------------------------------"
                        #echo ""
                        #echo Host $host
                        #ssh $host "$@"
                        #sshpass -p $passwd  ssh -n -o "StrictHostKeyChecking no" $username@$host "$@"
                        sh RemoteConnTest-param.sh $host "$@"
                        retCode=$?

			if [ $retCode -eq 0 ]; then
                          success=$(($success+1))
                          echo -e "\n\033[32m$host | success\033[0m\n"
                          echo $host >> ip_connected_ok.list
                          #echo "--------------------------------------------------------"
			else
                          failed=$(($failed+1))
                          echo -e "\n\033[32m$host | failed\033[0m\n"
                          echo $host >> ip_connected_error.list
                          #echo "--------------------------------------------------------"
			fi

                done
        return 0
}


rm -f ip_connected_ok.list
rm -f ip_connected_error.list

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
echo -e "\033[32msuccess: $success | failed: $failed \033[0m"
echo ""
