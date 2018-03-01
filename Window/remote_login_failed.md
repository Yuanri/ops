# Window 故障汇总


## 1、远程登录失败  window Server 2012
![image](https://github.com/Yuani/ops/blob/master/Window/images/remote_login_failed.png)

### 解决方案：
重新安装远程登录控制  远程登录session 
打开服务器管理
![image](https://github.com/Yuani/ops/blob/master/Window/images/server_manange.png)

![image](https://github.com/Yuani/ops/blob/master/Window/images/add_role_function.png)
![image](https://github.com/Yuani/ops/blob/master/Window/images/remote_desktop_manange.png)

如果没有找到上图，单机【功能】找到 remote 关键字，所有关于远程管理的服务勾上，下一步，直到开始安装，重启系统
