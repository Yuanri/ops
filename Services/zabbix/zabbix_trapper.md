# zabbix 捕捉器

由监控点主动上报数据，服务端创建捕捉模板

1、创建自定义模板

Configuration --> Templates  --> Create templat
由监控点主动上报数据，服务端创建捕捉模板

1、创建自定义模板

Configuration --> Templates  --> Create template
![](https://github.com/Yuani/ops/raw/master/Services/zabbix/images/trapper1.png)


弹出下面的界面：
![](https://github.com/Yuani/ops/raw/master/Services/zabbix/images/trapper2.png)

找到刚才添加的模板，点击 Application ----> Create Application,   添加应用，
![](https://github.com/Yuani/ops/raw/master/Services/zabbix/images/trapper3.png)

配置应用名称
![](https://github.com/Yuani/ops/raw/master/Services/zabbix/images/trapper4.png)

添加上报参数变量： 点击 Items -->  Create items
![](https://github.com/Yuani/ops/raw/master/Services/zabbix/images/trapper5.png)

关键是下面连个值得设置
![](https://github.com/Yuani/ops/raw/master/Services/zabbix/images/trapper6.png)
![](https://github.com/Yuani/ops/raw/master/Services/zabbix/images/trapper7.png)

中文版的截图
![](https://github.com/Yuani/ops/raw/master/Services/zabbix/images/trapper8.png)


### 监控上报数据：
    [root@zhu2 ~]# /path/to/zabbix_sender -z 192.168.70.133 -p 10051 -s "localhost IP" -k cs.cpu   -o "values"
    info from server: "Processed 1 Failed 0 Total 1 Seconds spent 0.000474"
    sent: 1; skipped: 0; total: 1
    #参数介绍
    -z - to specify Zabbix server IP address
    -p - to specify Zabbix server port number (10051 by default)
    -s - to specify the host (make sure to use the 'technical' host name here, instead of the 'visible' name)
    -k - to specify the key of the item we just defined
    -o - to specify the actual value to send






