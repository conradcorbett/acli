#!/bin/bash

#script will output transmitted and received Mbps on AHV host
#run the script directly on the AHV host from /root directory

INTERVAL="1"  # update interval in seconds
if [ -z "$1" ]; then
  echo
  echo usage: $0 [network-interface]
  echo
  echo e.g. $0 eth0
  echo
  exit
fi
IF=$1
while true
do
  RB1=`cat /sys/class/net/$1/statistics/rx_bytes`
  TB1=`cat /sys/class/net/$1/statistics/tx_bytes`
  RP1=`cat /sys/class/net/$1/statistics/rx_packets`
  TP1=`cat /sys/class/net/$1/statistics/tx_packets`
  TD1=`cat /sys/class/net/$1/statistics/tx_dropped`
  RD1=`cat /sys/class/net/$1/statistics/rx_dropped`
  MCAST1=`cat /sys/class/net/$1/statistics/multicast`
  sleep $INTERVAL
  RB2=`cat /sys/class/net/$1/statistics/rx_bytes`
  TB2=`cat /sys/class/net/$1/statistics/tx_bytes`
  RP2=`cat /sys/class/net/$1/statistics/rx_packets`
  TP2=`cat /sys/class/net/$1/statistics/tx_packets`
  TD2=`cat /sys/class/net/$1/statistics/tx_dropped`
  RD2=`cat /sys/class/net/$1/statistics/rx_dropped`
  MCAST2=`cat /sys/class/net/$1/statistics/multicast`
  TBps=`expr $TB2 - $TB1`
  TMbps=`expr $TBps / 131072`
  RBps=`expr $RB2 - $RB1`
  RMbps=`expr $RBps / 131072`
  TPps=`expr $TP2 - $TP1`
  RPps=`expr $RP2 - $RP1`
  TDps=`expr $TD2 - $TD1`
  RDps=`expr $RD2 - $RD1`
  McstPps=`expr $MCAST2 - $MCAST1`
  echo "tx: $TMbps Mbps / $TPps pps / $TDps dps   rx: $RMbps Mbps / $RPps pps / $RDps dps   mcast: $McstPps pps"
done