# Let's Encrypt免费又好用的证书

假设域名为：163.org
#### 1 克隆代码
    git clone https://github.com/letsencrypt/letsencrypt

#### 生产证书
    cd letsencrypt

    ./letsencrypt-auto certonly --standalone --email admin@163.org -d 163.org -d www.163.org
     命令解析
    --standalone 　　 需要手动关闭占用443端口的程序，此命令会占用443端口进行验证
    --email 　　admin@163.org 填写您的Email
    -d 163.org 　　需要使用ssl的域名（必须是当前主机绑定的地址，否则验证失败。）

#### 2 配置
    在完成Let's Encrypt证书的生成之后，我们会在"/etc/letsencrypt/live/163.org/"域名目录下有4个文件

      cert.pem - Apache服务器端证书
      chain.pem - Apache根证书和中继证书
      fullchain.pem - Nginx所需要ssl_certificate文件
      privkey.pem - 安全证书KEY文件

    如果我们使用的Nginx环境，那就需要用到fullchain.pem和privkey.pem两个证书文

    server {
      server_name 163.org;
      listen 443;

      ssl on;
      ssl_certificate /etc/letsencrypt/live/163.org/fullchain.pem;
      ssl_certificate_key /etc/letsencrypt/live/163.org/privkey.pem;
    }

    ps：在Nginx环境中，只要将对应的ssl_certificate和ssl_certificate_key路径设置成对应的文件路径就可以。
    不要移动和复制文件，因为续期的时候还会在这个文件生成证书。

#### 3 Let's Encrypt免费SSL证书有效期
    Let's Encrypt证书是有效期90天的，需要手工更新续期。

    将此命令添加到定时任务中即可自动续期
    * * * * 1 /var/www/letsencrypt/letsencrypt-auto renew
　　
