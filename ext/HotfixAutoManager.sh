#!/bin/bash
#Mysql Auto Manager
/root/scripts/rundeck/run.sh stopwebsocket hotfix
/root/scripts/rundeck/run.sh deleteTempDB hotfix
sleep 5m
/root/scripts/rundeck/run.sh createTempDB hotfix
for ((i=1;i<=60;i++))
do
  /root/scripts/rundeck/run.sh tempDBStatus hotfix|grep Running > /dev/null 2>&1
  [ $? -eq 0 ] && break
   sleep 1m
done
/root/scripts/rundeck/run.sh autoTempDB hotfix
/root/scripts/rundeck/run.sh restartResque hotfix
/root/scripts/rundeck/run.sh startwebsocket hotfix
/root/scripts/rundeck/run.sh cleanUserChatToken hotfix 1
#Mongo Auto Manager
CurrentDate=`date +%Y-%m-%d`
ls /tmp/mongobackuptohotfix.pid > /dev/null
[ $? -eq 0 ] && exit 1
BackUpDir="/home/anyuankeji/databases/mongo_backup"
MongoHotfixUser=hotfix
MongoHotfixDB=hotfix
MongoHotfixPass=wGAAmCjkskLq2RTD
MongoHotfixHost="dds-bp1a1e05a90b27b42.mongodb.rds.aliyuncs.com:3717"
MongoHost="dds-bp1a1e05a90b27b42.mongodb.rds.aliyuncs.com:3717"
MongoAdminUser=root
MongoAdminPass=DpMTcTltiqNbD4R4
     touch /tmp/mongobackuptohotfix.pid
      mongo --host $MongoHost --username $MongoAdminUser --password $MongoAdminPass --authenticationDatabase admin <<EOF
use hotfix
db.dropDatabase()
exit
EOF
      mongorestore -u$MongoHotfixUser -p=$MongoHotfixPass -h$MongoHotfixHost -d$MongoHotfixDB  --drop $BackUpDir/$CurrentDate/qycloud > /dev/null 2>&1
      [ $? -eq 0 ] && echo "$CurrentDate qycloud mongo restore to hotfix ok !" >> /tmp/qyloud_mongo-restore-hotfix.log
      rm  /tmp/mongobackuptohotfix.pid
