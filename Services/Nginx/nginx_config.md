1   ERR:no "ssl_certificate" is defined in server listening on SSL port while SSL handshaking, client: ****

解决方案：

    server {
     listen 443 default_server ssl;
     server_name www.example.com;
     ........
    }
