#!/bin/bash

source /etc/profile
tcpdumppid=`ps -ef | grep tcpdump  | grep 18444 | awk '{print $2}'`

if [ -n ${tcpdumppid} ]; then
    kill -9 ${tcpdumppid}
fi

ctime=`date +'%Y%m%d%H%M%S'`
tcpdump tcp port 18444 or 30090 -w /data/${ctime}.pcap &
###00 * * * * /usr/bin/sh /data/tcpdump.sh