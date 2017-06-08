
# ERR 
### ERR-1: fork: Cannot allocate memory
    内存被耗光了,需要reboot 系统


### ERR-2: No space left on device: mod_security: Could not create modsec_auditlog_lock
    Today one of my customers contacted me with a normally simple “directadmin won’t restart my apache” question. I restarted apache via SSH and still nothing. I checked the apache error_log and saw the following error:
    [Thu Sep 18 13:09:02 2008] [error] (28)No space left on device: mod_security: Could not create modsec_auditlog_lock
    Configuration Failed

    Did the normal things like checking the free space on the hard disk, cleaning /tmp etc, and then went on google to search for a solution. Then i found the following post:
    This was because mod_security wasn’t cleaning up its semaphores for some reason. My solution was to add this to the stop function in my init script:

    # ipcs | perl -ane ‘`ipcrm -s $F[1]` if $F[2] == “apache” and $F[1] =~ /\d+/ and $F[1] != 0′  

    This removes any semaphores left by Apache when ever /etc/init.d/httpd stop or /etc/init.d/httpd restart are called.
    After running this command apache was willing to start again. Problem solved!


### ERR-3: kernel: nf_conntrack: table full, dropping packet
[http://blog.sina.com.cn/s/blog_541a3cf10101b3bj.html](http://blog.sina.com.cn/s/blog_541a3cf10101b3bj.html)

    那么先参考http://blog.johntechinfo.com/technology/275这篇文章来优化下测试环境：
    解决办法如其所述，对ip_conntrack的两个参数进行设置即可：

    vi /etc/sysctl.conf
    net.nf_conntrack_max = 655360
    net.netfilter.nf_conntrack_tcp_timeout_established = 1200

    但是http://blog.yorkgu.me/2012/02/09/kernel-nf_conntrack-table-full-dropping-packet/这位仁兄文中说在centos上，需要这样设置

    net.ipv4.netfilter.ip_conntrack_max = 655350
    net.ipv4.netfilter.ip_conntrack_tcp_timeout_established = 1200

    #默认超时时间为5天，作为一个主要提供HTTP服务的服务器来讲，完全可以设置得比较短
    ># sysctl -p /etc/sysctl.conf

https://wiki.khnet.info/index.php/Conntrack_tuning

### ERR-4: configure: error: C compiler cannot create executables
    configure: error: C compiler cannot create executables
    See `config.log' for more details.

    有很多人建议重装GCC，但是确无济于事。
    这个错误产生的原因其实很简单： 由于我们在编译软件之前，进行了export操作，改变了CFLAGS和LIBS的值。

    这个时候只要讲这个值清空就可以了。
    sh   export LIBS=
    sh   export CFLAGS=
