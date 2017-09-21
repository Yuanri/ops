MySQL 

### MySQL monitor

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






