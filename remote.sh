#!/bin/bash
#yum -y install expect
#apt install expect

#path=`dirname $0`
#path=$(cd `dirname $0`; pwd)
#echo $path

path=$1
csvFile=$2
outFile=$3
rateFile=$4
destDir=$5
destFile=$6

rm -rf $outFile

echo "start read csv..."

while read line
do
	#读取CSV文件
	OLD_IFS="$IFS"
    	IFS=","
    	arr=($line)
    	IFS="$OLD_IFS"
	ip=${arr[0]}
	user=${arr[1]}
	pwd=${arr[2]}
	diskName1=${arr[3]}
	diskName2=${arr[4]}
	diskName3=${arr[5]}
	diskName4=${arr[6]}
	
	echo "上传脚本："
	$path/expect_rate.sh $ip $user $pwd $rateFile $destDir 
	
	echo "远程连接：$ip $user"

	$path/expect_info.sh $ip $user $pwd $outFile $destDir$destFile $diskName1 $diskName2 $diskName3 $diskName4
	
	var=$?
	#echo $var >> $outFile
	echo $ip,complete!
done < $csvFile

echo "complete!"
