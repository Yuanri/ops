#!/bin/env python
#-*- coding:UTF-8 -*-
__author__ = 'Mac Yuan'


import json
import time
import redis
import requests
import os,sys

PASSWORD=''
host=['127.0.0.1','6379',PASSWORD]

URL='http://127.0.0.1:1988/v1/push'
cfg='/data/softwares/openfalcon/falcon-agent/cfg.json'

monit_keys = [
    ('connected_clients','GAUGE'), 
    ('blocked_clients','GAUGE'), 
    ('used_memory','GAUGE'),
    ('used_memory_rss','GAUGE'),
    ('mem_fragmentation_ratio','GAUGE'),
    ('total_commands_processed','COUNTER'),
    ('rejected_connections','COUNTER'),
    ('expired_keys','COUNTER'),
    ('evicted_keys','COUNTER'),
    ('keyspace_hits','COUNTER'),
    ('keyspace_misses','COUNTER'),
    ('keyspace_hit_ratio','GAUGE'),
    ('memory_ratio','GAUGE'),
    ('maxmemory','GAUGE'),
    
]


class metrics(object):
    def __init__(self,endpoint,metric,value,tags,step=60,counterType='GAUGE'):
        self.endpoint = endpoint
        self.metric = metric
        self.timestamp = int(time.time())
        self.step = step
        self.value = value
        self.counterType = counterType
        self.tags = tags
               
    
def RedisPool(host):
    'Return a dict containing redis info '
    if host[2] == '':
        pool=redis.StrictRedis(host=host[0],port=host[1],socket_timeout=5)
    else:
        pool=redis.StrictRedis(host=host[0],port=host[1],password=host[2],socket_timeout=5)    
    return pool 

def RedisPing(host):
    r=RedisPool(host)
    alive=0
    'check rdis ping status'
    try:
        if r.ping():
            alive=1
    except Exception,e:
        print 'ERR:',e
    return     alive    
        
def GetInfo(endpoint,host,tags):
    payload=[]
    metric='redis.'

    'check rdis ping status'
    alive=RedisPing(host)
    m=metrics(endpoint,metric+'alive',alive,tags)
    payload.append(m)
    if alive != 1:
	    return json.dumps(payload, default=lambda o: o.__dict__, indent=4)
    
    'get redis info '
    r=RedisPool(host)
    info=r.info()
    maxmemory=r.config_get('maxmemory')
    info['maxmemory']=maxmemory['maxmemory']
        
    for key,vtype in monit_keys:
        if key == 'keyspace_hit_ratio' :
            try:
                value = float(info['keyspace_hits'])*100.0/(int(info['keyspace_hits']) + int(info['keyspace_misses']))
            except ZeroDivisionError:
                value = 0
        elif key == 'mem_fragmentation_ratio':
            value = float(info[key])
        elif key == 'memory_ratio' :
            try:
                value=float(info['used_memory'])*100.0/int(maxmemory['maxmemory'])
            except ZeroDivisionError:
                value = 0
        else:
            try:
                value = long(info[key])
            except:
                continue
                
	m=metrics(endpoint,metric+key,value,tags,60,vtype)
        payload.append(m)

    return json.dumps(payload, default=lambda o: o.__dict__, indent=4)

def main():
    f=open(cfg,'r')
    cfg_data=json.load(f)
    f.close()
    endpoint=cfg_data['hostname']
    tags='port='+host[1]
    
    payload=GetInfo(endpoint,host,tags)
    #print payload
    pushData(payload)
    
def pushData(payload):
    r = requests.post(URL, payload)
    print r.text


if __name__ == '__main__':
    main()
