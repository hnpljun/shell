#!/bin/bash

source /etc/profile

baseDir="/opt/jidaPki/tcpdump"
baseName="speech-pki-uat"
pcapDir="${baseDir}/${baseName}"
tcpdumpParam="port 18444 or 30090 or icmp"
tcpdumpPid=`ps -ef | grep tcpdump  | grep "${baseName}" | awk '{print $2}'`

if [[ -n ${tcpdumpPid} ]]; then
    for i in ${tcpdumpPid}; do
	kill -9 ${tcpdumpPid}
    done
fi

ctime=`date +'%Y%m%d%H%M%S'`
tcpdump ${tcpdumpParam} -w ${pcapDir}/${baseName}_${ctime}.pcap &

find ${pcapDir} -type f -mtime +1 -exec rm -f {} \;