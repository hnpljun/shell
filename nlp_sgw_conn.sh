#!/bin/bash
source /etc/profile

num=0
nginxNum=0
for i in 220 221 224 225; do
    nginxNum=`ssh 172.16.10.${i} "netstat -antp| grep ESTABLISHED | grep 30090 | wc -l"`
    num=`expr ${num} + ${nginxNum}`
done
echo ${num}