#!/bin/bash
wget 47.254.89.175/shell/redis.status -O /usr/local/etc/zabbix_agentd.conf.d/redis.status
wget 47.254.89.175/shell/redis_status.sh -O /usr/local/bin/redis_status.sh
chmod 755 /usr/local/bin/redis_status.sh
local_ip=`ifconfig | grep '192.168' | awk '{print $2}'`
redis_port=`ss -lntpu | grep 192.168. | awk  '{print $5}' | awk -F: '{print $2}'`
sed -i "s/192.168.162.115/$local_ip/" /usr/local/bin/redis_status.sh
sed -i "s/5268/$redis_port/"  /usr/local/bin/redis_status.sh
pkill zabbix_agentd
zabbix_agentd

