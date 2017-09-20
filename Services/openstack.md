# Openstack 运维



### 1、RDS 查询后台实例：
    如：查询rds 192.168.1.13  后台实例IP
    登录RDS控制节点
    neutron  lb-vip-list     | grep     192.168.1.13      
    neutron  lb-pool-list    | grep      replication_id
    neutron  lb-spool-show   
    neutron  lb-member-show
