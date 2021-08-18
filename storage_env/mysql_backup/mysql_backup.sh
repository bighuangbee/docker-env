#!/bin/sh

contrainerName=mysql_master #执行备份任务的mysql容器
dbuser=root
dbpasswd=123456
dbname=hidrone
dbhost=172.16.0.12 #备份的目标数据库地址
dbport=3306
filename=$(date +%Y%m%d%H%M).sql
backupPath="/Users/bighuangbee/mysql_backup/" #宿主机目录

maxBackupCount=30 #保存备份x天数据

#如果文件夹不存在则创建
if [ ! -d $backupPath ]; then
  mkdir -p $backupPath;
fi

#shell无法使用用户环境变量，命令必须使用绝对路径
#mac: /usr/local/bin/docker
#linux: /usr/bin/docker

# mysqldump --opt --single-transaction --master-data=2 -R -h127.0.0.1 -P3306 -uroot -phiDronedb2020. hidrone > /opt/202108172012.sql
/usr/local/bin/docker exec -i $contrainerName /usr/bin/mysqldump --opt --single-transaction --master-data=2 -R -h$dbhost -P$dbport -u$dbuser -p$dbpasswd $dbname > $backupPath$filename


#找出需要删除的备份
delfile=`ls -l -crt  $backupPath/*.sql | awk '{print $9 }' | head -1`

#判断现在的备份数量是否大于$maxBackupCount
count=`ls -l -crt  $backupPath/*.sql | awk '{print $9 }' | wc -l`

#删除最早生成的备份，只保留maxBackupCount数量的备份
if [ $count -gt $maxBackupCount ]
then
  rm $delfile
fi

