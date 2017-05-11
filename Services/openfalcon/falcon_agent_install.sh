#!/bin/bash
#
# openfalcon 相关组件安装升级脚本
# 支持多机房部署
# 支持升级组件
# 
#

# openfalcon 其他组件部署：请自行修改App 
App=falcon-agent
AGENT=${App}.tgz

# 此处的URL请改为自己的资源路径
HOST=openfalcon.example.com
URL="http://127.0.0.1/openfalcon/$AGENT -o $AGENT --progress"
InstallDir=/data/softwares/openfalcon

# 配置falcon 组件的运行账号
User=openfalcon
useradd  $User
usermod -L  $User


echo == yum install git nc
yum install git nc  -y >/dev/null 

echo "== Dowload Package: $AGENT"
test -d $InstallDir ||  mkdir $InstallDir -p  
cd $InstallDir
test -f $AGENT &&  rm -f  $AGENT
curl -H "Host:$HOST" $URL

echo "== Install or Update: $AGENT "
echo "== Install Path : $InstallDir"
test -d ./$App/plugin && mv   ./$App/plugin  ./$App/plugin-bak$(date '+%F')
tar -xf $AGENT
cd   ./$App

HOST=$(hostname |cut -d'.' -f1|cut -d'-' -f2-5|tr '-' '.')
sed -i "s/\"hostname\":.*/\"hostname\":\"$HOST\",/"  cfg.json
sed -i 's/"debug": .*/"debug": false,/'  cfg.json


chown -R  root.root  ${InstallDir}/${App} 
test -d var || mkdir var
chown -R  $User.$User var


# 跨区域部署
# AWS Default HBS port ：10.0.2.163:6030
# 
HBS_DEFAULT=x.x.x.x
HBS_PORT=6030
HBS_Eire=x.x.x.x
HBS_Singapore=x.x.x.x
HBS="$HBS_Eire $HBS_Singapore"
hbs_server=$HBS_DEFAULT
for hbs in $HBS
do
	re=$(nc -v -w 1  $hbs $HBS_PORT | grep -wc  succeeded)
	wait
	if [[ $re -eq 1 ]];then
		hbs_server=$hbs
		sed -i "s/$HBS_DEFAULT/$hbs/"  cfg.json
	fi
done 

echo "== HBS Server:$hbs_server"
echo "== $App Restart"
./control stop
su $User -c './control start'
wait

# cronta monitor falcon-agent
CRON_File=/var/spool/cron/root
if [[ $(grep -wc Ubuntu /etc/issue) -ne 0  ]];then
	echo == OS : Ubuntu
	CRON_File=/var/spool/cron/crontabs/root
fi	

crontab -l >> /root/shell/cron_bak.$$
sed -i "/${App}\/falcon_monitor.sh/d" $CRON_File
echo "*/3 * * * * sh ${InstallDir}/${App}/falcon_monitor.sh  >/dev/null 2>&1" >> $CRON_File


ps -ef | grep falcon-agent
echo == tail var/app.log
tail var/app.log


