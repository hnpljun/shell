#!/bin/bash
#每10秒采集一次服务器中指定端口的连接数
#配合crontab使用：
#37 16 17 * * /usr/bin/sh /opt/jidaPki/network/getConnForPort.sh

port=30090
while true; do
  secTime=`/bin/date '+%S'`
  minTime=`/bin/date '+%M'`
  case "${secTime}" in
    00|10|20|30|40|50)
      num=`netstat -antp | grep :${port} | grep ESTABLISHED | wc -l`
      numTime=`/bin/date '+%Y-%m-%d %T'`
      echo "${numTime} connNum ${num}" >> /opt/jidaPki/network/speech_netstat_$(/bin/hostname).log
      sleep 1
      ;;
  esac
  #指定退出脚本的条件
  if [ ${minTime} -eq 40 ]; then
    exit 0
  fi
done