#!/bin/bash
#
# iptables rule 规则配置脚本
# 当前默认策略：
#   1、允许ICMP
#   2、允许 lo chain 
#   3、默认允许所有连接
#



################################################
##### 建议不要修改以下配置 
###### create sub-chain 
iptables -N ETH0_TCP    >   /dev/null 2>&1
iptables -N ETH0_UDP    >   /dev/null 2>&1
iptables -N ETH0_ICMP   >   /dev/null 2>&1
iptables -N LO          >   /dev/null 2>&1
 
## acl 
iptables -F INPUT
iptables -A INPUT -i eth0 -p tcp  -j ETH0_TCP
iptables -A INPUT -i eth0 -p udp  -j ETH0_UDP
iptables -A INPUT -i eth0 -p icmp -j ETH0_ICMP
iptables -A INPUT -i lo -j LO
#################################################

#####################################################################################
## 自定义修改策略部分
## ICMP rules 
## acl
iptables  -F  ETH0_ICMP
iptables  -A  ETH0_ICMP -p icmp -j ACCEPT

## end 若已配置上面的acl，请取消下面的一行注释 
# iptables  -A  ETH0_ICMP -j DROP
#####################################

## ETH0_TCP rules 
iptables  -F  ETH0_TCP
#iptables -A  ETH0_TCP -p tcp --dport 80 -j ACCEPT

## end 若已配置上面的acl，请取消下面的一行注释
# iptables  -A  ETH0_TCP -j DROP
#####################################

##### ETH0_UDP rules ##############
## acl
iptables  -F  ETH0_UDP
#iptables -A  ETH0_UDP -p udp --dport 80 -j ACCEPT

## end 若已配置上面的acl，请取消下面的一行注释
# iptables  -A  ETH0_UDP -j DROP

## 自定义修改策略部分结束
######################################################################################

################################################
##### 建议不要修改以下配置 
##### LO rules 
iptables -F LO
iptables -A LO -j ACCEPT

## end 
iptables -A LO -j DROP



##### END rules ##################
iptables -P INPUT ACCEPT
#################################################
