#!/bin/bash

source /etc/profile

speechDir="/opt/jidaPki/tcpdump/speech-pki-uat"
tcpdumppid=`ps -ef | grep tcpdump  | grep 18444 | awk '{print $2}'`

find ${speechDir} -type f -mtime +1 -exec rm -f {} \;

if [[ -n ${tcpdumppid} ]]; then
    for i in ${tcpdumppid}; do
        kill -9 ${tcpdumppid}
    done
fi

ctime=`date +'%Y%m%d%H%M%S'`
tcpdump tcp port 18444 or 30090 -w ${speechDir}/speech-pki-uat_${ctime}.pcap &