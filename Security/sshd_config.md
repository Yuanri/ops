#sshd_config

## sshd_config 配置参数说明
###只要在ssh的配置文件：sshd_config中添加如下一行即可
    Allowusers username@192.168.1.100
    上述只允许IP地址是192.168.1.100的机器以username用户登录。


###AcceptEnv

     只支持SSHv2协议
     指定客户端发送的哪些环境变量将会被传递到会话环境中。具体的细节可以参考 ssh_config（5） 中的 SendEnv 配置指令。
     该关健字的值是空格分隔的变量名列表（其中可以使用’*'和’?'作为通配符），也可以使用多个AcceptEnv达到同样的目的。
     需要注意的是，有些环境变量可能会被用于绕过禁止用户使用的环境变量。
     由于这个原因，该指令应当小心使用默认值：是不传递任何环境变量
 
###AddressFamily 

    指定sshd（8）应当使用哪种地址族，取值范围：”any”（默认）、”inet”（仅IPv4）、”inet6″（仅IPv6）
 
###AllowGroups 
    这个指令后面跟着一串用空格分隔的组名列表（其中可以使用”*”和”?”通配符），默认允许所有组登录。
    如果使用了这个指令，那么将仅允许这些组中的成员登录，而拒绝其它所有组。
    这里的”组”是指”主组”（primary group），也就是/etc/passwd文件中指定的组。
    这里只允许使用组的名字而不允许使用GID。
    相关的 allow/deny 指令按照下列顺序处理：DenyUsers --> AllowUsers --> DenyGroups-->AllowGroups
 
###AllowTcpForwarding
    是否允许TCP转发，默认值为”yes”。
    禁止TCP转发并不能增强安全性，除非禁止了用户对shell的访问，因为用户可以安装他们自己的转发器
 
###AllowUsers 
    这个指令后面跟着一串用空格分隔的用户名列表（其中可以使用”*”和”?”通配符）。默认允许所有用户登录。
    如果使用了这个指令，那么将仅允许这些用户登录，而拒绝其它所有用户。
    如果指定了 USER@HOST 模式的用户，那么 USER 和 HOST 将同时被检查。
    这里只允许使用用户的名字而不允许使用UID。相关的 allow/deny 指令按照下列顺序处理：
    DenyUsers -->AllowUsers-->DenyGroups --> AllowGroups
 
###AuthorizedKeysFile
    存放该用户可以用来登录的 RSA/DSA 公钥。
    该指令中可以使用下列根据连接时的实际情况进行展开的符号：%% 表示’%'、%h 表示用户的主目录、%u 表示该用户的用户名。
    经过扩展之后的值必须要么是绝对路径，要么是相对于用户主目录的相对路径。默认值是”.ssh/authorized_keys”
 
###Banner
     只支持SSHv2协议
     将这个指令指定的文件中的内容在用户进行认证前显示给远程用户。
     默认什么内容也不显示。”none”表示禁用这个特性
###ChallengeResponseAuthentication 
     是否允许质疑-应答（challenge-response）认证。默认值是”yes”。所有login.conf（5） 中允许的认证方式都被支持
 
###Ciphers
    只支持SSHv2协议
    指定SSH-2允许使用的加密算法。多个算法之间使用逗号分隔。可以使用的算法如下：
    “aes128-cbc”， “aes192-cbc”， “aes256-cbc”， “aes128-ctr”， “aes192-ctr”， “aes256-ctr”，
    “3des-cbc”， “arcfour128″， “arcfour256″， “arcfour”， “blowfish-cbc”， “cast128-cbc”
    默认值是可以使用上述所有算法
 
###ClientAliveCountMax
    只支持SSHv2协议
    Sshd（8）在未收到任何客户端回应前最多允许发送多少个”alive”消息。默认值是 3 。
    到达这个上限后，sshd（8） 将强制断开连接、关闭会话。
    需要注意的是，”alive”消息与 TCPKeepAlive 有很大差异。
    “alive”消息是通过加密连接发送的，因此不会被欺骗；而 TCPKeepAlive 却是可以被欺骗的。
    如果ClientAliveInterval被设为15 并且将 ClientAliveCountMax 保持为默认值，那么无应答的客户端大约会在45秒后被强制断开
 
###ClientAliveInterval
     只支持SSHv2协议，设置一个以秒记的时长，
     如果超过这么长时间没有收到客户端的任何数据，sshd（8） 将通过安全通道向客户端发送一个”alive”消息，并等候应答。
     默认值 0 表示不发送”alive”消息
 
###Compression
    是否对通信数据进行加密，还是延迟到认证成功之后再对通信数据加密。可用值：”yes”， “delayed”（默认）， “no”
 
