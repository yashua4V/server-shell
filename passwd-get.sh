#!/bin/bash
#yum -y install expect &>/dev/null && echo expect安装成功
#yum -y install net_tools &>/deb/null && echo ifconfig安装成功
#mysql_old_pass=`awk '{print $NF}' /root/.mysql_secret`
basecode='0123456789qwertyuiopasdfghjklzxcvbnm()!@#$%^&*_+:<>?'
for i in {1..30}
    do
    random_num=$[$RANDOM%52]
    pice_code=${basecode:$random_num:1}
    pass_word=$pass_word$pice_code
done
random_num=$[$RANDOM%26]
baseword=qwertyuiopasdfghjklzxcvbnm
pick_word=${baseword:$random_num:1}
random_num2=$[$RANDOM%26]
pick_word2=${baseword:$random_num2:1}
echo ${pick_word}${pass_word}${pick_word2}
#expect <<  EOF
#spawn mysql -uroot  -p
#expect "password:" {send "$mysql_old_pass\r"}
#expect "mysql>" {send "SET PASSWORD FOR root@localhost=PASSWORD('$pass_word');\r"}
#expect "mysql>" {send "exit\r"}
#EOF
#[ $? -eq 0 ] && echo mysql密码修改成功,密码是:$pass_word || echo 密码修改失败
#serverid=`ifconfig | awk '/192.168/{print $2}'`
#server_id=${serverid##*.}
#sed -i  "/\[mysqld\]/a relay-log       = relay-log " /usr/my.cnf
#sed -i  "/\[mysqld\]/a binlog-format   = statement " /usr/my.cnf
#sed -i  "/\[mysqld\]/a log_bin         = mysql-bin " /usr/my.cnf
#sed -i  "/\[mysqld\]/a server-id       = $server_id " /usr/my.cnf
#systemctl restart mysql
#if [ $server_id -eq 4 ];then
#    m_binfile=`mysql -uroot -p$pass_word -e "show master status\G"  2>/dev/null | awk '/File/{print $2}'`
#    m_posi=`mysql -uroot -p$pass_word -e "show master status\G"  2>/dev/null | awk '/Position/{print $2}'`
#    echo "bin文件名为:$m_binfile posi位置为:$m_posi"
#    mysql -uroot -p$pass_word -e "GRANT REPLICATION SLAVE ON *.* TO 'slave'@'192.168.%.%' IDENTIFIED BY 'slave1212';"  2>/dev/null
#elif [[ $server_id -eq 5 || $server_id -eq 6 ]];then
#    read -p "主库bin文件名为:" m_bin
#    read -p "主库position位置为:" m_position
#    m_ip=`ifconfig | awk '/192.168/{print $2}' | sed 's/\(.*\)\(.\)/\14/'`
#    m_port=`ss -antpu| grep mysql | awk '{print $5}' | sed 's/\(:::\)\(.*\)/\2/'`
#    mysql -uroot -p$pass_word -e "change master to master_host='$m_ip',master_port=$m_port,master_user='slave',master_password='slave1212',master_log_file='$m_bin',master_log_pos=$m_position;"
#    mysql -uroot -p$pass_word -e "start slave;"
#    slave_status=`mysql -uroot -p$pass_word -e "show slave status\G" 2>/dev/null | grep Yes |wc -l`
#    if [ "$slave_status" -eq 2 ] ;then
#        echo "从库配置成功"
#    else
#        echo "从库配置失败请检查"
#    fi
#else
#    echo “警告:内网划分不正确，或在主库或从库服务器上”
#fi
