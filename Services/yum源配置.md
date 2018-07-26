1、本地yum源配置
这里以centos6.5.iso为例
##### 1.1 如果是DVD

    检查DVD是否挂载：
    ll  /dev/dvd
    
    挂载：
    mkdir  /mnt/cdrom
    mount     /dev/dvd     /mnt/cdrom
    
    
##### 1.2 如果是ISO文件：

    1、创建iso存放目录和挂载目录
    mkdir /mnt/iso 
    mkdir /mnt/cdrom

    2、上传iso镜像文件到iso存放目录/mnt/iso下

    3 挂载iso镜像到挂载目录/mnt/cdrom下
    mount -o loop /mnt/iso/XXXXX.iso  /mnt/cdrom


##### 1.3 查看是否挂载成功 
    df -h

##### 1.4 创建repo文件并放到/etc/yum.repos.d/目录
    cd /etc/yum.repos.d
    vi local.repo
    --内容如下
    [local]
    name=local
    #注：这里的baseurl就是你挂载的目录，在这里是/mnt/cdrom
    baseurl=file:///mnt/cdrom    
    #注：这里的值enabled一定要为1  
    enabled=1                    
    gpgcheck=0
    #注：这个你cd /mnt/cdrom/可以看到这个key，这里仅仅是个例子
    gpgkey=file:///mnt/cdrom/RPM-GPG-KEY-CentOS-6

##### 1.5 测试YUM安装
    yum clean all
    yum install ntp

