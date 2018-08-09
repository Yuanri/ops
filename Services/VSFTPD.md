


### 安装：

    Redhat CentOS 等：
    yum  install vsftpd -y
    Ubuntu等
    apt-get install vsftpd -y


### 配置文件：
vsftpd默认配置文件在 /etc/vsftpd
假设vsftpd 部署路径为： /usr/local/services/vsftpd-1.0/

    cd /usr/local/services/vsftpd-1.0/
    mkdir conf    #配置文件目录
    mkdir  vconf  #虚拟用户配置文件
    mkdir log     #存放日志
    mkdir bin     #存放脚本

#### 认证配置： /etc/pam.d/vsftpd

    #%PAM-1.0
    #auth    sufficient      /lib64/security/pam_userdb.so     db=/etc/vsftpd/virtusers
    #account sufficient      /lib64/security/pam_userdb.so     db=/etc/vsftpd/virtusers
    auth    sufficient      /lib64/security/pam_userdb.so     db=/usr/local/services/vsftpd-1.0/conf/virtusers
    account sufficient      /lib64/security/pam_userdb.so     db=/usr/local/services/vsftpd-1.0/conf/virtusers

#### /usr/local/services/vsftpd-1.0/conf/vsftpd.conf

    anonymous_enable=NO
    local_enable=YES
    write_enable=YES
    local_umask=022
    anon_upload_enable=NO
    anon_mkdir_write_enable=NO
    dirmessage_enable=YES
    connect_from_port_20=YES
    chown_uploads=NO
    file_open_mode=0664
    chmod_enable=NO

    #log
    xferlog_enable=YES
    xferlog_std_format=YES
    xferlog_file=/usr/local/services/vsftpd-1.0/log/xferlog.log
    syslog_enable=NO
    log_ftp_protocol=YES
    vsftpd_log_file=/usr/local/services/vsftpd-1.0/log/vsftpd.log
    dual_log_enable=YES
    force_local_logins_ssl=YES

    listen=YES
    listen_port=8080
    pasv_enable=YES
    pasv_max_port=64000
    pasv_min_port=60000
    port_enable=NO

    listen_ipv6=NO
    pam_service_name=vsftpd
    #tcp_wrappers=YES

    nopriv_user=nobody
    async_abor_enable=YES
    ascii_upload_enable=YES
    ascii_download_enable=YES
    ftpd_banner="Welcome to service. The maximum concurrent threads per ip is 10."
    chroot_local_user=YES
    chroot_list_enable=YES
    chroot_list_file=/usr/local/services/vsftpd-1.0/conf/chroot_list
    ls_recurse_enable=NO


    userlist_enable=YES
    userlist_file=/usr/local/services/vsftpd-1.0/conf/user_list
    guest_enable=YES
    #guest_username=vsftpd
    guest_username=nobody

    #虚拟用户配置
    virtual_use_local_privs=YES
    user_config_dir=/usr/local/services/vsftpd-1.0/vconf
    local_root=/data2/vsftpd/
    allow_writeable_chroot=YES

    #限速配置
    max_per_ip=10
    local_max_rate=20000000
    idle_session_timeout=300

    #云主机或者域名解析时
    pasv_address=x.x.x.x


#### 生成认证密码库：
新建文件 virtusers ，文件内容格式：一行账号，紧挨着一行密码，如下新建账号user_A、user_B

    # cat virtuser
    user_A
    A_password
    user_B
    B_password
    
 生成密码DB命令：
 
     db_load -T -t hash -f virtuser  virtuser.db
    
#### 虚拟用户默认配置文件    
# cat vconf/vconf.tmp
local_root=/data2/vsftpd/ftpuser/
anonymous_enable=NO
write_enable=YES
local_umask=022
anon_upload_enable=NO
anon_mkdir_write_enable=NO





