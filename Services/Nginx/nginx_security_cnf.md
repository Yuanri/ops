## NGINX 安全设置
### 1、隐藏版本号

    http {
      ...
      server_tokens  off;
      ....
    }


### 2、拒绝IP直接访问

    server {
            listen 80 default_server;
            server_name _;
            access_log  off;
            return 403;
       }
