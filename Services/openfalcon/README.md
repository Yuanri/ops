# 1、官方git地址
https://github.com/open-falcon


### API
http://open-falcon.org/falcon-plus/


### python

    import requests


    api=r'http://127.0.0.1:8080/api/v1'

    #获取sig
    data={"user":"root","password":"xxxxxx"}
    re_sig=requests(api+'/user/login',params=data)


    header={"Apitoken":'{"name":"root","sig":"484hg7q773427gq48454"}'}

    re=requests.get(api+/user/current',headers=header)
    print re.text
