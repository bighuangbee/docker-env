#!/bin/bash

sh /root/mysql_backup/mysql_dump_script.sh

/usr/sbin/service cron start

crontab /root/mysql_backup/crontab


#添加定时任务任务
#执行 corontab -e
#添加如下内容：
#每1分钟
#*/1 * * * * sh /root/mysql_backup.sh
#每天凌晨2点
#00 02 * * * sh /root/mysql_backup.sh
