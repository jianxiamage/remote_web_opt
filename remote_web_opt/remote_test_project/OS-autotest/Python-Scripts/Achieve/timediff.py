#!/bin/python
#_*_coding:utf-8_*_
import datetime
import time

starttime = datetime.datetime.now()
#long running
time.sleep(2)
endtime = datetime.datetime.now()
result_sec=(endtime - starttime).seconds
print('程序运行时间:[秒]')
print(result_sec)

