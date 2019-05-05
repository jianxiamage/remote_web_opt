#!/bin/python
#_*_coding:utf-8_*_

from threading import Thread  
import subprocess  
from Queue import Queue  

num_threads=3  
ips=['127.0.0.1','192.168.3.119','183.232.231.173','183.232.231.174','183.232.231.175']
q=Queue()
def pingme(i,queue):
    while True:  
        ip=queue.get()  
        print 'Thread %s pinging %s\n' %(i,ip)  
        ret=subprocess.call('ping -c 1 %s' % ip,shell=True,stdout=open('/dev/null','w'),stderr=subprocess.STDOUT)  
        if ret==0:  
            print '%s is alive!\n' %ip  
        elif ret==1:  
            print '%s is down...\n'%ip  
        queue.task_done()  

#start num_threads threads  
for i in range(num_threads):  
    t=Thread(target=pingme,args=(i,q))  
    t.setDaemon(True)  
    t.start()  

for ip in ips:  
    q.put(ip)  
print 'main thread waiting...\n'  
q.join();
print 'Done\n'
