#!/bin/bash
function StartPostMan () {
#只限feature合并进入integration,触发运行post-man
SaaSRepertoryPath="$HOME/saas"
cd $SaaSRepertoryPath
git checkout integration
git log -n 1 --name-only |grep  "feature" > /dev/null 2>&1
[ ! $? -eq 0 ] && exit 1
#0. 更新代码、锁判断、加锁
/root/scripts/rundeck/run.sh update initialization
/root/scripts/rundeck/run.sh update integration
[ -e /tmp/postman.sock ] && exit 1
touch /tmp/postman.sock
#1.数据库信息定义
mysql_host="127.0.0.1"
mysql_user="saas_kawawa"
mysql_passwd="hVxsR7VFYRKZsbNJ"
mysql_dbname="ceshiintegration"

#2.设定备份路径 并确保路径存在
mysql_dir="$HOME/backup/mysql/"

if [ ! -d $mysql_dir ]; then
    mkdir -p $mysql_dir
fi

#3.备份数据
    echo '开始备份mysql'
    mysqldump -h$mysql_host -u$mysql_user -p$mysql_passwd  $mysql_dbname > $mysql_dir${mysql_dbname}.sql

#4.PostMan信息定义
createtime=`date +%Y-%m-%d-%H-%M`
currentmonth=`date +%Y-%m`
postman_notice_email="472173257@qq.com"
postman_json=/var/www/ApiTest/Json/ApiTest.json
postman_env=/var/www/ApiTest/Environment/initialization_environment.json
postman_report=/var/www/ApiTest/Report/$currentmonth/ApiTest-${createtime}.html

if [ ! -d /var/www/ApiTest/Report/$currentmonth ]; then
    mkdir -p /var/www/ApiTest/Report/$currentmonth
fi

newman run $postman_json  --environment $postman_env --reporters html --reporter-html-export $postman_report 

  echo "${createtime} : integration's postman test has finished,please see the report !" | heirloom-mailx -s "integration postman auto test results" -a "$postman_report"  $postman_notice_email

#5.恢复数据

    #恢复mongo
    echo '开始恢复mongo'
   /root/scripts/rundeck/run.sh convert_mongo integration
    #恢复mysql
    echo '开始恢复mysql'
    mysql -h$mysql_host -u$mysql_user -p$mysql_passwd $mysql_dbname < $mysql_dir${mysql_dbname}.sql
   #重建redis
   /root/scripts/rundeck/run.sh rebuild_to_redis integration all
#6.解锁
rm /tmp/postman.sock
}
