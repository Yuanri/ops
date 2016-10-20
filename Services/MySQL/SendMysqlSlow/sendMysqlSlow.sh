#!/bin/bash

cd $(dirname $0)



slowfile=/data/mysql/log/slow.log-$(date  "+%Y%m%d")
repo=$(/sbin/ip -4 addr | /bin/awk '/ global /{print $2;exit}' | /bin/sed  's/\/.*//').slow.log-$(date -d '1 days ago' "+%Y%m%d").txt

test -f $slowfile && mv $slowfile $slowfile.$$
/usr/sbin/logrotate -f mysqlSlowRotate

#/data/softwares/mysql-percona/bin/mysqldumpslow $slowfile > $repo
test -f $slowfile && ./pt-query-digest  $slowfile > $repo || echo 'NO slow log' > $repo

to_list="receiver1  receiver2 receiver3"


/usr/bin/python sendmail.py "$to_list" $repo

rm -f $repo
