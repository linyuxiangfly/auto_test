#!/bin/bash

ip=$1
diskName1=$2
diskName2=$3
diskName3=$4
diskName4=$5

#set ip [lindex $argv 0]
#set diskName1 [lindex $argv 1]
#set diskName2 [lindex $argv 2]
#set diskName3 [lindex $argv 3]
#set diskName4 [lindex $argv 4]

#echo $ip $diskName1 $diskName2 $diskName3 $diskName4

cpu_id=`top -bn 1 | sed -n 3p |awk -F , '{print $4}'|awk '{print $1}'`
export cpu=$(echo "scale=2;  100-${cpu_id}" | bc)

#统计内存使用率
mem_used_persent=`free -m | awk -F '[ :]+' 'NR==2{printf "%d", ($3)/$2*100}'`
# -e参数是使 "\n"换行符生效进行输出换行的
mem=$mem_used_persent

disk1=`df -Ph |grep /dev/$diskName1|awk '{print $5}'|cut -f 1 -d "%"`
disk2=`df -Ph |grep /dev/$diskName2|awk '{print $5}'|cut -f 1 -d "%"`
disk3=`df -Ph |grep /dev/$diskName3|awk '{print $5}'|cut -f 1 -d "%"`
disk4=`df -Ph |grep /dev/$diskName4|awk '{print $5}'|cut -f 1 -d "%"`

echo "info:$ip,$cpu,$mem,$disk1,$disk2,$disk3,$disk4"
