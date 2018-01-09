# Redis-3.x

## redis-3.2 安装

    源码编译安装：
    
    wget http://download.redis.io/releases/redis-3.2.0.tar.gz
    tar -xvf redis-3.2.0.tar.gz
    cd  redis-3.2.0
    make
    #make MALLOC=libc
    make PREFIX=/data/softwares/redis-3.2  install

## Redis-3.x  Sentinel 哨兵模式配置:

### sentinel.conf:

    #以守护进程的方式运行： 默认注释
    daemonize yes

    #设置监听IP、port
    bind 192.168.100.163
    port 26379

    #配置日志文件
    logfile "/data/redis/log/sentinel_26379.log"

    #配置文件conf/sentinel.conf的路径
    dir "/data/softwares/redis-3.2/"

    #配置监控master redis 
    #sentinel monitor <master_redis_name>  <ip> <port>  <>
    sentinel monitor mymaster 192.168.100.166 6379 2

    #如果设置了验证密码，添加如下配置：
    sentinel auth-pass mymaster tclonline


    #下面是可选项：
     #sentinel down-after-milliseconds <master-name> <milliseconds>
     # Default is 30 seconds.
    sentinel down-after-milliseconds mymaster 30000

    #当主故障时，允许从redis的个数，reconfig from master
    sentinel parallel-syncs mymaster 1


    # sentinel failover-timeout <master-name> <milliseconds>
    # Default is 3 minutes.
    sentinel failover-timeout mymaster 180000
    
### sentinel 命令
    1、添加redis集群监控
    sentinel moniotr <name> <ip> <port> <quorum>

    2、刷新监控数据
    sentinel  reset  <mastername>

    3、删除master
    sentinel remove <mastername>

    4、修改其他属性
    setinel set <mastername> [<option> <value> …]
             修改监视的master的一些属性
             down-after-milliseconds   过了这个时间考虑master go down
             failover-timeout                   刷新故障转移状态的最大时间
             parallel-syncs            slave同时reconfigure的个数
             notification-script        设置通知脚本
             client-reconfig-script      设置通知脚本
             auth-pass               执行auth的密码
             quorum                 修改master的quorum

#### 注意：动态调整sentinel信息时，是需要对所有关联的 sentinel 和  redis同时操作

    1、刷新监控数据： sentinel  reset  <mastername>
    2、断开主从关系： slaveof no  one
    以上命令执行间隔小于3s

## redis 迁移
[https://github.com/delano/redis-dump](https://github.com/delano/redis-dump)



## redis 主从命令
    1、新redis 加入现有集群：
    slaveof redis_ip   redis_port
    
    2、查看同步信息：
    info replication
    
    3、断开主从关系：
    slaveof no  one
    
    4、关闭只读：
    CONFIG SET slave-read-only no 
    
    5、开启只读：
    CONFIG SET slave-read-only yes
