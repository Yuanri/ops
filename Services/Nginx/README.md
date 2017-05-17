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
