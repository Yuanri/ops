# PING
### PING网络监控，将数据上报给openfalcon
每60s 采集一次，每隔0.5s发送一次，总共发送100个包，上报 avg 和 loss 

    #!/usr/bin/env python

    import commands
    import time
    import json
    import requests

    endpoint='172.27.33.12'

    def PING(desIP)
      ''' PING args'''
      ping={}
      args={
        'count':100,
        'size':48,
        'deadline':60,
        'Interval':0.5
      }

      CMD=r'ping -c %s -s %s -w %s -i %s %s' % (args['count'],args['size'],args['deadline'],args['Interval'],desIP)
      res=commands.getstatusoutput(CMD)

      loss= res[1].split('\n')[-2].split(' ')[-5].replace('%','')
      avg = res[1].split('\n')[-1].split('/')[-3]
      ts  = int(time.time())

      ping=[
        {
          "endpoint": endpoint,
          "metric": "ping.loss",
          "timestamp": ts,
          "step": 60,
          "value": float(loss),
          "counterType": "GAUGE",
          "tags": "ip="+desIP,
        },
        {
          "endpoint": endpoint,
          "metric": "ping.avg",
          "timestamp": ts,
          "step": 60,
          "value": float(avg),
          "counterType": "GAUGE",
          "tags": "ip="+desIP,
        }	
      ]

      return ping


    if __name__ == '__main__':
      desIPs=['10.0.0.41']
      reports=[]
      for ip in desIPs:
        reports.extend(PING(ip))
      print reports
      r = requests.post("http://127.0.0.1:19080/v1/push", data=json.dumps(reports))
      print r.text
