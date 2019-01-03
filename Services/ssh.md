

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
    
### 3、经过以上修改，在有些系统中，用一般用户再登陆，仍然没有修改过来，那么需要检查是否有如下文件，如果没有，则要添加如下内容：

    # vim /etc/pam.d/sshd
    [Add the line]
    session required /lib/security/pam_limits.so
    # service sshd restart

### 4、如果仍然不行，那么需要修改如下文件：

    # vim /etc/ssh/sshd_config
    [May need to modify or add the line]
    UsePrivilegeSeparation no
