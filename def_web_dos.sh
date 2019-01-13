#!/bin/bash
#该脚本接受两个参数，第一个参数确定时间精度，第二个参数确定服务器被同一IP重复访问多少次报警
#该脚本返回超过第二个参数设定的阈值的IP
#得到可用于通过sed修改awk匹配语句的变量，系统当前日时间(精确到分钟)
systime_min=`date '+\\\\\[%d\\\\\/%b\\\\\/%Y\\\\\:%H\\\\\:%M'`
#同上，精确到小时
systime_hour=`date '+\\\\\[%d\\\\\/%b\\\\\/%Y\\\\\:%H'`
request_times=$2
path=/usr/local/etc/
case $1 in
min)
    #修改基本sed基语句（每分钟执行的那一条）
    sed -n  "s/DATETIMEMIN/$systime_min/p" ${path}awk_cmd_base.txt > ${path}awk_min.sh
    #得到临时文件并执行
    sed -i '1i #!/bin/bash' ${path}awk_min.sh && sh ${path}awk_min.sh | awk  '{ip[$1]++} END{for(i in ip) {print ip[i],i}}' | awk -v frequency=$request_times '$1>frequency{print $0} END{print "default"}'
    rm -rf ${path}awk_min.sh ;;
hour)
    #修改基本sed基语句（每小时执行的那一条）
    sed -n  "s/DATETIMEHOUR/$systime_hour/p" ${path}awk_cmd_base.txt > ${path}awk_hour.sh
    #得到临时文件并执行
    sed -i '1i #!/bin/bash' ${path}awk_hour.sh && sh ${path}awk_hour.sh | awk  '{ip[$1]++} END{for(i in ip) {print ip[i],i}}' |  awk -v frequency=$request_times '$1>frequency{print $0} END{print "default"}'
    rm -rf ${path}awk_hour.sh;;
*)
    echo "useage: $0 {min|hour}{int}"
esac

