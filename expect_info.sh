#!/usr/bin/expect -f

set timeout 120
set ip [lindex $argv 0]
set user [lindex $argv 1]
set pwd [lindex $argv 2]
set outFile [lindex $argv 3]
set destFile [lindex $argv 4]
set diskName1 [lindex $argv 5]
set diskName2 [lindex $argv 6]
set diskName3 [lindex $argv 7]
set diskName4 [lindex $argv 8]


#打开文件
set tmp_file [open $outFile a+]

spawn ssh -o StrictHostKeyChecking=no -p22 $user@$ip

expect {
    "(yes/no)?"
    {
    send "yes\n"
    expect "*assword:" { send "$pwd\n"}
    }
    "*assword:"
    {
    send "$pwd\n"
    }
}

expect "*#"

send "yum -y install bc\r"
send "chmod 777 $destFile\r"

send "$destFile $ip $diskName1 $diskName2 $diskName3 $diskName4\r"

expect {
	-re "info:(.*)" {
		set remoteVal $expect_out(buffer)

		set vals [split $remoteVal "\n"]

		foreach val $vals {
			set sv [split $val ":"]
			#puts $tmp_file [lindex $sv 0]

			if {"info"==[lindex $sv 0]} {
				puts $tmp_file [lindex $sv 1]
			}
		}

		#puts $tmp_file $[lindex $vals 0]
		#puts $tmp_file $[lindex $vals 1]

		#set cpuStr [lindex $vals 2]
		#set cpuVals [split $cpuStr ":"]
		#set cpu [lindex $cpuVals 1]

                #set memStr [lindex $vals 3]
                #set memVals [split $memStr ":"]
                #set mem [lindex $memVals 1]

                #set diskStr [lindex $vals 4]
                #set diskVals [split $diskStr ":"]
                #set disk [lindex $diskVals 1]i
		
		#puts $tmp_file $cpu
		#puts $tmp_file $mem
		#puts $tmp_file $disk
		#set val "$ip,$cpu,$mem,$disk"
		#set val "$ip,$cpu,$mem,$disk"
		#puts $tmp_file $val
		#puts $tmp_file $remoteVal
		
		unset expect_out(buffer)
		
		
	}
}

send "exit\r"

expect eof

#关闭文件
close $tmp_file

#catch wait result
#exit [lindex $result 3]
exit 1
