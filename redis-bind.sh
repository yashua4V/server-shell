#!/bin/bash
local_ip=`ifconfig | awk '/192.168/{print $2}'`
for i in `ls /etc/redis/*`
do
 sed -i  "/^bind 127/c bind $local_ip" $i
done
for i in `ls /etc/init.d/redis*`
do
 $i restart
done
local_port=`ss -antpu | grep redis | awk '/192.168/{print $5}' | awk -F: '{print $2}'`
redis-cli -h $local_ip -p $local_port info &>/dev/null
[ $? -eq 0 ] && echo redis配置修改成功
