# NFS
共享文件存储系统

####  1、NFS工作原理
    首先nfs服务端要先启用rpc服务，现在Centos 6系列以后，服务器为rpcbind服务。
    因为nfs是开启一些随机的端口，所以nfs开启的这些端口会在rpc服务里面进行注册。
    然后客户端通过挂载将nfs共享的目录挂载到本地的一个存在的空目录上面。
    然后当出现操作的时候，客户端会将请求发送给本地的VFS虚拟文件系统，也就是nfs网络文件系统，通过nfs内核将请求发送给服务端的rpc端口也就是111端口，
    然后rpc会将服务器nfs对应的端口返回给客户端，
    然后客户端会再次与nfs服务器的指定端口进行交互。
    将客户端一系列的open()、read()、write()函数调用传递给服务器，让服务端在本地执行。



#### 2、下面是一些NFS共享的常用参数：
    ro                      只读访问  
    rw                      读写访问  
    sync                    所有数据在请求时写入共享  
    async                   NFS在写入数据前可以相应请求  
    secure                  NFS通过1024以下的安全TCP/IP端口发送  
    insecure                NFS通过1024以上的端口发送  
    wdelay                  如果多个用户要写入NFS目录，则归组写入（默认）  
    no_wdelay               如果多个用户要写入NFS目录，则立即写入，当使用async时，无需此设置。  
    hide                    在NFS共享目录中不共享其子目录  
    no_hide                 共享NFS目录的子目录  
    subtree_check           如果共享/usr/bin之类的子目录时，强制NFS检查父目录的权限（默认）  
    no_subtree_check        和上面相对，不检查父目录权限  
    all_squash              共享文件的UID和GID映射匿名用户anonymous，适合公用目录。  
    no_all_squash           保留共享文件的UID和GID（默认）  
    root_squash             root用户的所有请求映射成如anonymous用户一样的权限（默认）  
    no_root_squash          root用户具有根目录的完全管理访问权限  
    anonuid=xxx             指定NFS服务器/etc/passwd文件中匿名用户的UID  
    anongid=xxx             指定NFS服务器/etc/passwd文件中匿名用户的GID 
 

#### 3、NFS服务器的搭建
    第一步：yum安装软件包
    # yum install rpcbind nfs-utils #前者为rpc服务，后者为nfs服务

    第二步：启动相关服务
    # /etc/init.d/rpcbind start #优先启动rpc服务
    # /etc/init.d/nfs restart   #后启动nfs服务

    第三步：配置相关文件  
    # cat  /etc/exports   #这就是nfs的配置文件，只能对ip进行限制，格式为要挂载目录  IP(参数设置)
    /share_data 192.168.1.0/24(rw,sync)   #，最前面为要挂载的目录,如果允许所有，主机名可以用*代替，并且IP()，中间不能有空格
    # /etc/init.d/nfs reload   #修改nfs配置，不要重启服务，只需要重新加载便可
    #cat /var/lib/nfs/etab #可以通过查看这个配置文件查看详细的设置参数
    # chown nfsnobody:nfsnobody  /share_data   #因为上面配置文件的设置，如果这里不对此共享目录授权，客户端将没有写权限

    第四步：客户端挂载测试
    # showmount -e 192.168.1.108    #showmount命令为查看，这就将nfs服务端共享的目录以及时权限设置查看出来了             
    Export list for 192.168.1.108:
    /share_data 192.168.1.0/24
    # mount -t nfs 192.168.1.108:/share_data /share_data  #这是nfs的挂载命令，最后那个目录为我们客户端本地的目录

