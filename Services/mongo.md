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
    
    
     
    
    
