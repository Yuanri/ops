#!/usr/bin/env python
import os
import json

procPath='/data/monitor/process-check-scripts'
procName=[]
for proc in os.listdir(procPath):
	if proc[0] != '.' :
		procName+=[{'{#PROC_NAME}':proc}]

print json.dumps({'data':procName},sort_keys=True,indent=4,separators=(',',':'))
