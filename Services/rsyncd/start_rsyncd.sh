#!/bin/bash
#
# 此脚本和VSFTP 公用虚拟账号
# rysncd 启动脚本，
# db_user=../conf/virtusers 账号配置，一行账号，一号密码，删除多余行
# 默认监听eth0 的IP地址
#

cd $(dirname $0)
logfile=../log/rsyncd.log
db_user=../conf/virtusers


echo $(date '+%F %T') create new passfile for rsyncd |tee -a $logfile
rsync_pass=../rsyncconf/rsyncd.pass
awk 'NR%2==1{printf("%s:",$1)}NR%2==0{print $1}' $db_user > $rsync_pass
chmod 400 $rsync_pass


echo $(date '+%F %T') create new config for rsyncd |tee -a $logfile
rsyncbasic=../rsyncconf/rsync_basic.conf
rsyncuser=../rsyncconf/rsync_user.tmp
rsynccfg=../rsyncconf/rsyncd.conf
cat $rsyncbasic > $rsynccfg

ipaddress=$($(which ip) -f inet a|awk '/scope global eth0/{print $2}'|sed 's#/.*##' )
test  ${ipaddress}"XX" == "XX" && ipaddress=127.0.0.1
echo $(date '+%F %T') rsync server listen ip address ${ipaddress} |tee -a $logfile
sed -i "s/address=.*/address=${ipaddress}/" $rsynccfg

for user in $(awk 'NR%2==1' $db_user )
do
	sed "s/rsyncuser/$user/"  $rsyncuser >> $rsynccfg
done

echo $(date '+%F %T') restart rsyncd server | tee -a $logfile
pidfile=$(awk -F '=' '/pid file/{print $NF}' $rsyncbasic)
test -f $pidfile && rm -f $pidfile

echo $(date '+%F %T') strat rsyncd server | tee -a $logfile
$(which rsync) --daemon 4 --config=$rsynccfg
