#!/bin/bash
CurrentDate=`date +%Y-%m-%d`
ls /tmp/mongobackuptohotfix.pid > /dev/null 2>&1
[ $? -eq 0 ] && exit 1
ProjPath="/var/www/hotfix.qycloud.com.cn"
cd $ProjPath
BackUpDir="/home/anyuankeji/databases/mongo_backup"
MongoHost1=`ENV=production php -r "include 'bootstrap.php'; print( \Config('database.servers.mongodb.host'));"|awk -F ',' '{print $1}'`
MongoHost2=`ENV=production php -r "include 'bootstrap.php'; print( \Config('database.servers.mongodb.host'));"|awk -F ',' '{print $2}'`
MongoUser=`ENV=production php -r "include 'bootstrap.php'; print( \Config('database.servers.mongodb.user'));"`
MongoPass=`ENV=production php -r "include 'bootstrap.php'; print( \Config('database.servers.mongodb.password'));"`
MongoDBName=`ENV=production php -r "include 'bootstrap.php'; print( \Config('database.servers.mongodb.dbname'));"`
     touch /tmp/mongobackuptohotfix.pid
for MongoHost in $MongoHost1 $MongoHost2
 do
    IsMaster=`mongo --host $MongoHost --authenticationDatabase $MongoDBName -u $MongoUser -p $MongoPass --eval "db.runCommand({"isMaster":true})"|grep "ismaster"|awk -F ":" '{print $2}'|sed  's/ //'|sed 's/,//'` 
    if [[ $IsMaster == "true" ]];then
     MasterMongoHost=$MongoHost
    fi	
 done
     mongo --host $MasterMongoHost  --username $MongoUser --password $MongoPass --authenticationDatabase $MongoDBName <<EOF
use hotfix
db.dropDatabase()
exit
EOF
#备份恢复到hotfix
   mongorestore --host $MasterMongoHost  --username $MongoUser --password $MongoPass --authenticationDatabase $MongoDBName --db $MongoDBName  --drop $BackUpDir/$CurrentDate/qycloud  > /dev/null 2>&1    
      echo "$CurrentDate qycloud mongo restore to $MongoDBName ok !"
      [ $? -eq 0 ] && echo "$CurrentDate qycloud mongo restore to $MongoDBName ok !" >> /tmp/qyloud_mongo-restore-hotfix.log
 rm /tmp/mongobackuptohotfix.pid
