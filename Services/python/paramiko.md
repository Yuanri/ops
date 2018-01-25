
# Python paramiko 模块

#### paramiko ssh 执行
    #!/usr/bin/env python
    #-*- coding:utf-8 -*-

    import paramiko

    def ssh2(ip,username,password,cmd,port=22):
        try:
            print('=== Connect to host: ', ip)
            #print('=== cmd: ', cmd))
            ssh=paramiko.SSHClient()
            ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            if len(password) >1:
                ssh.connect(ip,port,username,password,timeout=5)
            else:
                print('use private_key')
                pkey='/root/.ssh/id_rsa'
                key=paramiko.RSAKey.from_private_key_file(pkey)
                ssh.connect(ip, port, username,pkey=key,timeout=5)

            stdin,stdout,stderr= ssh.exec_command(cmd,get_pty=True)

            # sudo with password
            # if username !='root':
            #    stdin.write(password + '\n')
            #    stdin.flush

            for x in stdout.readlines():
                print(x.strip('\n'))
            for x in stderr.readlines():
                print(x.strip('\n'))
            print("=== %s\tok\n" % (ip,))
            ssh.close()
        except:
            print("=== %s\tErrorn\n" % (ip,))

#####  paramiko 上传下载单个文件
    #!/usr/bin/python 
    import paramiko

    t = paramiko.Transport((“主机”,”端口”))
    t.connect(username = “用户名”, password = “口令”)
    sftp = paramiko.SFTPClient.from_transport(t)
    remotepath=’/var/log/system.log’
    localpath=’/tmp/system.log’
    sftp.get(remotepath, localpath)
    #上传
    #sftp.get(localpath，remotepath)
t.close()
