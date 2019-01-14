#!/bin/bash
wget http://nginx.org/download/nginx-1.12.2.tar.gz -O /root/nginx-1.12.2.tar.gz
cd root
tar -xf nginx-1.12.2.tar.gz
cd nginx-1.12.2
yum -y install gcc pcre-devel  openssl-devel
useradd -s /sbin/nologin nginx
./configure  --prefix=/usr/local/nginx --user=nginx --group=nginx  --with-http_ssl_module &>/dev/null
make && make install &>/dev/null
rm -rf /usr/local/nginx/conf/nginx.conf
wget https://github.com/yashua4V/server-shell/raw/master/ngbeta -O /usr/local/nginx/conf/nginx.conf
back_ser_ip=`ifconfig | awk '/192.168/{print $2}' | sed -n 's/^\(.*\)\(.\)/\10/p'`
back_ser2_ip=`ifconfig | awk '/192.168/{print $2}' | sed -n 's/^\(.*\)\(.\)/\11/p'`
sed -i "s/192.168.164.10/$back_ser_ip/" /usr/local/nginx/conf/nginx.conf
sed -i "s/192.168.164.11/$back_ser2_ip/" /usr/local/nginx/conf/nginx.conf
nginx -t &>dell
/usr/local/nginx/sbin/nginx -s reload
rm -rf /root/nginx-1.12.2.tar.gz
rm -rf /root/nginx/-1.12.2

