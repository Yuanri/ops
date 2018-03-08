# RedHat

### 1、ERR1：yum 命令提示系统没有注册
    This system is not registered with an entitlement server. You can use subscription-manager to register
##### 解决方案：
    yum remove  subscription-manager  rhn-check
    使用 yum 移除，可以自动处理包之间的依赖关系

