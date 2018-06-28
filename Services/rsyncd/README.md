### 创建密码文件
    echo  password  > rsyncd.pass
    chmod 400   rsyncd.pass

### 同步命令: 
    rsync -vzrtopg –progress  --port 8081 --password-file=rsyncd.pass   /path/to/your_files_dir/   user_name@rsyncd-server-address::user_name

    Points for attention:
    1：vzrtopg, --progress are parameters of rsync. Please see rsync –help for reference.
    2：/path/to/your_files_dir/  refers to files need to be uploaded.
    3：--port 8081 is the port of rsyncd service.
    4：--password-file=/etc/rsyncd.pass refers to password authentication.


### 只查看文件列表
    rsync --password-file=rsyncd.pass  --list-only  --port=8081   user_name@rsyncd-server-address::user_name

