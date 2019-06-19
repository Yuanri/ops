# 1、bash 漏洞：
##【影响】
所有安装GNU bash 版本小于或者等于4.3的Linux操作系统

##【检测方法】
	方法1：
	env -i  X='() { (a)=>\' bash -c 'echo date'; cat echo
	（备注：输出结果中包含date字符串就修复成功了。）
	
	方法2：
	env x='() { :;}; echo vulnerable' bash -c "echo this is a test"
	(注：如果出现vulnerable ，表示存在漏洞)	




##【建议修补方案 】
请您根据Linux版本选择您需要修复的命令， 为了防止意外情况发生，建议您执行命令前先对Linux服务器系统盘打个快照，如果万一出现升级影响您服务器使用情况，可以通过回滚系统盘快照解决。

### centos:(最终解决方案) 
	yum clean all 
	yum makecache 
	yum -y update bash  

### ubuntu:(最终解决方案) 
	apt-cache gencaches 
	apt-get -y install --only-upgrade bash  

### debian:(最终解决方案) 
	7.5  64bit && 32bit  
	apt-cache gencaches 
	apt-get -y install --only-upgrade bash  
	
	6.0.x 64bit  
	wget http://mirrors.aliyun.com/debian/pool/main/b/bash/bash_4.1-3+deb6u2_amd64.deb &&  dpkg -i bash_4.1-3+deb6u2_amd64.deb  
	
	6.0.x 32bit  
	wget http://mirrors.aliyun.com/debian/pool/main/b/bash/bash_4.1-3+deb6u2_i386.deb &&  dpkg -i bash_4.1-3+deb6u2_i386.deb 
	aliyun linux:(最终解决方案) 
	
	5.x 64bit  
	wget http://mirrors.aliyun.com/centos/5/updates/x86_64/RPMS/bash-3.2-33.el5_10.4.x86_64.rpm && rpm -Uvh bash-3.2-33.el5_10.4.x86_64.rpm  
	
	5.x 32bit  
	wget http://mirrors.aliyun.com/centos/5/updates/i386/RPMS/bash-3.2-33.el5_10.4.i386.rpm  && rpm -Uvh bash-3.2-33.el5_10.4.i386.rpm  
	opensuse:(官方还没有给出最终解决方案，该方案存在被绕过的风险，阿里云会第一时间更新，请继续关注) 
	
	13.1 64bit 
	wget http://mirrors.aliyun.com/fix_stuff/bash-4.2-68.4.1.x86_64.rpm && rpm -Uvh bash-4.2-68.4.1.x86_64.rpm 
	
	13.1 32bit 
	wget http://mirrors.aliyun.com/fix_stuff/bash-4.2-68.4.1.i586.rpm && rpm -Uvh bash-4.2-68.4.1.i586.rpm 
