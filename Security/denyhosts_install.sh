#!/bin/bash
# denyhosts install
#

URL_denyhosts=https://github.com/ProForks/denyhosts/archive/master.zip
URL_ipaddr=https://pypi.python.org/packages/9d/a7/1b39a16cb90dfe491f57e1cab3103a15d4e8dd9a150872744f531b1106c1/ipaddr-2.2.0.tar.gz
        
# config logrorate
echo '/var/log/denyhosts {
	copytruncate
	daily
	dateext
	delaycompress
	missingok
	notifempty
	rotate 7
}'   >  /etc/logrotate.d/denyhosts 


#install ipaddr
wget $URL_ipaddr
tar -zxf ipaddr-2.2.0.tar.gz
cd  ipaddr-2.2.0
python setup.py install
cd ..

# download denyhosts.tgz and install
wget $URL_denyhosts
unzip  master.zip
cd  denyhosts-master
python setup.py install


# set config
mkdir -p /var/lib/denyhosts
cp -r  allowed-hosts  plugins  /var/lib/denyhosts/
cp  logrorate-denyhosts  /etc/logrotate.d/
echo '/etc/init.d/denyhosts start' >> /etc/rc.local

echo "=== copy the daemon script "
echo "cp  daemon-control-dist /etc/init.d/denyhosts"
echo "cp  denyhosts.py  /usr/sbin/denyhosts"
cp  daemon-control-dist /etc/init.d/denyhosts
cp  denyhosts.py  /usr/sbin/denyhosts

# check sshd neither support the  tcp_wrap module
if test -z $(ldd $(which sshd) | awk '/wrap/{print "ok"}')
then
	echo '=== The Current SSHD is not support wrap ===='
        echo '=== Set iptables plugin script ==============='
        sed -i "s@#PLUGIN_DENY=.*@PLUGIN_DENY=/var/lib/denyhosts/plugins/iptablesAddIp.sh@" /etc/denyhosts.conf
        sed -i "s@#PLUGIN_PURGE=.*@PLUGIN_PURGE=/var/lib/denyhosts/plugins/iptablesRemoveIp.sh@" /etc/denyhosts.conf
	
	#若设置PLUGIN, 需要下载iptablesAddIp.sh  iptablesRemoveIp.sh
fi

# set the secure file
SecuFile=/var/log/secure
test -f $SecuFile ||  SecuFile=/var/log/auth.log
echo "=== Secure File: $SecuFile"
sed -i "s#^SECURE_LOG.*#SECURE_LOG = $SecuFile#" /etc/denyhosts.conf
tail -n20 $SecuFile

echo "=== Start denyhosts ... "
/etc/init.d/denyhosts start
