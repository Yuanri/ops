# zabbix 自动发现监控脚本
需求：监控目录夹，执行里面的监控脚本，
解决方案：使用zabbix 的自动发现功能，自动创建监控脚本项目，定期更新，并执行脚本

### 1、配置 zabbix Agent :
    # cat ../etc/zabbix_agentd.conf | egrep -v '^#|^$'
    Include=/data/softwares/zabbix-agentd-2.2/script/script.conf

    # cat script.conf
    UnsafeUserParameters=1

    # 
    UserParameter=process.discovery,/data/softwares/zabbix-agentd/script/proc_discovery.py
    UserParameter=process.status[*],/data/softwares/zabbix-agentd/script/proc_check.sh $1

### 2、脚本内容：
    # cat proc_discovery.py 
    #!/usr/bin/env python
    import os
    import json
    procPath='/data/softwares/zabbix-agentd/script/testmonitor'
    procName=[]
    for proc in os.listdir(procPath):
        procName+=[{'{#PROC_NAME}':proc}]
    print json.dumps({'data':procName},sort_keys=True,indent=4,separators=(',',':'))

    # cat proc_check.sh 
    #!/bin/bash
    cd $(dirname $0)

    procPath=./testmonitor
    reInfo=/tmp/proc_check.tmp
    cd $procPath

    test -f $1 || exit
    sh $1  >$reInfo  2>$reInfo.$$
    errInfo=$(wc -c $reInfo.$$ |awk '{print $1}')

    if test $errInfo -eq 0 
    then
            grep -c 'ok' $reInfo 
    else 
             echo 10
    fi

    rm -f $reInfo  $reInfo.$$


### 3、重启zabbix_agent
### 4、配置zabbix Server 端
    1、创建模板：Template Process Check
    configuration --> Templates --> Create template

    2、创建自动发现规则：Create discovery rule
    主要配置
         Name  Type  Key Filter
    记录下 
        Key:   process.discovery
        Filter: {#PROC_NAME}
    
![](https://github.com/Yuani/ops/raw/master/Services/zabbix/images/2.png)

    3、创建ITEM : Create item prototype
    主要是key 中的变量，需要与 前面的key 保持一致
![](https://github.com/Yuani/ops/raw/master/Services/zabbix/images/3.png)

    4、配置触发器：Create trigger prototype
    Add -->  select prototype  -->  选择 前面创建好的 item prototype
![](https://github.com/Yuani/ops/raw/master/Services/zabbix/images/4.png)

    
### 5、测试：
    ./bin/zabbix_get  -s 10.0.0.41 -k process.discovery
    看到如下的结果，表示配置都OK了，
    
![](https://github.com/Yuani/ops/raw/master/Services/zabbix/images/1.png)


