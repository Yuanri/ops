## 编译安装常见错误 
在 CentOS 下编译 PHP5 的时候，为了安装某一扩展（ext），新增了编译参数，会出各种错误。基本上都可以通过 yum 安装相应的库或者改变编译参数来解决问题，在此记录如下。


#### 1、PHP 出现 segmentation fault 错误
    现象：安装完成后出现的这个问题让我一顿网上狂搜，但都无济于事。在运行任何有关 PHP 的命令时都会返回 segmentation fault 的错误，比如：php -v 或 php -m 等。经过不断试错和排查 php.ini，最终发现是在安装完 Zend Guard Loader 之后出现的。

    原因： Zend Guard Loader 的配置错误。

    解决办法：将 extension = ZendGuardLoader.so 改为 zend_extension = ZendGuardLoader.so即可。

    最后，我将所有可选安装的配置都单独放到 /usr/local/php/php.d 下了，而不是一股脑放到 php.ini 中，这样便于出问题时排查。

#### 2、ICU 相关错误
    现象：Unable to detect ICU prefix or /usr//bin/icu-config failed. Please verify ICU install prefix and make sure icu-config works

    解决办法：yum install -y icu libicu libicu-devel

    关于 ICU 的编译参数：./configure –with-icu-dir=/usr

#### 3、bzip2 相关错误
    现象：checking for BZip2 support… yes checking for BZip2 in default path… not found configure: error: Please reinstall the BZip2 distribution

    解决办法：yum install -y bzip2 bzip2-devel

    关于 bzip2 的编译参数：./configure –with-bz2

#### 4、gmp 相关错误
    现象：checking for bind_textdomain_codeset in -lc… yes checking for GNU MP support… yes configure: error: Unable to locate gmp.h

    解决办法：yum install -y gmp-devel

    关于 gmp 的编译参数：./configure –with-gmp

#### 5、readline 相关错误
    现象：configure: error: Please reinstall libedit – I cannot find readline.h

    解决办法：安装 Editline Library (libedit)，官网：http://thrysoee.dk/editline/

    下载最新版 libedit 编译安装即可。

    关于 readline 的编译参数：./configure –with-readline

#### 6、xsl 相关错误
    现象：configure: error: xslt-config not found. Please reinstall the libxslt >= 1.1.0 distribution

    解决办法：yum install -y libxslt libxslt-devel libxml2 libxml2-devel

    关于 xsl 的编译参数：./configure –with-xsl

#### 7、pcre 相关错误
    现象：checking for PCRE headers location… configure: error: Could not find pcre.h in /usr

    解决办法：yum install -y pcre-devel

    关于 pcre 的编译参数：./configure –with-pcre-dir
    
    备注：在 CentOS 5.x 中，pcre 的最新版本为 6.6，版本过低会导致在编译 Apache 2.4.x 的时候出现错误。因此，建议编译安装 pcre 的最新版 8.35，替换低版本的 pcre。
