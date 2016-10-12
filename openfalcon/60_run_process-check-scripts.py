#!/usr/bin/env python
import os
import json
import time
import sys

'''
	次脚本是openfalcon-agent 的插件脚本，主要功能：提供给开发自定义监控进程的接口
	1、定时遍历 procPath 路径下的可执行脚本，根据脚本输出中是否有 OK 来判断，若有OK，则正常，相反，则异常，需要告警
	2、脚本会根据自己给上报结果打上tags,tags 为此脚本机父级路径名称
	  如：plugin/monitor_prc/falcon/60_run_process-check-scripts.py  则:tags = falcon
	3、根据配置文件 自动识别 endpoint
'''

Idc='jxq'
Metric='monitor_proc'
procPath='/data/monitor/process-check-scripts'
cfg='/data/softwares/openfalcon/falcon-agent/cfg.json'


class metrics(object):
	def __init__(self,endpoint,metric,value,tags,step=60,counterType='GAUGE'):
		self.endpoint = endpoint
		self.metric = metric
		self.timestamp = int(time.time())
		self.step = step
		self.value = value
		self.counterType = counterType
		self.tags = tags 

	def to_Json(self):
		return json.dumps(self, default=lambda o: o.__dict__,sort_keys=True, indent=4)
	
def get_metric(App,value):
	Project=sys.argv[0].split('/')[-2]
	Step=sys.argv[0].split('/')[-1].split('_')[0]
	Tags='idc='+Idc+',project='+Project+',app='+App
	f=open(cfg,'r')
	cfg_data=json.load(f)
	f.close()
	host=cfg_data['hostname']
	metric=metrics(host,Metric,int(value),Tags,int(Step))
	return metric


def run_scripts(procPath):	
	payload=[]
	try:
		if not os.path.isdir(procPath):
			os.makedirs(procPath)
	except OSError as exc:
		if exc.errno == errno.EEXIST and os.path.isdir(procPath):
			pass
		else :raise
	os.chdir(procPath)
	for proc in os.listdir(procPath):
		if os.access(proc,os.X_OK) :
			cmd='./'+proc+" | grep  -m1 -c -w 'ok'"
			value=os.popen(cmd).readlines()[0].strip('\n')
			metric=get_metric(proc,value)
			payload.append(metric)
	#	else:
	#		print "PLS check file mode: ",proc
	if len(payload) :
		print  json.dumps(payload, default=lambda o: o.__dict__, indent=4)

if __name__=='__main__':
	run_scripts(procPath)