# MySQL 


#### 慢查询kill 
    select concat('kill ', id, ';') from information_schema.processlist where  COMMAND != 'Sleep' and time > 2*60 order by time desc;
 

#### mysql全备份
##### innodb ：
    mysqldump -ubackup --flush-logs --single-transaction --master-data=2   -p  --all-databases  >db_all_backup.sql
    
##### mysiam:
    mysqldump -ubackup --flush-logs --single-transaction --lock-all-tables --master-data=2   -p  --all-databases  >db_all_backup.sql


#### 日志清理：
    删除bin-log:
    #登录mysql 
    > show binary logs;
    #删除日志
    > purge binary logs to 'log-bin.001825'; 
    
    #设置日志过期时间：
    > show variables like '%expire_log%';
    > set global expire_logs_days = 7;
    > flush logs;
    
#### 常用字符集
    ASCII：  美国信息互换标准编码；英语和其他西欧语言；单字节编码，7位表示一个字符，共128字符。
    GBK：    双字节，汉字内码扩展规范；中日韩汉字、英文、数字；双字节编码；共收录了21003个汉字，GB2312的扩展。
    UTF-8：  Unicode标准的可变长度字符编码；Unicode标准（统一码），业界统一标准，包括世界上数十种文字的系统；
    UTF-8：  使用一至三个字节为每个字符编码。
    utf8mb4：存储四个字节，应用场景用于存储emoji表情，因为可以emoji表情四个字节。
    utf8mb4：MySQL版本 > 5.5.3 。
    其他常见字符集：UTF-32，UTF-16，Big5，latin1
    数据库中的字符集包含两层含义
    各种文字和符号的集合，包括各国家文字、标点符号、图形符号、数字等。
    字符的编码方式，即二进制数据与字符的映射规则


#### 让MySQL支持emoji图标存储
从MYSQL5.5开始，可支持4个字节UTF编码 utf8mb4 ，一个字符最多能有4字节，所以能支持更多的字符集。
所以要解决问题，必需把数据库表字符编码全部改成 utf8mb4

    1、备份数据
    
    2、修改您的数据库、表、字段
    # 对每一个数据库:
    ALTER DATABASE 这里数据库名字 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
    # 对每一个表:
    ALTER TABLE 这里是表名字 CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
    # 对每一个字段:
    ALTER TABLE 这里是表名字 CHANGE 字段名字 重复字段名字 VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
    # 上面一句或者使用modify来更改
    ALTER TABLE 这里是表名字 modify 字段名字 VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '';
    utf8mb4完全向后兼容utf8，无乱码或其他数据丢失的形式出现。
    理论上是可以放心修改，如果您不放心修改，您可以拿备份恢复数据，然后让程序员处理这种兼容emoji存储问题，存的时候过滤一遍转成base64，
    然后取的时候转回来？... 还是修改数据库比较方便。

    3、修改MySQL配置文件
    [client]
    default-character-set = utf8mb4

    [mysql]
    default-character-set = utf8mb4

    [mysqld]
    character-set-client-handshake = FALSE
    character-set-server = utf8mb4
    collation-server = utf8mb4_unicode_ci
    
    4、重启mysql

    


#### MySQL monitor

参考链接：https://www.hi-linux.com/posts/27014.html#more

    1、安装mysqld_exporter:
    $ wget https://github.com/prometheus/mysqld_exporter/releases/download/v0.10.0/mysqld_exporter-0.10.0.linux-amd64.tar.gz
    $ tar xzvf mysqld_exporter-0.10.0.linux-amd64.tar.gz
    $ mv mysqld_exporter-0.10.0.linux-amd64 /usr/local/prometheus/mysqld_exporter

    2、创建监控用户：
    mysql> GRANT REPLICATION CLIENT, PROCESS ON *.* TO 'mysqld_exporter'@'localhost' identified by '000000';
    mysql> GRANT SELECT ON performance_schema.* TO 'mysqld_exporter'@'localhost';
    mysql> flush privileges;

    3、mysqld_exporter默认会读取~/.my.cnf文件。这里是创建在mysqld_exporter的安装目录下的
    vim ~/.my.cnf
    [client]
    user=mysqld_exporter
    password=000000

    4、启动：
    nohup ./mysqld_exporter -config.my-cnf  ~/.my.cnf  -web.listen-address 127.0.0.1:9104






