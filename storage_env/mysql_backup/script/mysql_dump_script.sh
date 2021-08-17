#!/bin/bash

#保存备份x天数据
number=60
#备份保存路径
backup_dir=/data/mysql_backup/
#日期
dd=`date +%Y%m%d%H%M`
#备份工具
tool=mysqldump
dbuser=root
dbpasswd=hiDronedb2020.
dbname=hidrone
dbhost=172.0.0.1
dbport=23306

echo $dbname;

#如果文件夹不存在则创建
if [ ! -d $backup_dir ];
then
    mkdir -p $backup_dir;
fi

#测试  mysqldump  --opt --single-transaction --master-data=2 -R -h 172.17.0.1 -P 3308 -uroot -p123456 hidrone > /root/mysqlbackup/11.sql
$tool --column-statistics=0 --opt --single-transaction --master-data=2 -R -h$dbhost -P $dbport -u $dbuser -p$dbpasswd  $dbname > $backup_dir/$dbname-$dd.sql

#写创建备份日志
echo "create $backup_dir/$dbname-$dd.dupm" >> $backup_dir/log.txt

#找出需要删除的备份
delfile=`ls -l -crt  $backup_dir/*.sql | awk '{print $9 }' | head -1`

#判断现在的备份数量是否大于$number
count=`ls -l -crt  $backup_dir/*.sql | awk '{print $9 }' | wc -l`

if [ $count -gt $number ]
then
  #删除最早生成的备份，只保留number数量的备份
  rm $delfile
  #写删除文件日志
  echo "delete $delfile" >> $backup_dir/log.txt
fi
