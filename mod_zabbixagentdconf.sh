#!/bin/bash
read -p '本机主机名:' ZA_HOSTNAME
read -p '是否监控MYSQL y|n:' IF_MYSQL
if [ $IF_MYSQL == 'y' ] ;then
   read -p 'mysql数据库的密码:' PASSWORD_MYSQL
   read -p 'mysql数据库的端口:' PORT_MYSQL
   echo 'Include=/usr/local/etc/zabbix_agentd.conf.d/' >>  /usr/local/etc/zabbix_agentd.conf
   cp -P /usr/local/etc/usr/local/etc/chk_mysql.sh /usr/local/etc/chk_mysql.sh && cp -P /usr/local/etc/zabbix_agentd.conf.d/usr/local/etc/zabbix_agentd.conf.d/* /usr/local/etc/zabbix_agentd.conf.d/
   sed -i "5c MYSQL_PWD='$PASSWORD_MYSQL'"  /usr/local/etc/chk_mysql.sh
   sed -i "11c MYSQL_PORT='$PORT_MYSQL'"  /usr/local/etc/chk_mysql.sh
   sed -i "1c UserParameter=mysql.ping,mysqladmin  -uroot -p'$PASSWORD_MYSQL' -P$PORT_MYSQL ping 2>/dev/null | grep -c alive" /usr/local/etc/zabbix_agentd.conf.d/mysql.ping
   sed -i "1c UserParameter=mysql.replication,mysql -uroot -p'$PASSWORD_MYSQL' -e 'show slave status\\G' 2>/dev/null|grep -E 'Slave_IO_Running|Slave_SQL_Running'|awk '{print $2}'|grep -c Yes" /usr/local/etc/zabbix_agentd.conf.d/mysql.replication
fi
iptables -I INPUT -p tcp --dport 10050 -j ACCEPT
iptables -I INPUT -p tcp --dport $PORT_MYSQL -j ACCEPT
sed -i 's/^ServerActive=127.0.0.1/ServerActive=127.0.0.1,103.72.147.80/' /usr/local/etc/zabbix_agentd.conf && sed -i 's/^Server=127.0.0.1/Server=127.0.0.1,103.72.147.80/' /usr/local/etc/zabbix_agentd.conf && sed -i 's/# UnsafeUserParameters=0/UnsafeUserParameters=1/' /usr/local/etc/zabbix_agentd.conf && sed -i 's/# EnableRemoteCommands=0/EnableRemoteCommands=1/' /usr/local/etc/zabbix_agentd.conf && sed -i "s/Hostname=Zabbix server/Hostname=$ZA_HOSTNAME/" /usr/local/etc/zabbix_agentd.conf && zabbix_agentd  && ss -lntpu | grep 10050 &> /dev/null && echo '启动OK'
   
