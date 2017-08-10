## 1 PHP 安装：

#### 方法一：yum install php-fpm

#### 方法二：源码编译安装：

    1、安装依赖包：
    yum install pcre pcre-devel  libcurl libcurl-devel  libjpeg-turbo libjpeg-turbo-devel   libpng libpng-devel  freetype-devel
    mcrypt libmcrypt libmcrypt-devel php-mcrypt   mhash mhash-devel  libxml2-devel

    2、下载：
    wget  http://am1.php.net/distributions/php-5.6.31.tar.xz

    3、解压：
    unxz  php-5.6.31.tar.xz
    tar -xvf php-5.6.31.tar

    4、编译安装：
    cd php-5.6.31
    ./configure --prefix=/data/softwares/php-5.5.36  --with-config-file-path=/data/softwares/php-5.5.36/etc \
    --with-mysql  --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib \
    --enable-xml --disable-rpath   --enable-bcmath --enable-shmop \
    --enable-sysvsem --enable-inline-optimization --with-curl  \
    --enable-mbregex  --enable-fpm --enable-mbstring   --with-gd \
    --enable-gd-native-ttf --with-openssl  --enable-pcntl --enable-sockets  \
    --with-xmlrpc --enable-zip --enable-soap  --enable-opcache=no    \
    --with-mysqli  --with-gettext

     make
     make install 
     
    5、创建软连接：
     ln -s  /data/softwares/php-5.5.36   /data/softwares/php
    
    6、复制配置文件：
     cp php.ini-production  /data/softwares/php/etc/php.ini

    7、复制启动脚本：
     cp sapi/fpm/init.d.php-fpm  /etc/init.d/php-fpm
     chmod +x /etc/init.d/php-fpm 
