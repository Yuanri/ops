#!/bin/bash
cd $(dirname $0)

procPath=/data/monitor/process-check-scripts
reInfo=/tmp/proc_check.tmp
cd $procPath

test -f $1 || exit
if test ! -x $1;then
	echo 11
	exit
fi

./$1  >$reInfo  2>$reInfo.$$
errInfo=$(wc -c $reInfo.$$ |awk '{print $1}')

if test $errInfo -eq 0
then
        grep -c 'ok' $reInfo
else
         echo 10
fi

rm -f $reInfo  $reInfo.$$

