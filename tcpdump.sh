#!/bin/bash
#配置crontab，按天、小时、分钟生成文件
#天：00 00 * * *
#小时：00 * * * *
#分钟：*/10 * * * *
#00 * * * * /usr/bin/sh /opt/jidaPki/tcpdump/tcpdump.sh "/media" "gre_21000" "port_21000"
source /etc/profile

baseDir="${1}"
baseName="${2}"
pcapDir="${baseDir}/${baseName}"
#tcpdumpParam="port 18444 or 30090 or icmp"
tcpdumpParam="${3}"
tcpdumpPid=`ps -ef | grep tcpdump  | grep "${baseName}" | awk '{print $2}'`

if [[ -n ${tcpdumpPid} ]]; then
  for i in ${tcpdumpPid}; do
    kill -9 ${tcpdumpPid}
  done
fi

ctime=`date +'%Y%m%d%H%M%S'`
tcpdump ${tcpdumpParam} -w ${pcapDir}/${baseName}_${ctime}.pcap &

#文件保存时间
saveDays=7
find ${pcapDir} -type f -mtime +${saveDays} -exec rm -f {} \;