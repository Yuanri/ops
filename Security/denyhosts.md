# Denyhosts

#### 1、基于sshd 支持tcp_wrap 

    检查是否支持：
    ldd  $(which sshd) | grep wrap

安装脚本：[denyhosts_install.sh](https://github.com/Yuani/ops/tree/master/Security/denyhosts_install.sh)

[注]：默认的后台启动脚本 daemon-control-dist 中 DENYHOSTS_LOCK = "/var/run/denyhosts.pid"
#### 2、开启 iptables 功能 
DENY:[iptablesAddIp.sh](https://github.com/Yuani/ops/tree/master/Security/plugin/iptablesAddIp.sh)

PURGE:[iptablesRemoveIp.sh](https://github.com/Yuani/ops/blob/master/Security/plugin/iptablesRemoveIp.sh)

    因sshd 自6.7p1 版本之后，默认不再支持tcp_wrap ,需要重新编译sshd ,此法可行，但是比较麻烦
    这里 denyhosts 通过设置 plugin 功能来实现iptables 防御SSH 暴力破解
    编辑 /etc/denyhosts.conf
    设置 
    IPATBALES    : $(which iptables)
    PLUGIN_DENY  ：需要创建Iptables 规则添加脚本 [iptablesAddIp.sh]
    PLUGIN_PURGE ：默认提供了iptables 规则删除脚本 ( plugin/iptablesRemoveIp.sh ) 可以直接使用
    【注】都配置绝对路径
    
    
#### 3、基本命令
    删除denyed IP
    denyhosts.py   --purge 

#### 4、自定义FAILED_ENTRY_REGEX
    当denyhosts默认正则无法匹配日志是，可以通过配置FAILED_ENTRY_REGEX来找到非法IP
    官方文档说直接修改配置文件/etc/denyhosts.conf ,几经尝试终是失败
    后来直接找 denyhosts 的默认 REGX 文件：lib/python2.6/site-packages/DenyHosts/regex.py
    根据自己的日志格式，添加一条新的 FAILED_ENTRY_REGEX10
    并让FAILED_ENTRY_REGEX_NUM +1 
    

    



