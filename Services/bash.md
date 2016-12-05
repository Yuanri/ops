# BASH 环境
### 常见运维工作使用命令
### 1、系统 inode 不足
原因：大量小文件分布：

    A、只有一个或者少量目录下存在大量的小文件，这种情况可以使用下面的命令来找出异常目录：
    find / -type d -size +10M

    此命令作用找出大小大于10M 的目录（目录越大，小文件越多）

    B、大量的小文件分布在大量的目录下，使用下面的命令
    cd  / 
    find  */  ! -type f | cut  -d / -f 1 | uniq -c 
    此命令是找出目录下文件总数，可能需要执行多次，知道找出具体的目录，


我这里遇到的是第一种情况， /var/spool/clientmqueue 目录占用很大的空间

如果系统中有用户开启了 cron ，而cron中执行的程序有输出内容，输出内容会已邮件方式发送给cron 用户
而sendmail 没有开启，所以产生了这些文件

解决办法：

    在cron 自动执行语句后面加上 /dev/null   2>&1

    清理目录： /var/spool/clientmqueue
    ls  | xargs   rm  -f 
