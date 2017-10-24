# Mongodb

### 1、修改管理员密码：

    1.关闭mongo进程
    kill -2 pid （在没有管理员账号的情况下用此命令强制关闭）
    
    2. 非auth验证方式启动mongo
    mongod --dbpath /usr/local/MongoDB/data/ --logpath /usr/local/mongodb/logs/mongod.log -logappend --fork
    
    或者修改配置文件：注释 auth=true
    
    3.创建新的管理员帐号
    use admin
    db.createUser({user:"xxxx",pwd:"xxxxxxxxxxxxxxxxx",roles:[{"role":"userAdminAnyDatabase","db":"admin"}]})  
    
    
    查看当前所有账户
    db.system.users.find()
    
    删除所有用户
    db.system.users.remove({})
    

    4.关闭mongo
    use admin
    db.shutdownServer()  该命令要在root管理员权限下执行
    
    5.以auth方式启动mongo
    mongod --auth --dbpath /usr/local/mongodb/data/ --logpath /usr/local/mongodb/logs/mongod.log -logappend --fork
    
    
## 2、新建DB： newdb
    登录mongo
    > use newdb
    > db.createUser({user:"xxxx",pwd:"xxxxxxxxxxxxxxxxx",roles:[{"role":"dbOwner","db":"newdb"}]}) 
    > show dbs
    
    
     
## 3、Mongodb Replication Set 配置

    1、下载mongodb 可执行文件
    curl -O https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-3.4.9.tgz

    2、解压：
    tar -zxvf mongodb-linux-x86_64-3.4.9.tgz
    ln -s  mongodb-linux-x86_64-3.4.9   mongodb
    cd mongodb
    mkdir data logs 

    3、编辑mongod 的配置文件，如下：
    $ cat mongod.conf 
    processManagement:
       fork: true
       pidFilePath: /data/softwares/mongodb/data/db0.pid
    net:
       bindIp: 127.0.0.1,10.86.0.100
       port: 27017
    storage:
       dbPath: /data/softwares/mongodb/data
    systemLog:
       destination: file
       path: "/data/softwares/mongodb/logs/mongod.log"
       logAppend: true
       logRotate: reopen
    storage:
       journal:
          enabled: true

    setParameter:
       enableLocalhostAuthBypass: false

    replication:
      replSetName: rs0

    4、启动mongodb
    ./bin/mongod  -f  mongod.conf 

    5、创建管理员账号：
    ./bin/mongo

    use admin
    db.createUser({user: "mongo-admin", pwd: "password", roles:[{role: "root", db: "admin"}]})


    6、开启安全认证：
    #创建认证keyfile:只要保证集群keyfile 相同即可
    openssl rand -base64 756 > mongo-keyfile       #推荐使用此法
    或者：
    echo -e 'my sercet key file'  >  mongo-keyfile

    #修改配置文件，添加如下三行
    security:
       authorization: enabled
       keyFile: /data/softwares/mongodb/mongo-keyfile

     7、重启mongodb
     #停止mongod
     直接kill 
     或者登陆mongo shell 执行命令：
     use admin 
     db.shutdownServer()

     #启动mongod
     ./bin/mongod  -f  mongod.conf 

     8、配置replication set
     #初始化set:
     rs.initiate()

     #添加节点
     rs.add("mongo-repl-ip2:port")
     rs.add("mongo-repl-ip3:port")

     #检查配置
     rs.conf()

     #检查状态：
     rs.status()

     9、启动并配置刚才添加的mongo-repl-ip2   mongo-repl-ip3
     复制mongod.conf 到 mongo-repl-ip2   mongo-repl-ip3
     启动mongod
     登陆mongo shell :执行如下命令：
     rs.slaveOk()

     测试数据同步，因为新增没有设置用户，但是 replication 会同步primary 的数据
     直接验证admin,返回1 表示验证成功，数据同步正常
     use admin
     db.auth( "mongo-admin", "password")
 
 
 
 
 
