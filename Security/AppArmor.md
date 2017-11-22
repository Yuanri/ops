# AppArmor 
AppArmor是一个实施了基于名称强制存取控制的Linux安全模组,类似于Selinux

    AppArmor 界定了单个程序进入一组文件列表的权 
    Ubuntu 系统默认安装了AppArmor 开机启动

AppArmor operates in the following two types of profile modes:

    1、Enforce – In the enforce mode, system begins enforcing the rules 
                 and report the violation attempts in syslog or auditd (only if auditd is installed)
                 and operation will not be permitted.

    2、Complain – In the complain mode, system doesn’t enforce any rules. 
              It will only log the violation attempts.


#### 常用命令
    查看AppArmor 状态
    $ sudo apparmor_status

    若修改配置，需要 apparmor-utils，若没有安装，执行下面的命令：
    apt-get install apparmor-utils

    添加 complain mode,如 mysqld
    $ sudo aa-complain /usr/sbin/mysqld

    切换为 enforce mode :
    $ sudo aa-enforce /usr/sbin/mysqld
    
    配置文件都是text 文件，默认路径：/etc/apparmor.d/
    
    如/usr/sbin/mysqld  的对应AppArmor 配置文件对应：usr.sbin.mysqld 
    
    停用AppArmor
    service apparmor stop
    
    只清理缓存，不加载profile:
    service apparmor teardown

