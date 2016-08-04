#!/bin/bash

#0. 更新代码
codedir=/var/www/www.ceshi.integration.aysaas.com
branchname=integration
cd $codedir
git checkout .
git pull --rebase origin $branchname 

#1.数据库信息定义

mysql_host="127.0.0.1"
mysql_user="saas_kawawa"
mysql_passwd="hVxsR7VFYRKZsbNJ"
mysql_dbname="ceshiintegration"

mongo_host="127.0.0.1"
mongo_user="root"
mongo_passwd="root"
mongo_dbname="ceshiintegration"


#2.设定备份路径 并确保路径存在
mysql_dir="$USER/backup/mysql/"
mongo_dir="$USER/backup/mongodb/"

if [ ! -d $mysql_dir ]; then
    mkdir -p $mysql_dir
fi
if [ ! -d $mongo_dir ]; then
    mkdir -p $mongo_dir
fi

#3.备份数据
    #导出mongo
    echo '开始备份mongo'
    mongodump -h$mongo_host -u$mongo_user -p$mongo_passwd -d$mongo_dbname -o $mongo_dir
    echo '开始备份mysql'
    mysqldump -h$mysql_host -u$mysql_user -p$mysql_passwd  $mysql_dbname > $mysql_dir${mysql_dbname}.sql

#4.PostMan信息定义
createtime=`date +%Y-%m-%d-%H-%M`
currentmonth=`date +%Y-%m`
postman_json=/var/www/ApiTest/Json/ApiTest.json
postman_env=/var/www/ApiTest/Environment/initialization_environment.json
postman_report_createtime=/var/www/ApiTest/Report/$currentmonth/ApiTest-${createtime}.html

if [ ! -d /var/www/ApiTest/Report/$currentmonth ]; then
    mkdir -p /var/www/ApiTest/Report/$currentmonth
fi

newman -c $postman_json -e $postman_env -H $postman_report

#5.恢复数据

    #导入mongo
    echo '开始恢复mongo'
    mongorestore -h$mongo_host -u$mongo_user -p$mongo_passwd -d$mongo_dbname --drop ${mongo_dir}${mongo_dbname}
    #导入mysql
    echo '开始恢复mysql'
    mysql -h$mysql_host -u$mysql_user -p$mysql_passwd $mysql_dbname < $mysql_dir${mysql_dbname}.sql