###DenyGroups
    这个指令后面跟着一串用空格分隔的组名列表（其中可以使用”*”和”?”通配符）。默认允许所有组登录。
    如果使用了这个指令，那么这些组中的成员将被拒绝登录。
    这里的”组”是指”主组”（primary group），也就是/etc/passwd文件中指定的组。
    这里只允许使用组的名字而不允许使用GID。
    相关的 allow/deny 指令按照下列顺序处理：DenyUsers -> AllowUsers -> DenyGroups -> AllowGroups
 
###DenyUsers
    这个指令后面跟着一串用空格分隔的用户名列表（其中可以使用”*”和”?”通配符）。默认允许所有用户登录。
    如果使用了这个指令，那么这些用户将被拒绝登录。
    如果指定了 USER@HOST 模式的用户，那么 USER 和 HOST 将同时被检查。
    这里只允许使用用户的名字而不允许使用UID。
    相关的 allow/deny 指令按照下列顺序处理： DenyUsers -> AllowUsers -> DenyGroups -> AllowGroups
 
###ForceCommand 
    强制执行这里指定的命令而忽略客户端提供的任何命令。这个命令将使用用户的登录shell执行（shell -c）。
    这可以应用于 shell 、命令、子系统的完成，通常用于 Match 块中。
    这个命令最初是在客户端通过 SSH_ORIGINAL_COMMAND 环境变量来支持的
 
###GatewayPorts
      是否允许远程主机连接本地的转发端口。默认值是”no”。
      sshd（8） 默认将远程端口转发绑定到loopback地址。这样将阻止其它远程主机连接到转发端口。
      GatewayPorts 指令可以让 sshd 将远程端口转发绑定到非loopback地址，这样就可以允许远程主机连接了。
      “no”表示仅允许本地连接，”yes”表示强制将远程端口转发绑定到统配地址（wildcard address），
      “clientspecified”表示允许客户端选择将远程端口转发绑定到哪个地址
 
###GSSAPIAuthentication
    只支持SSHv2协议
    是否允许使用基于 GSSAPI 的用户认证。默认值为”no”
 
###GSSAPICleanupCredentials
    只支持SSHv2协议
    是否在用户退出登录后自动销毁用户凭证缓存。默认值是”yes”
 
###HostbasedAuthentication
    只支持SSHv2协议
    这个指令与 RhostsRSAAuthentication 类似，推荐使用默认值”no”不禁止这种不安全的认证方式
 
###HostbasedUsesNameFromPacketOnly
    在开启 HostbasedAuthentication 的情况下，
    指定服务器在使用 ~/.shosts ~/.rhosts /etc/hosts.equiv 进行远程主机名匹配时，是否进行反向域名查询。
    “yes”表示 sshd（8） 信任客户端提供的主机名而不进行反向查询。默认值是”no”
 
###HostKey
    主机私钥文件的位置。如果权限不对，sshd（8） 可能会拒绝启动。
    SSHv1默认是： /etc/ssh/ssh_host_key 。
    SSHv2默认是：/etc/ssh/ssh_host_rsa_key 和 /etc/ssh/ssh_host_dsa_key 。
    一台主机可以拥有多个不同的私钥。”rsa1″仅用于SSH-1，”dsa”和”rsa”仅用于SSH-2
 
###IgnoreRhosts
     是否在 RhostsRSAAuthentication 或 HostbasedAuthentication 过程中忽略 .rhosts 和 .shosts 文件。
     不过 /etc/hosts.equiv 和 /etc/shosts.equiv 仍将被使用。推荐设为默认值”yes”
 
###IgnoreUserKnownHosts
     是否在 RhostsRSAAuthentication 或 HostbasedAuthentication 过程中忽略用户的 ~/.ssh/known_hosts 文件。
     默认值是”no”。为了提高安全性，可以设为”yes”
 
###KerberosAuthentication
     是否要求用户为 PasswordAuthentication 提供的密码必须通过 Kerberos KDC 认证，也就是是否使用Kerberos认证。
     要使用Kerberos认证，服务器需要一个可以校验 KDC identity 的 Kerberos servtab 。默认值是”no”
 
###KerberosGetAFSToken
     如果使用了 AFS 并且该用户有一个 Kerberos 5 TGT，那么开启该指令后，将会在访问用户的家目录前尝试获取一个 AFS token 。
     默认为”no”
 
###KerberosOrLocalPasswd
     如果 Kerberos 密码认证失败，那么该密码还将要通过其它的认证机制（比如 /etc/passwd）。
     默认值为”yes”
 
###KerberosTicketCleanup
     是否在用户退出登录后自动销毁用户的 ticket 。
     默认值是”yes”
 
###KeyRegenerationInterval
    只支持SSHv1协议
    在SSH-1协议下，短命的服务器密钥将以此指令设置的时间为周期（秒），不断重新生成。
    这个机制可以尽量减小密钥丢失或者黑客攻击造成的损失。
    设为 0 表示永不重新生成，默认为 3600（秒）

