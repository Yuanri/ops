#### 1、官方git地址 https://github.com/open-falcon

#### API http://open-falcon.org/falcon-plus/

##### python获取token

    import requests


    api=r'http://127.0.0.1:8080/api/v1'

    #获取sig
    data={"name":"root","password":"xxxxxx"}
    re_sig=requests.post(api+'/user/login',params=data)
    print re_sig.text


    header={"Apitoken":'{"name":"root","sig":"484hg7q773427gq48454"}'}

    re=requests.get(api+/user/current',headers=header)
    print re.text

#### Graph API
1、进行一次索引数据的全量更新，方法为 

    #更新索引
    curl -s "$Hostname.Of.Task:$Http.Port/index/updateAll"
    
    # 删除过期索引
    curl -s "$Hostname.Of.Task:$Http.Port/index/delete"
