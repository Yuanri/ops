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

    #配置文件sentinel.conf的路径
    dir "/data/softwares/redis-3.2/conf"

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

## [redis 迁移 : https://github.com/delano/redis-dump](https://github.com/delano/redis-dump)
