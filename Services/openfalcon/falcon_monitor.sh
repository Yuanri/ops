
#falcon_monitor.sh
#!/bin/bash
#
#  openfalcon 先关组件通用监控脚本，
#  请将此脚本放在 openfalcon 组件的 control 同级目录下
#
#

# 配置bash 环境变量，让其可以找到 ss 
export  PATH=$PATH:/usr/sbin:/usr/local/sbin:/usr/local/bin

cd $(dirname $0)
AppName=$(basename `pwd`)

# 配置普通用户运行
User=openfalcon
echo AppName: $AppName

start_agent(){
	if test -f  $AppName 
	then 
		if test $(id -u) -eq 0 ;then
			su  $User -c  './control start'
		else
			./control start
		fi
	else
		echo $AppName is not installed, PL check
	fi
}


# start to check  falcon-agent
URL=$(awk  -F '"' '/"http"/,/listen/{URL=$4}END{print URL}'  cfg.json)
echo Listen: $URL
re=$(curl -s  $URL/health)
if [  "$re"  != "ok" ]; then
	echo Status  : $re [not running, try to restart is]
	start_agent
else
	echo Status  : $re [running]	
fi
