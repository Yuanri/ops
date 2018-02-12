

### 1、防止 ssh 连接超时断开
    ssh 客户端配置：/etc/ssh_config   ~/.ssh/config

    添加一行记录：ServerAliveInterval 60 
### 2、修改普通 ulimit 

普通用户登录系统报错，提示：

     -bash: ulimit: open files: cannot modify limit: Operation not permitted.

处理方法：

    #vi /etc/ssh/sshd_config  --使用root账号修改UseLoin 为yes

    UseLogin yes

    # service sshd restart     --重启ssh生效



    #重新登录

    $ ulimit –n   --验证设置

    65535
