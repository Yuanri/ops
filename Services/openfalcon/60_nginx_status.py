#!/usr/bin/env python
#-*-coding:utf8-*-

import requests 
import json
import time



url='http://127.0.0.1/ngx_status'
cfg='/path/to/falcon-agent/cfg.json'

class Metric(object):
	def __init__(self,endpoint,metric,value,tags='',step=60,counterType='COUNT'):
		self.endpoint = endpoint
		self.metric = metric
		self.timestamp = int(time.time())
		self.step = step
		self.value = value
		self.counterType = counterType
		self.tags = tags
		
def get_endpoint(cfg):
    try:
		f=open(cfg,'r')
		cfg_data=json.load(f)
		f.close()
		endpoint=cfg_data['hostname']
		return endpoint
    except:
		print "%s ERR:Can't open file: %s " % ( time.strftime("%Y-%m-%d %X",time.localtime(),cfg))
		exit()


def get_status(url):
	endpoint=get_endpoint(cfg)
	
	re=requests.get(url,timeout=5)
	'''
	nginx status:
	
	Active connections: 23920 
	server accepts handled requests request_time
	134477926 134477926 268280449 532142081852
	Reading: 1 Writing: 1319 Waiting: 22600
	
	'''
	ngx_status=[]
	alive=0
	if re.ok:
		alive=1
		raw=re.text.split('\n')

		ngx_status.append(Metric(endpoint,'nginx.net.connections',int(raw[0].split()[2]),counterType='GAUGE'))
		ngx_status.append(Metric(endpoint,'nginx.net.accepts',int(raw[2].split()[0]),counterType='COUNTER'))
		ngx_status.append(Metric(endpoint,'nginx.net.handled',int(raw[2].split()[1]),counterType='COUNTER'))
		ngx_status.append(Metric(endpoint,'nginx.net.requests',int(raw[2].split()[2]),counterType='COUNTER'))
		
		ngx_status.append(Metric(endpoint,'nginx.net.reading',int(raw[3].split()[1]),counterType='GAUGE'))
		ngx_status.append(Metric(endpoint,'nginx.net.writing',int(raw[3].split()[3]),counterType='GAUGE'))
		ngx_status.append(Metric(endpoint,'nginx.net.waiting',int(raw[3].split()[5]),counterType='GAUGE'))
		
	ngx_status.append(Metric(endpoint,'nginx.alive',int(alive),counterType='GAUGE'))
	
	data=json.dumps(ngx_status,default=lambda o: o.__dict__, indent=4)
	print data

if __name__ == '__main__':
	get_status(url)
