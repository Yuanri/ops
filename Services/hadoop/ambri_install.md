# Ambri

官网：https://cwiki.apache.org/confluence/display/AMBARI/Ambari+User+Guides

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
 
### 1 使用Ambari 部署 hadoop cluster

搭建本地repos 资源：参考链接：

      http://docs.hortonworks.com/HDPDocuments/Ambari-2.1.2.0/bk_Installing_HDP_AMB/content/_hdp_stack_repositories.html

这里以在centos6.5 上通过Ambari 部署 HDP-2.3.2.0 为例，下载资源：

      http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.1.1/ambari-2.1.1-centos6.tar.gz

      http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.3.2.0/HDP-2.3.2.0-centos6-rpm.tar.gz

      http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.20/repos/centos6/HDP-UTILS-1.1.0.20-centos6.tar.gz


##### 1.1 搭建本地 repos 
准备：web 代理服务器  ：Apache  /  Nginx等 此处省去
配置文件：

      mkdir /data/web_root/hadoop/
      cd /data/web_root/hadoop/
      tar -zxvf ambari-2.1.1-centos6.tar.gz 
      tar -zxvf HDP-2.3.2.0-centos6-rpm.tar.gz
      tar -zxvf HDP-UTILS-1.1.0.20-centos6.tar.gz

添加repo 配置文件：

      [ambri]
      name=local ambri resource Centos6 - $basearch
      baseurl=http://10.87.12.38/ambari-2.1.1/centos6/
      enabled=1
      gpgcheck=0

      [HDP]
      name=local HDF resource Centos6 - $basearch
      baseurl=http://10.87.12.38/HDP/centos6/2.x/updates/2.3.0.0
      enabled=1
      gpgcheck=0

      [HDP-UTIS]
      name=local HDF-UTIS resource Centos6 - $basearch
      baseurl=http://10.87.12.38/HDP-UTILS-1.1.0.20/repos/centos6/
      enabled=1
      gpgcheck=0
      
      
注意事项：
    
Generate the repository metadata.

For Ambari:

    createrepo <web.server.directory>/ambari/<OS>/Updates-ambari-2.1.2

For HDP Stack Repositories:

    createrepo <web.server.directory>/hdp/<OS>/HDP-<latest.version>

    createrepo <web.server.directory>/hdp/<OS>/HDP-UTILS-<version>

#### 1.2 安装ambari-server 
    
        yum install ambari-server

        启动之前，配置一些默认参数
        ambari-server setup

        启动：ambari-server start
        停止：ambari-server stop

        默认web 地址：http://localhost:8080

        默认账号密码： admin / amdin 


#### 源码安装 ambari-server 2.5.0 注意事项

        
        如果遇到报错：/usr/sbin/ambari-server: line 33: buildNumber: unbound variable
        打开ambari-server脚本，把${buildNumber}这行换成 HASH="${VERSION}"
        
        OOM 内存不足时：
        export MAVEN_OPTS='-Xmx1024m -XX:MaxPermSize=516m'
   
   
####  Ambari Cannot register host with not supported os type

    1、ambari 支持的版本映射关系
    打开文件 /usr/lib/python2.6/site-packages/ambari_commons/resources/os_family.json
    找到aliases 关键字
    "aliases": {
      "amazon2015": "amazon6",
      "amazon2016": "amazon6",
      "amazon2017": "amazon6",
      "suse11sp3": "suse11"
    }
    注：这里需要手动需改所有节点的os_family.json

    2、修改 ambari-server 的集群版本信息
    vim   /etc/ambari-server/conf/ambari.properties
    server.os_family=redhat6
    server.os_type=redhat6


