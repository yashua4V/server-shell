#!/bin/bash
case $1 in
status) #redis存活监控 (redis_alive):redis本地监控agent使用ping，如果指定时间返回PONG表示存活，否则redis不能响应请求，可能阻塞或死亡。当返回值不为0时，redis挂了，告警
    redis-cli -h 192.168.162.115 -p 5268 'ping' | grep 'PONG' &>/dev/null
    echo $?
    ;;
mem)  #redis 分配内存大于进程使用内存表示redis已使用swap分区，则告警
#    used_mem=`redis-cli -h 192.168.162.115 -p 5268 'info' | grep 'used_memory:' | awk -F : '{print $2}'`
#    rss_mem=`redis-cli -h 192.168.162.115 -p 5268 'info' | grep 'used_memory_rss:' | awk -F : '{print $2}'`
#    if [ $used_mem -ge $rss_mem ] ;then
#       echo 1
#    else
#       echo 0
#    fi
    #返回值大于100表示redis已使用swap分区，则告警
    mem_num=`redis-cli -h 192.168.162.115 -p 5268 'info' | grep -w mem_fragmentation_ratio | awk -F [:.] '{print $2}'`

    if [ $mem_num -gt 0 ];then
       echo $mem_num
    else
       echo 120
    fi
    ;;
blocked)  #list阻塞调用被阻塞的连接个数 (blocked_clients): 如果监控数据大于0，告警
    redis-cli -h 192.168.162.115 -p 5268 'info' | grep 'blocked_clients' | awk -F : '{print $2}'
    ;;
esac
