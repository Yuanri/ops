# openfalcon 的使用总结

##1、falcon-agent 安装升级脚本：

falcon_agent_install.sh
        
##2、falcon 相关组件通用监控自拉起脚本：

falcon_monitor.sh

##3、falcon-agent plugin脚本：

60_run_process-check-scripts.py  #支持不同业务的服务器打上标签，tags 为其父级路径名

60_mysql_status.py
        
##4、redis 监控脚本

falcon_monitor_redis.py  #支持给不同业务的redis 打上标签
