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

hostListFile='hostlist.txt'
host=[]
#with open('accounts.txt','r') as f:
#    for line in f:
#        host.append(list(line.strip('\n').split(',')))
#print(host)

print("===========================================================")
f = open('accounts.txt')
host = [line.strip() for line in f.readlines()]
f.close()
print host
#[['127.0.0.1'], ['10.20.42.41'], ['10.20.42.220'], ['192.168.1.10']]
type(host)

print("===========================================================")
#['127.0.0.1', '10.20.42.41', '10.20.42.220', '192.168.1.10']
report_ok=[]
report_error=[]
class PING(Thread):
  def __init__(self,ip):
    Thread.__init__(self)
    self.ip=ip
  def run(self):
    Curtime = datetime.datetime.now()  
    #Scrtime = Curtime + datetime.timedelta(0,minute,0) 
    #print("[%s]主机[%s]" % (Curtime,self.ip))
    ping=pexpect.spawn("ping -c1 %s" % (self.ip))
    check=ping.expect([pexpect.TIMEOUT,"1 packets transmitted, 1 received, 0% packet loss"],2)
    if check == 0:
      print("[%s] %s 超时" % (Curtime,self.ip))
    elif check == 1:
      print ("[%s] %s 可达" % (Curtime,self.ip))
    else:
      print("[%s] 主机%s 不可达" % (Curtime,self.ip))
#多线程同时执行
T_thread=[]
for i in host:
  t=PING(i)
  T_thread.append(t)
for i in range(len(T_thread)):
  T_thread[i].start()
#
#print ("\n=========问题主机情况如下==========\n")
#output(report_error)
#print ("\n=========正常主机情况如下==========\n")
#output(report_ok)
