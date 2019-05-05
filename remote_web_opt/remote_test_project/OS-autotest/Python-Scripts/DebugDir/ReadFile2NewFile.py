#!/bin/python
#_*_coding:utf-8_*_

import os
#----------------------------------------------------------------
#输入文件
#str1=sys.argv[1]
objFile='hostlist.txt'
#输出文件
#str2=sys.argv[2]
resultFile='resultlist.txt'
#打开文件
try:
    file_object=open(objFile,"r+")
    file_result=open(resultFile,"w+")
except IOError:
    print "找不到这个文件"
#----------------------------------------------------------------
#file_object= open('sample.txt', "r")
trainlines = file_object.read().splitlines()  #返回每一行的数据

print('Begin to Test:................................................')
#os.remove(resultFile)
for line in trainlines:
    #line = line.strip()
    #if IsPrime(int(line)):

    line = line.split(" ")  #按照空格键分割每一行里面的数据
    box = [(line[0]), (line[1])]
    strbox=line[0]+' ' + line[1]
    print(strbox)

    if True:
       file_result.write(strbox+"\n")
    else:
       continue
file_object.close()
file_result.close()
