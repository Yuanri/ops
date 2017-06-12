# AWS 故障问题汇总

### 1、AWS MySQL 客户端无法输入中文
a、尝试修改mysql server 和  client 的字符集，重启实例，依旧不生效

b、可能是libedit的文图，可是AWS的yum源上libedit已经是最新的了，版本为libedit-2.11

    # rpm -qa|grep libedit
    libedit-2.11-4.20080712cvs.1.6.amzn1.x86_64
    
    看来只能手动源码更新，如下是具体步骤
    # wget http://thrysoee.dk/editline/libedit-20160903-3.1.tar.gz
    # tar zxvf libedit-20160903-3.1.tar.gz
    # cd libedit-20160903-3.1
    # ./configure
    # make && make install
    
    编译后的libedit.so默认放在了/usr/local/lib/下面，需要做软链接替换旧的libedit版本
    # unlink /usr/lib64/libedit.so.0
    # ln -s /usr/local/lib/libedit.so.0.0.55 /usr/lib64/libedit.so.0

    -------------------------------------
    如果报错：configure: error: libtermcap, libcurses or libncurses are required!
    执行命令：yum install ncurses-devel -y
