## NGINX 配置
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

### 3、Nginx 反向代理 传递源IP

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_intercept_errors on;
    }

### 4、关闭favicon.ico不存在时记录日志
把以下配置放到 server {} 块.
    location /favicon.ico {
        log_not_found off;
        access_log off;
    }
### 5、不允许访问隐藏文件例如 .htaccess, .htpasswd, .DS_Store (Mac).

    location ~ /\. {
        deny all;
        access_log off;
        log_not_found off;
    }