#### 4、常用命令
    第一个命令：rpcinfo，rpcinfo实用工具显示那些使用portmap注册的程序的信息，并向程序进行RPC调用，检查它们是否正常运行。
    # rpcinfo -p 192.168.1.108  #格式为rpcinfo -p IP或者localhost

    第二个命令：showmount -e IP地址
    showmount -a  #在服务端上面操作可以查看有哪些客户端挂载信息

    第三个命令：exportfs命令
    如果修改了/etc/exports文件后不需要重新激活nfs，只要重新扫描一次/etc/exports文件，并且重新将设定加载即可：
    # exportfs [-aruv]
    参数说明如下。
    1）-a：全部挂载（或卸载）/etc/exports文件内的设定。
    2）-r：重新挂载/etc/exports中的设置，此外同步更新/etc/exports及/var/lib/nfs/etab中的内容。
    3）-u：卸载某一目录。
    4）-v：在export时将共享的目录显示在屏幕上

    第四个命令：nfsstat 查看NFS的运行状态，对于调整NFS的运行有很大帮助。
    # man netstat  #只写出主要的信息
    选项
           -s，--server
                  仅打印服务器端统计信息。默认值是同时打印服务器和客户端统计信息。

           -c，--client
                  仅打印客户端统计信息。

           -n，-nfs
                  仅打印NFS统计信息。默认为打印NFS和RPC信息。

           -2   仅打印NFS v2统计信息。默认值是仅打印有关NFS版本的信息具有非零计数。

           -3   只打印NFS v3统计信息。默认值是仅打印有关NFS版本的信息具有非零计数。

           -4    仅打印NFS v4统计信息。默认值是仅打印有关NFS版本的信息具有非零计数。
           -m，--mounts
                  打印有关每个挂接的NFS文件系统的信息。如果使用此选项，将忽略所有其他选项。
           -r，-rpc
                  仅打印RPC统计信息。
            - 设施
                  显示指定设施的统计信息，其必须为以下之一：
                  nfs NFS协议信息，由RPC调用拆分。
                  rpc常规RPC信息。
                  net网络层统计信息，例如接收到的数据包数量，TCP连接数量等。
                  fh服器文件句柄缓存的使用信息，包括查找的总数和
                         点击和未命中的数量。
                  rc服务器的请求回复缓存中的用法信息，包括查找的总数和
                        点击和未命中的数量。
                  all显示所有上述设施。
           -v，-verbose 这相当于-o all。
           -l，--list  以列表形式打印信息。

           -S，--since文件
                  而不是打印当前统计信息，nfsstat从文件导入统计信息并显示差异
                  在这些和当前的统计之间。有效的输入文件可以是/ proc / net / rpc / nfs的形式
                  （原始客户端统计信息），/ proc / net / rpc / nfsd（原始服务器统计信息）或来自nfsstat本身的保存输出
                  和/或服务器状态）。保存的nfsstat输出文件中缺少的任何统计信息将被视为零。

           -Z [interval]，--sleep = [interval]
                  nfsstat不打印当前统计信息并立即退出，而是拍摄当前的快照
                  统计和暂停，直到它收到SIGINT（通常来自Ctrl-C），此时它需要另一个
                  快照并显示两者之间的差异。如果指定interval，nfsstat将打印
                  自上一个报告以来发出的NFS调用数。每个间隔将重复打印统计数据秒。
    # nfsstat -l  -4   #示例
    
    第五个命令： nfsiostat  
    Sysstat家族包括一个名叫nfsiostat的实用程序，它和iostat有诸多类似之处，它允许你监控NFS文件系统上的读写情况，其用法也和iostat类似，
    最基本的命令用法是跟上几个参数和两个数字，这两个数字分别表示：
    (1)nfsiostat输出的间隔时间，
    (2)运行nfsiostat的次数，
    如果第二个数字留空，nfsiostat会一直执行下去，直到你按下^c停止它。

    下面是参数：
            -a或--attr
                   显示与属性高速缓存相关的统计信息

            -d或-dir
                   显示与目录操作相关的统计信息

            -h或--help
                   显示帮助消息和退出

            -l LIST或--list = LIST
                   仅打印第一个LIST装载点的统计信息

            -p或--page
                   显示与页面缓存相关的统计信息

            -s或--sort
                   按ops /秒排序NFS装载点

            -version 
                   显示程序的版本号并退出

    # nfsiostat  -a  1 10    #用法实例，-a显示所有，1秒一次，执行10次
