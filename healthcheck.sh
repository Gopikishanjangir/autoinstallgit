#!/bin/bash

HOSTNAME=$(hostname)
DATET=$('date')
CPUSAGE=$(top -b -n 1 -d1 | grep "Cpu(s)" |awk '{print $2}' |awk -F. '{print $1}')
MEMUSAGE=$(free |grep Mem |awk '{print $3/$2 * 100.0}')
DISKUSAGE=$(df -h |column -t |awk '{print $5}' | tail -n 1 |sed 's/%//g')

echo 'HostName, Date&Time, CPUi(%), Mem(%), Disk(%)' >> /opt/usagereport
echo "$HOSTNAME, $DATET, $CPUSAGE, $MEMUSAGE, $DISKUSAGE" >> /opt/usagereport

for i in `cat /script/hostlist`;
do 
RHOSTNAME=$(ssh $i hostname)
RDATET=$(ssh $i 'date')
RCPUSAGE=$(ssh $i top -b -n 1 -d1 | grep "Cpu(s)" |awk '{print $2}' |awk -F. '{print $1}')
RMEMUSAGE=$(ssh $i free |grep Mem |awk '{print $3/$2 * 100.0}')
DISKUSAGE=$(ssh $i df -h |column -t |awk '{print $5}' | tail -n 1 |sed 's/%//g')

echo "$RHOSTNAME, $RDATET, $RCPUSAGE, $RMEMUSAGE, $RDISKUSAGE" >> /opt/usagereport
done
