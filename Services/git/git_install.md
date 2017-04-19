### GIT 源码安装

    下载最新版本：
    http://codemonkey.org.uk/projects/git-snapshots/git/git-latest.tar.xz

    xz -d  git-latest.tar.xz
    tar -xvf git-latest.tar.xz

    当前最新版本：git-2017-04-19
    cd git-2017-04-19
    ./configure --prefix=/data/softwares/git2.12
    make
    make install



### ERR 1: "fatal: Unable to find remote helper for 'https'"

    原因：安装不完整
    解决：yum install curl-devel
    重新编译安装git
    
    
### ERR2 :"git checkout --detach not supported"

    原因：git 版本太低
    解决：升级git到最新版
