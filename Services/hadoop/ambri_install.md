# Ambri

Ambari 就是为了让 Hadoop 以及相关的大数据软件更容易使用的一个工具

Ambari 自身也是一个分布式架构的软件，主要由两部分组成：Ambari Server 和 Ambari Agent。
简单来说，用户通过 Ambari Server 通知 Ambari Agent 安装对应的软件；
Agent 会定时地发送各个机器每个软件模块的状态给 Ambari Server，
最终这些状态信息会呈现在 Ambari 的 GUI，方便用户了解到集群的各种状态，并进行相应的维护

参考链接  
https://docs.hortonworks.com/HDPDocuments/Ambari-2.1.1.0/bk_Installing_HDP_AMB/content/ch_Getting_Ready.html
   
   
#### 禁用、启用透明大页功能  
    查看命令 CentOS6
    cat /sys/kernel/mm/transparent_hugepage/enabled
   
    方法1：不需要重启系统
    echo never > /sys/kernel/mm/redhat_transparent_hugepage/enabled
    
    
    方法2：设置/etc/grub.conf文件，在系统启动是禁用 【需要重启系统】
    echo transparent_hugepage=never >>/etc/grub.conf
    
    方法3：设置/etc/rc.local文件，添加如下几行：【需要重启系统】
    
    if test -f /sys/kernel/mm/redhat_transparent_hugepage/enabled; then
        echo never > /sys/kernel/mm/redhat_transparent_hugepage/enabled
    fi
 
