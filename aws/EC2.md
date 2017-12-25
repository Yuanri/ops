# EC2

### 1、磁盘扩容
http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-expand-volume.html?icmpid=docs_ec2_console

[Linux 磁盘扩容](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/recognize-expanded-volume-linux.html)

1、首先通过AWS 页面修改块设备大小

2、如果系统提示无法正常动态扩容磁盘，则需要先stop instance 然后start instance

3、登录 instance 操作如下：
ext格式的文件系统扩容：
    # 查看磁盘格式：
    # file -s /dev/xvdb
    /dev/xvdb: Linux rev 1.0 ext4 filesystem data, UUID=23a74d25-b4b1-4d0c-a706-39319bd6ce65 (needs journal recovery) (extents) (large files) (huge files)

    # 查看当前系统的块设备大小
    # lsblk 
    NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
    xvda    202:0    0   10G  0 disk 
    └─xvda1 202:1    0   10G  0 part /
    xvdb    202:16   0  400G  0 disk /data

    # 查看当前系统识别的块设备大小，找到需要resize的块设备
    # df -h
    Filesystem      Size  Used Avail Use% Mounted on
    devtmpfs        3.7G   64K  3.7G   1% /dev
    tmpfs           3.7G     0  3.7G   0% /dev/shm
    /dev/xvda1      9.8G  1.6G  8.1G  17% /
    /dev/xvdb       197G   97G   91G  52% /data

    # 如果是 ext格式的文件系统，使用如下命令：
    #resize快设备，重新识别块设备大小
    # resize2fs  /dev/xvdb
    resize2fs 1.42.12 (29-Aug-2014)
    Filesystem at /dev/xvdb is mounted on /data; on-line resizing required
    old_desc_blocks = 13, new_desc_blocks = 25
    The filesystem on /dev/xvdb is now 104857600 (4k) blocks long.

    #如果是XFS 格式文件系统
    $ sudo yum install xfsprogs
    $ sudo xfs_growfs -d /mnt

    # 确认块设备大小是否生效
    # df -h
    Filesystem      Size  Used Avail Use% Mounted on
    devtmpfs        3.7G   64K  3.7G   1% /dev
    tmpfs           3.7G     0  3.7G   0% /dev/shm
    /dev/xvda1      9.8G  1.6G  8.1G  17% /
    /dev/xvdb       394G   97G  280G  26% /data



