


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

    # vsftpd.conf 
    # fix the bug : 500 OOPS: priv_sock_get_cmd 
    seccomp_sandbox=NO

    #working mode : passive 
    listen=YES
    listen_ipv6=NO
    listen_port=65000
    pasv_enable=YES
    pasv_promiscuous=YES
    pasv_max_port=64000
    pasv_min_port=60000
    #pasv_address=xx.xx.xx.xx

    # set anonymous user 
    anonymous_enable=NO
    write_enable=YES
    anon_upload_enable=NO
    anon_mkdir_write_enable=NO
    anon_other_write_enable=NO

    #set Local user
    local_enable=YES
    local_umask=022
    file_open_mode=0664

    #access permission
    pam_service_name=vsftpd
    tcp_wrappers=YES
    chown_uploads=NO
    chmod_enable=NO
    async_abor_enable=YES
    ascii_upload_enable=YES
    ascii_download_enable=YES
    ls_recurse_enable=NO
    local_root=/data2/vsftpd/test


    # set  virtual user 
    nopriv_user=nobody
    guest_enable=YES
    guest_username=nobody
    virtual_use_local_privs=YES
    chroot_local_user=YES
    chroot_list_enable=NO
    chroot_list_file=/usr/local/services/vsftpd-1.0/conf/chroot_list
    userlist_enable=YES
    userlist_deny=YES
    userlist_file=/usr/local/services/vsftpd-1.0/conf/user_list
    user_config_dir=/usr/local/services/vsftpd-1.0/vconf
    allow_writeable_chroot=YES


    # set log
    xferlog_enable=YES
    xferlog_std_format=YES
    xferlog_file=/usr/local/services/vsftpd-1.0/log/xferlog.log
    log_ftp_protocol=YES
    dual_log_enable=YES
    vsftpd_log_file=/usr/local/services/vsftpd-1.0/log/vsftpd.log


    # set welcome message
    dirmessage_enable=YES
    ftpd_banner="Welcome to X-FTP service. The maximum concurrent threads per ip is 100."
    hide_ids=YES

    # connection limit
    max_per_ip=100
    local_max_rate=20000000
    idle_session_timeout=300


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





