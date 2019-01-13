#!/bin/bash
for i in   `sed -n "/-A INPUT/p" /etc/sysconfig/iptables-config | awk '{print $8}'`
do 
   expr 1 + $i &>/dev/null
   if [ "$?" -ne 0 ]; then
      iptables -I INPUT -p tcp -m   multiport --dports    $i -j ACCEPT
   else
       iptables -I INPUT -p tcp -m  tcp  --dport  $i -j ACCEPT
   fi
done
for i in   `sed -n "/-A OUTPUT/p" /etc/sysconfig/iptables-config | awk '{print $8}'`
do 
   expr 1 + $i &>/dev/null
   if [ "$?" -ne 0 ]; then
      iptables -I OUTPUT -p tcp -m   multiport --dports    $i -j ACCEPT
   else
       iptables -I OUTPUT -p tcp -m  tcp  --dport  $i -j ACCEPT
   fi
done
