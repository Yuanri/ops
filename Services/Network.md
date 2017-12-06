# Network

#### 1、【禁用IPV6】
    注释 / etc/hosts 文件里面的 IPV6 配置
    网卡配置文件添加： IPV6INIT=no  

#### 【DNS】
     /etc/resolv.conf

#### 【获取IP地址】
    ip -f inet a |awk '/global/{print $2}'|sort -n | uniq | sed 's#/.*##'
    ip -f inet a |awk '/global/{print $2}'|sort -n | uniq 



#### 2、【多网卡配置】
CentOS /RedHat   网卡配置文件路径 :    /etc/sysconfig/network-scripts

    # cat ifcfg-eth0
    DEVICE="eth0"
    BOOTPROTO="static"
    HWADDR="00:23:8B:E0:51:87"
    NM_CONTROLLED="yes"
    ONBOOT="yes"
    TYPE="Ethernet"
    UUID="4b2a77f9-0fad-411b-b0e1-6e33127770fa"
    IPADDR="119.147.47.194"
    NETMASK="255.255.255.248"
    GATEWAY="119.147.47.193"
    IPADDR1="58.254.170.194"
    NETMASK1="255.255.255.248"
    GATEWAY1="58.254.170.193"
    IPADDR2="183.232.150.66"
    NETMASK2="255.255.255.248"
    GATEWAY="183.232.150.65"
    DNS1="223.5.5.5"
    DNS2="223.6.6.6"

    $ cat /etc/sysconfig/network-scripts/ifcfg-eth1
    DEVICE=eth1
    BOOTPROTO=none
    DHCP_HOSTNAME=host
    HWADDR=44:a8:42:03:f8:f3
    NM_CONTROLLED=yes
    ONBOOT=yes
    TYPE=Ethernet
    UUID="11a8fd5b-73b0-40b8-b304-9297373d471f"
    IPADDR=10.10.85.21
    NETMASK=255.255.0.0
    IPV6INIT=no              #禁用IPV6
    USERCTL=no


#### 3、【双线策略 】
    ip route flush table net5
    ip route add default via 123.138.91.1 dev em1 src 123.138.91.7 table net5
    ip rule add from 123.138.91.7 table net5


#### 4、【修改网卡名字】
    #yum install kernel-firmware*

    1、在grub里增加biosdevname=0的启动参数，形如
    kernel /vmlinuz-2.6.32-131.21.1.el6.i686 ro root=/dev/mapper/vg_test-lv_root rd_LVM_LV=vg_test/lv_root rd_LVM_LV=vg_test/lv_swap rd_NO_LUKS rd_NO_MD rd_NO_DM LANG=en_US.UTF-8 SYSFONT=latar
    cyrheb-sun16 KEYBOARDTYPE=pc KEYTABLE=us crashkernel=auto rhgb quiet biosdevname=0
    2、删除udev的配置文件rm -f /etc/udev/rules.d/70-persistent-net.rules
    3、把网卡配置文件改名
    mv ifcfg-em1 ifcfg-eth0
    4、把网卡配置文件内容修正，把em1的全部改成eth0

    ---linux redhat 6.5
    cd /etc/sysconfig/network-scripts/
    mv ifcfg-em1  ifcfg-eth0
     mv ifcfg-em2  ifcfg-eth1
    vim ifcfg-eth0中的
    DEVICE=eth0
    HWADDR=00:1e:ec:0f:79:f6

    #--删除网卡配置文件
    rm -f /etc/udev/rules.d/70-persistent-net.rules

    #--重启系统
    reboot 


