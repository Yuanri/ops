#!/usr/bin/bash
#
# name: denyhosts_install.sh
#
# denyhosts install scripts

URL=https://github.com/denyhosts/denyhosts/archive/master.zip


MakeSureSecuFile(){
    SecuFile=/var/log/messages
    test $(cat /etc/issue |awk 'NR==1{print $1}') == 'CentOS' && SecuFile=/var/log/secure
    if test -z $(ldd $(which sshd)|grep libwrap) ;then
        SecuFile=/var/log/messages
        echo 'The Current SSHD is not soupport wrap'
        echo 'Set iptables plugin script '
        sed -i "s@#IPTABLES.*@IPTABLES = $(which iptables)@"  /etc/denyhosts.conf
        sed -i "s@#PLUGIN_DENY=.*@PLUGIN_DENY=/var/lib/denyhosts/plugins/iptablesAddIp.sh@" /etc/denyhosts.conf
        sed -i "s@#PLUGIN_PURGE=.*@PLUGIN_PURGE=/var/lib/denyhosts/plugins/iptablesRemoveIp.sh@" /etc/denyhosts.conf
        test -d plugins  && mv  plugins /var/lib/denyhosts/
    fi

    sed -i "s#^SECURE_LOG.*#SECURE_LOG = $SecuFile#" /etc/denyhosts.conf
}

echo "Begin to download denyhosts to System ...."
curl $URL  -o $PageName  --progress

echo "Install denyhost ..."
if test -f $PageName ;then
        unzip  master.zip 
        cd master
        pip install -r requirements.txt
        python setup.py install
        echo "Install Successed"
        echo "The fist time to exec  denyhosts .... "
        MakeSureSecuFile
        /usr/bin/denyhosts.py
        sleep 5
        echo " download witelist and logrorate config"
       
        echo "Please modify the witeList file: /var/lib/denyhosts/allowed-hosts
        
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
       
        echo "Set daemo progress : ln -s /usr/bin/daemon-control-dist /etc/init.d/denyhosts "
        ln -s /usr/bin/daemon-control-dist /etc/init.d/denyhosts
        ln -s /usr/bin/denyhosts.py  /usr/sbin/denyhosts
        chkconfig --level 2345 denyhosts on
        
        echo 'the  Command to start denyhosts as a daemon process: /etc/init.d/denyhosts start'
else
        echo "ERR: Download file fail ,URL:$URL "
fi
