#!/bin/bash
#获取当天的日期时间,脚本工作路径
date=`date +%Y%m%d`
workpath=/usr/local/nginx/logs
#所有网站日志的路径
overview=`find $workpath -type d`
#对所有路径结果迭代，找出其中日志文件并备份
for i in $overview
do
    for j in `find $i  -maxdepth 1  -type f -name *log -cmin -240` #找出4小时内修改过的日志文件并备份分割
    do
        logpath=${j%/*}
        logname=${j##*/}
        mv ${logpath}/${logname} ${logpath}/${date}${logname}
    done
    for k in `find $i  -maxdepth 1  -type f -name *log -cmin +1380` #找出23小时没有修改过的备份日志文件删除
    do
        rm -rf $k
    done    
done
#kill -USR1 $(cat $workpath/nginx.pid) #重启nginx服务，完成日志分割
/usr/local/nginx/sbin/nginx -s reload
