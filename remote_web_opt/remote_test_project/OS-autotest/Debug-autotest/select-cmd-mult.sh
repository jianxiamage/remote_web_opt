#!/bin/bash

# ==========================================
# 功能：批量在多台服务器上执行命令
# 方法：./batch_cmd_manager.sh <cmd_to_exec>
# 返回：各服务器执行命令返回的结果列表
# 前提：在待执行命令的各个服务器上设置了免密登录
# 警告：禁止执行删除、格式化等这样的可能造成严重后果的命令
# 日期：2018-04-23
# By：HackHan
# 其他：设置免密登录参考：https://blog.csdn.net/zoombinde/article/details/51902208
# 文件：batch_cmd_manager.sh
# ==========================================
username=root
passwd=loongson

do_command()
{
        hosts=`sed -n '/^[^#]/p' hostlist.txt`
        for host in $hosts
                do
                        echo ""
                        echo HOST $host
                        #ssh $host "$@"
                        sshpass -p $passwd  ssh -n -o "StrictHostKeyChecking no" $username@$host "$@"

                done
        return 0
}


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

local_ip=10.20.42.41

if [ $to_run = "yes" -o $to_run = "YES" -o $to_run = "y" -o $to_run = "Y" ]
then
        echo ""
        echo -e "\033[31m执行命令 : $@ \033[0m"
        do_command "$@"
        echo ""
        echo HOST $local_ip
        $@
else
        echo "取消执行命令！"
fi

echo ""
echo "=========================================="
