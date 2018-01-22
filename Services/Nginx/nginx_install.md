# NGINX 部署安装

### 准备安装包：

[http://luajit.org/download/LuaJIT-2.0.5.tar.gz](http://luajit.org/download/LuaJIT-2.0.5.tar.gz)

[https://github.com/simpl/ngx_devel_kit/archive/master.zip](https://github.com/simpl/ngx_devel_kit/archive/master.zip)

[https://github.com/openresty/lua-nginx-module/archive/master.zip](https://github.com/openresty/lua-nginx-module/archive/master.zip)

[http://tengine.taobao.org/download/tengine-2.2.1.tar.gz](http://tengine.taobao.org/download/tengine-2.2.1.tar.gz)

[https://github.com/nbs-system/naxsi/archive/master.zip](https://github.com/nbs-system/naxsi/archive/master.zip)

## 1、注：

    nginx 启动脚本：
    默认安装路径：/usr/local/nginx
    nginx 安装脚本：

    下载地址：
    wget http://nginx.org/download/nginx-1.9.5.tar.gz

    Nginx+PHP（FastCGI）搭建胜过Apache十倍的Web服务器
    http://os.51cto.com/art/201111/304607.htm
    
    
    nginx version: senginx/1.6.1
    built by gcc 4.4.7 20120313 (Red Hat 4.4.7-4) (GCC)
    TLS SNI support enabled
    configure arguments: 
    --prefix=/data/soft/nginx 
    --with-http_ssl_module 
    --with-http_gunzip_module 
    --with-http_gzip_static_module 
    --with-http_gzip_static_module 
    --with-http_auth_request_module 
    --with-http_stub_status_module 
    --with-http_sub_module 
    --add-module=/path/to/senginx-1.6.1/neusoft/ngx_http_neteye_security 
    --add-module=/path/to/senginx-1.6.1/3rd-party/naxsi/naxsi_src 
    --add-module=/path/to/senginx-1.6.1/3rd-party/nginx-upstream-fair 
    --add-module=/path/to/senginx-1.6.1/3rd-party/headers-more-nginx-module 
    --add-module=/path/to/senginx-1.6.1/3rd-party/ngx_http_substitutions_filter_module 
    --add-module=/path/to/senginx-1.6.1/3rd-party/nginx_tcp_proxy_module 
    --add-module=/path/to/senginx-1.6.1/neusoft/ngx_http_upstream_fastest 
    --add-module=/path/to/senginx-1.6.1/neusoft/ngx_http_upstream_persistence 
    --add-module=/path/to/senginx-1.6.1/neusoft/ngx_http_session 
    --add-module=/path/to/senginx-1.6.1/neusoft/ngx_http_robot_mitigation 
    --add-module=/path/to/senginx-1.6.1/neusoft/ngx_http_status_page 
    --add-module=/path/to/senginx-1.6.1/neusoft/ngx_http_if_extend 
    --add-module=/path/to/senginx-1.6.1/neusoft/ngx_http_cache_extend 
    --add-module=/path/to/senginx-1.6.1/neusoft/ngx_http_cookie_poisoning 
    --add-module=/path/to/senginx-1.6.1/neusoft/ngx_http_web_defacement 
    --add-module=/path/to/senginx-1.6.1/neusoft/ngx_http_ip_blacklist 
    --add-module=/path/to/senginx-1.6.1/neusoft/ngx_http_ip_behavior 
    --add-module=/path/to/senginx-1.6.1/neusoft/ngx_http_whitelist 
    --add-module=/path/to/senginx-1.6.1/neusoft/ngx_http_statistics 
    --add-module=/path/to/senginx-1.6.1/3rd-party/ngx_cache_purge-1.3


## 2、安装nginx

    wget   http://nginx.org/download/nginx-1.9.2.tar.gz
    wget   ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.37.tar.gz
    wget   http://zlib.net/zlib-1.2.8.tar.gz
    wget   http://www.openssl.org/source/openssl-1.0.2c.tar.gz

    tar -xf  pcre-8.37.tar.gz
    tar -xf  zlib-1.2.8.tar.gz
    tar -xf openssl-1.0.2c.tar.gz
    tar -xf nginx-1.9.2.tar.gz


    user
    cd  nginx-1.9.2
    ./configure \
    --prefix=/opt/nginx-1.9.2 \
    --user=webadmin  \
    --group=webadmin  \
    --with-http_ssl_module  \
    --with-pcre=../pcre-8.37  \
    --with-zlib=../zlib-1.2.8  \
    --with-poll_module  \
    --with-openssl=../openssl-1.0.2c  \

    make  && make install

    useradd -M -s /usr/sbin/nologin www
    cd /opt/nginx-1.9.2
    ./sbin/nginx


     --prefix=/data/soft/nginx \
     --with-http_ssl_module \
     --with-http_gunzip_module \
     --with-http_gzip_static_module \
     --with-http_gzip_static_module --with-http_auth_request_module \
     --with-http_stub_status_module --with-http_sub_module \
     --user=nobody  \
     --group=nobody \
     --with-poll_module \
     --with-openssl=../openssl-1.0.2c



## 3、安装 Tenginx 

    下载地址：
    http://tengine.taobao.org/

    安装依赖包
    yum install  -y   lua lua-devel  luajit luajit-devel  

    Lua module:
    http://www.cnblogs.com/yjf512/archive/2012/03/27/2419577.html

    ./configure \
    --prefix=/data/softwares/tengine  \
    --with-http_lua_module=shared \
    --with-luajit-inc=/usr/local/include/luajit-2.0  \
    --with-luajit-lib=/usr/local/lib \
    --add-module=../ngx_devel_kit-0.3.0 \
    --add-module=../lua-nginx-module-0.10.5



### 4 、Tenginx +Lua+Naxsi

4.1 参考资料：

    http://www.cnblogs.com/yjf512/archive/2012/03/27/2419577.html

4.2 安装依赖包

    yum install pcre pcre-devel  lua lua-devel  openssl openssl-devel
    
4.3 安装LuaJit

    tar  -xvf   LuaJIT-2.0.4.tar.gz

    ./configure --prefix=/data/softwares/tengine  
    --with-http_ssl_module  
    --with-http_lua_module=shared 
    --with-luajit-inc=/usr/local/include/luajit-2.0  
    --with-luajit-lib=/usr/local/lib 
    --add-module=../ngx_devel_kit-0.3.0 
    --add-module=../lua-nginx-module-0.10.5


4.4 查看进程依赖关系：

    ldd ./sbin/nginx 


### 5 添加NGINX web 防火墙，防 XSS 和 SQL 注入
   
5.1 naxsi下载
 
    https://github.com/nbs-system/naxsi/archive/master.zip


5.2 编译安装：luajit

    tar  -xvf   LuaJIT-2.0.4.tar.gz
    cd    LuaJIT-2.0.4
    make
    make PREFIX=/data/softwares/tengine2.1.2-lua-naxsi    install

    ./configure 
    --prefix=/data/softwares/tengine2.1.2-lua-naxsi 
    --with-http_ssl_module 
    --with-http_lua_module=shared 
    --with-luajit-inc=/usr/local/include/luajit-2.0/ 
    --with-luajit-lib=/usr/local/lib 
    --add-module=../ngx_devel_kit-0.3.0 
    --add-module=../lua-nginx-module-0.10.5 
    --add-module=../naxsi-master/naxsi_src/




