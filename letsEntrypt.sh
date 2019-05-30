#!/bin/bash
token=('xxx',
'xxx') #token存放数组
#[ -d /root/.acme.sh/$1 ] && echo "证书已存在/root/.acme.sh/$1" && exit 6
[ -d /ssl/$1 ] && echo "证书已存在/ssl/$1" && exit 6
domain=${1%.*}
domain=${domain%.*}
domain=${1#$domain*.} #截取主域名
host=${1%*.$domain} #截取主机记录
echo $host
[ -d /root/.acme.sh ] || curl  https://get.acme.sh | sh #下载let'sentrypt脚本
i=0
a=def
while [ $i -lt  ${#token[@]} ];  #找到域名对应的token
do
    toke=${token[$i]}
    curl -X POST https://api.dnspod.com/Domain.Info  -d "user_token=$toke&format=json&domain=$domain" | grep '"code":"1"' 
    if [ $? -eq 0 ];then
        echo $toke
        domainid=`curl -X POST https://api.dnspod.com/Domain.Info  -d "user_token=$toke&format=json&domain=$domain" | awk -F'"id":"' '{print $2}' | sed 's/\".*$//'`#获取域名id
        curl -X POST https://api.dnspod.com/Record.List -d "user_token=$toke&format=json&domain_id=$domainid"  | grep $host #查找是否有这条记录
        if [ $? -eq 0 ];then
            a=${toke%%,*}
            b=${toke#*,}
        else
            echo '未添加域名记录，请先添加域名到DNSPOD'
        fi
    fi	
    let i++
done
if [ $a == 'def' ];then
    echo $1
    echo "你的域名不在目前已知的DNSPOD账号中"
else

    export DPI_Id="$a"
    export DPI_Key="$b"
    /root/.acme.sh/acme.sh --issue --dns dns_dpi -d $1  --debug 2
    [ -d /ssl/$1 ] || mkdir -p  /ssl/$1
    /root/.acme.sh/acme.sh --installcert -d $1 --key-file /ssl/$1/$1.key --fullchain-file /ssl/$1/$1.cer && echo "证书生成成功/ssl/$1"
fi
