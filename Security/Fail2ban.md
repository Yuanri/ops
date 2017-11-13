# Fail2ban

可以用來防護 Linux Server 上的 SSH、vsftp、dovecot...等服務免於遭駭客使用暴力密碼入侵

github 地址:  [Fail2ban](https://github.com/fail2ban/fail2ban)

### 1、安装： CentOS

    解压安装：
    tar xvfj fail2ban-0.11.0.tar.bz2
    cd fail2ban-0.11.0
    python setup.py install

    可执行文件位置：/usr/bin 

    客户端：fail2ban-client -h
    
    复制启动脚本到 init.d：
    cp files/debian-initd /etc/init.d/fail2ban
    
    配置开机启动：
    chkconfig --level 2345 fail2ban on
    
    配置ssh 预防
    默认配置文件：/etc/fail2ban
    cd  /etc/fail2ban
    vim jail.local
    [DEFAULT]
    ignoreip= 127.0.0.1/8 ::1
    bantime=86400
    maxretry=5

    [sshd-iptables]
    enabled=true
    filter=sshd
    action=iptables[name=SSH,port=ssh,protocol=tcp]
           sendmail-whois[name=SSH,dest=you@mail.com,sender=you@mail.com]
    logpath=/var/log/secure
    
    【注意】jail.local  或者 jail.d/*.local 文件会覆盖 jail.conf 里面的参数
    
    
    启动:  /etc/init.d/fail2ban start
    
    日志：  tail -f /var/log/fail2ban.log


### 2、错误解决方案
2.1、关键字： iptables  -w

        编辑 /etc/fail2ban/action.d/iptables-common.conf
        修改：iptables = iptables <lockingopt>
        为  ：iptables = iptables


