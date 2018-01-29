# Mongodb

#### 主从 默认不可读
    配置永久从可读：
    1、从配置：echo 'rs.slaveOk();'  > ~/.mongorc.js
    2、重启从

    命令行可读配置：
    PRIMARY> db.getMongo().setSlaveOk();
