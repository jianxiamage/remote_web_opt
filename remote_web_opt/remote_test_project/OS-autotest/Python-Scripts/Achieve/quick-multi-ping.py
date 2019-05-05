#!/usr/bin/python
#_*_coding:utf-8_*_
#
'''
#程序功能：快速多线程ping程序
'''
import sys
import pexpect
import datetime
from threading import Thread
from threading import Lock

hostListFile='hostlist.txt'
host=[]
#with open('accounts.txt','r') as f:
#    for line in f:
#        host.append(list(line.strip('\n').split(',')))
#print(host)

print("===========================================================")
#f = open('accounts.txt')
f = open(hostListFile)
host = [line.strip() for line in f.readlines()]
f.close()
print host
#[['127.0.0.1'], ['10.20.42.41'], ['10.20.42.220'], ['192.168.1.10']]
type(host)

print("===========================================================")
#['127.0.0.1', '10.20.42.41', '10.20.42.220', '192.168.1.10']
report_ok=[]
report_error=[]

mutex=Lock()
#ip_pairs_all_file=open('ip_pairs_all_stat.txt','w')  #新建一个储存有效IP的文档
class PING(Thread):
  def __init__(self,ip):
    Thread.__init__(self)
    self.ip=ip
  def run(self):
    Curtime = datetime.datetime.now()  
    #Scrtime = Curtime + datetime.timedelta(0,minute,0) 
    #print("[%s]主机[%s]" % (Curtime,self.ip))
    #mutex.acquire()  #等待可以上锁，通知而不是轮训，没有占用CPU
    line = self.ip.split(" ")#按照空格键分割每一行里面的数据
    #print(line)
    #ping=pexpect.spawn("ping -c1 %s" % (self.ip))
    DebugerIP=str(line[0])
    ping=pexpect.spawn("ping -c1 %s" % (line[0]))
    check=ping.expect([pexpect.TIMEOUT,"1 packets transmitted, 1 received, 0% packet loss"],2)
    DebugerStat=''
    if check == 0:
      print("[%s] %s 超时\n" % (Curtime,line[0]))
    elif check == 1:
      print ("[%s] %s 可达\n" % (Curtime,line[0]))
      DebugerStat=DebugerIP + ':alive' 
    else:
      print("[%s] 主机%s 不可达\n" % (Curtime,line[0]))
      DebugerStat=DebugerIP + ':down'
    ip_pairs_stat=DebugerStat + ' | ' 

    ping=pexpect.spawn("ping -c1 %s" % (line[1]))
    check=ping.expect([pexpect.TIMEOUT,"1 packets transmitted, 1 received, 0% packet loss"],2)
    if check == 0:
      print("[%s] %s 超时\n" % (Curtime,line[1]))
    elif check == 1:
      print ("[%s] %s 可达\n" % (Curtime,line[1]))
    else:
      print("[%s] 主机%s 不可达\n" % (Curtime,line[1]))
    #ip_pairs_all_file.write('%s\n' %str(ip_pairs_stat))#写入成对IP状态到文件
    #mutex.release()#解锁
    #ip_pairs_all_file.close()  #关闭文件
#多线程同时执行
T_thread=[]
for i in host:
  t=PING(i)
  T_thread.append(t)
for i in range(len(T_thread)):
  T_thread[i].start()
#
#ip_pairs_all_file.close()  #关闭文件
#print ("\n=========问题主机情况如下==========\n")
#output(report_error)
#print ("\n=========正常主机情况如下==========\n")
#output(report_ok)
