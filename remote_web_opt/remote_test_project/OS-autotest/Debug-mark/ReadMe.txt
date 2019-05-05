本目录下主要保存了用于远程连接测试批量机器的脚本
其中最为核心的功能脚本是：
get_IPStates_Pairs.sh
测试调试器和与之配对的服务器是否能够ping通，
并将机器对的状态写入文件：ip_pairs_all_stat.txt

以下是脚本及简要功能介绍：
本目录下的文件是在测试集群管理时的实验用脚本：
directory tree:

├── check-boot.sh
├── del-log.sh
├── exceptionTrap.sh
├── get_IPStates_Pairs.sh
├── hostlist_filter.tmp
├── hostlist.txt
├── IP-config.sh
├── ip_debuger_active.list
├── ip_pairs_all_stat.txt
├── ip_server_active.list
├── log.py
├── os-preEnv.sh
├── RemoteConnTest-bat.sh
├── RemoteConnTest-param.sh
├── RemoteConnTest.sh
├── RemoteDebuger-ejtag.sh
├── RemoteDebuger-power-off.sh
├── RemoteDebuger-power-on.sh
├── rmTempFile.py
└── shell-log.sh

check-boot.sh
测试目标机器是否开机(ping)

del-log.sh
删除日志信息文件

exceptionTrap.sh
异常处理

get_IPStates_Pairs.sh
测试调试器和与之配对的服务器是否能够ping通，并将机器对的状态写入文件：ip_pairs_all_stat.txt

hostlist_filter.tmp
对hostlist.txt进行筛选，去除#号与空行得到此文件

hostlist.txt
测试多机是否开机使用的机器ip列表文件，需要用户手工填入

IP-config.sh
设置调试器ip信息

ip_debuger_active.list
查看调试器是否可以连接

ip_pairs_all_stat.txt
调试器与服务器ip对文件筛选出全部能够连接成功的记录文件

ip_server_active.list
服务器可以连接的脚本

log.py
python日志

os-preEnv.sh
测试机器要安装环境

RemoteConnTest-bat.sh
多机器连接的批处理版本脚本

RemoteConnTest-param.sh
多机器连接测试调用的脚本，参数为ip

RemoteConnTest.sh
单机测试调试器可以连接成功

RemoteDebuger-ejtag.sh
远程连打开ejtag调试界面

RemoteDebuger-power-off.sh
单机测试：使用调试器给服务器关机

RemoteDebuger-power-on.sh
单机测试：使用调试器给服务器开机（重启)

rmTempFile.py
删除程序中的临时文件

shell-log.sh
shell脚本日志

