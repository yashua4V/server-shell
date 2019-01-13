#!/bin/bash
wget 47.254.89.175/shell/log_ip -O /usr/local/etc/zabbix_agentd.conf.d/log_ip
wget 47.254.89.175/shell/awk_cmd_base.txt -O /usr/local/etc/awk_cmd_base.txt
wget 47.254.89.175/shell/def_web_dos.sh -O /usr/local/etc/def_web_dos.sh
chmod 755 /usr/local/etc/def_web_dos.sh
chmod 775 /usr/local/etc
chown root:zabbix /usr/local/etc
pkill zabbix_agentd
zabbix_agentd

