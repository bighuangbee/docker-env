#!/bin/sh

#添加定时任务任务
#执行 corontab -e
#添加如下内容：
#crontab -e 00 02 * * * /root/mysql_backup.sh
#每10分钟
#*/10 * * * * /root/mysql_dump_script.sh
#每天凌晨2点
#00 02 * * * /root/mysql_dump_script.sh

contrainerName=mysql_master
dbuser=root
dbpasswd=hiDronedb2020.
dbname=hidrone
dbhost=127.0.0.1
dbport=3306
filename=`date +%Y%m%d%H%M`.sql
backupPath="/Users/bighuangbee/mysql_backup/" #宿主机目录

maxBackupCount=60 #保存备份x天数据

#如果文件夹不存在则创建
#if [ ! -d $backupPath ]; then
#  mkdir -p $backupPath;
#fi

#测试

# mysqldump --opt --single-transaction --master-data=2 -R -h127.0.0.1 -P3306 -uroot -phiDronedb2020. hidrone > /opt/202108172012.sql
docker exec -i $contrainerName mysqldump --opt --single-transaction --master-data=2 -R -h$dbhost -P$dbport -u$dbuser -p$dbpasswd $dbname > $backupPath$filename


#找出需要删除的备份
delfile=`ls -l -crt  $backupPath/*.sql | awk '{print $9 }' | head -1`

#判断现在的备份数量是否大于$maxBackupCount
count=`ls -l -crt  $backupPath/*.sql | awk '{print $9 }' | wc -l`

if [ $count -gt $maxBackupCount ]
then
  #删除最早生成的备份，只保留maxBackupCount数量的备份
  rm $delfile
fi

