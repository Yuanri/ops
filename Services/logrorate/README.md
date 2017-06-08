
# logrotate日志管理工具

logrotate是一个日志文件管理工具。

用来把旧文件轮转、压缩、删除，并且创建新的日志文件。
我们可以根据日志文件的大小、天数等来转储，便于对日志文件管理

一般都是通过cron计划任务来完成的。

## 缺省配置 logrotate

	logrotate 缺省的配置募/etc/logrotate.conf。
	Red Hat Linux 缺省安装的文件内容是：

	# see "man logrotate" for details
	# rotate log files weekly
	weekly

	# keep 4 weeks worth of backlogs
	rotate 4

	# send errors to root
	errors root
	# create new (empty) log files after rotating old ones
	create

	# uncomment this if you want your log files compressed
	#compress
	1
	# RPM packages drop log rotation information into this directory
	include /etc/logrotate.d

	# no packages own lastlog or wtmp --we'll rotate them here
	/var/log/wtmp {
	monthly
	create 0664 root utmp
	rotate 1
	}

	/var/log/lastlog {
	monthly
	rotate 1
	}

	# system-specific logs may be configured here


## 1、配置实例
	
	/var/log/messages{
		rotate 5
		weekly
		postrotate
		  /sbin/killall -HUP syslogd	
		endscript	
	}

	"/var/log/httpd/access.log" /var/log/httpd/error.log {
		rotate 5
		mail www@my.org
		size 100k
		sharedscripts
		postrotate
			/sbin/killall -HUP httpd
		endscript
	}

	/var/log/news/* {
		monthly
		rotate 2
		olddir /var/log/news/old
		missingok
		postrotate
			kill -HUP ‘cat /var/run/inn.pid‘
		endscript
		nocompress
	}
	
	#nginx 日志回滚
	/data/log/nginx/videoportal/boss-access.log
	{
	daily                 
	dateext
	rotate 7
	compress                   
	missingok                     
	notifempty                
	sharedscripts             
	postrotate                  
	if [ -f /data/softwares/nginx/logs/nginx.pid ]
	then
		kill -USR1 `cat /data/softwares/nginx/logs/nginx.pid`
	fi
	endscript                    
	}



### 针对正在打开的文件进行日志管理：
如 Tomcat 的默认日志输出，数据库的慢日志回滚等

	/data/server/tcl-findmyphone-web-8080/logs/catalina.out {
		copytruncate
		daily
		dateext
		delaycompress
		missingok
		notifempty
		rotate 7
		size 100M
	}

## 2. 配置选项说明
	compress:		通过gzip 压缩转储旧的日志
	nocompress：		不需要压缩时，用这个参数
	copytruncate：		用于还在打开中的日志文件，把当前日志备份并截断
	nocopytruncate：		备份日志文件但是不截断
	create mode owner group：使用指定的文件模式创建新的日志文件
	nocreate：		不建立新的日志文件
	delaycompress：和 compress 一起使用时，转储的日志文件到下一次转储时才压缩
	nodelaycompress：	覆盖 delaycompress 选项，转储同时压缩。
	errors address：		专储时的错误信息发送到指定的Email 地址
	ifempty：		即使是空文件也转储，这个是 logrotate 的缺省选项。
	notifempty：		如果是空文件的话，不转储
	mail address：		把转储的日志文件发送到指定的E-mail 地址
	nomail：			转储时不发送日志文件
	olddir directory：	转储后的日志文件放入指定的目录，必须和当前日志文件在同一个文件系统
	noolddir：		转储后的日志文件和当前日志文件放在同一个目录下
	prerotate/endscript：	在转储以前需要执行的命令可以放入这个对，这两个关键字必须单独成行
	postrotate/endscript：	在转储以后需要执行的命令可以放入这个对，这两个关键字必须单独成行
	sharedscripts：		所有的日志文件都轮转完毕后统一执行一次脚本
	daily：			指定转储周期为每天
	weekly：			指定转储周期为每周
	monthly：		指定转储周期为每月
	rotate count：		指定日志文件删除之前转储的次数，0 指没有备份，5 指保留5 个备份
	size size：		当日志文件到达指定的大小时才转储，Size 可以指定 bytes (缺省)以及KB (sizek)或者MB

## 3. 命令参数说明
 	logrotate --help
	Usage: logrotate [OPTION...] <configfile>
  	-d, --debug               调试模式，输出调试结果，并不执行。隐式-v参数
  	-f, --force               强制模式，对所有相关文件进行rotate
  	-m, --mail=command        发送邮件 (instead of `/bin/mail')
  	-s, --state=statefile     状态文件，对于运行在不同用户情况下有用
  	-v, --verbose             显示debug信息
