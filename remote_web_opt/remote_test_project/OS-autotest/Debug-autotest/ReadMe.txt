本目录下的文件是在测试集群管理时的实验用脚本：

0 directories, 8 files
├── check-boot.sh
├── hostlist.txt
├── ip_user_passwd.txt
├── multi-exec.sh
├── ReadMe.txt
├── RemoteConnTest-bat.sh
├── RemoteConnTest-param.sh
└── select-cmd-mult.sh


check-boot.sh
测试目标机器是否开机(ping)

hostlist.txt
测试多机是否开机使用的机器ip列表文件，需要用户手工填入

multi-exec.sh
多机器验证是否连接成功

RemoteConnTest-bat.sh
多机器连接的批处理版本脚本

RemoteConnTest-param.sh
多机器连接测试调用的脚本，参数为ip

select-cmd-mult.sh
多机器连接测试是否成功

ip_user_passwd.txt
保存的是要测试的机器的ip、用户名及密码
