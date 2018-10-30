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
MongoHotfixSlave="dds-bp1a1e05a90b27b41.mongodb.rds.aliyuncs.com:3717"
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
      if [ $? -ne 0 ];then
      		mongorestore -u$MongoHotfixUser -p=$MongoHotfixPass -h$MongoHotfixSlave -d$MongoHotfixDB  --drop $BackUpDir/$CurrentDate/qycloud > /dev/null 2>&1
      		[ $? -eq 0 ] && echo "$CurrentDate qycloud salve mongo restore to hotfix ok !" >> /tmp/qyloud_mongo-restore-hotfix.log
      else 
      	echo "$CurrentDate qycloud mongo restore to hotfix ok !" >> /tmp/qyloud_mongo-restore-hotfix.log
      fi

####应用市场appstore恢复
MongoAppstoreUser=appstore
MongoAppstoreDB=appstore
MongoAppstorePass=wGAAmCappsotre
MongoAppstoreHost="dds-bp16991c7a5e4b6433330.mongodb.rds.aliyuncs.com:3717"
#MongoAppstoreSlave="dds-bp1a1e05a90b27b41.mongodb.rds.aliyuncs.com:3717"
MongoAppstoreHost="dds-bp16991c7a5e4b6433330.mongodb.rds.aliyuncs.com:3717"
MongoAppstoreAdminUser=root
MongoAppstoreAdminPass=sl*32LSL3ssdfANQPOE
      mongo --host $MongoAppstoreHost --username $MongoAppstoreAdminUser --password $MongoAppstoreAdminPass --authenticationDatabase admin <<EOF
use appstore
db.dropDatabase()
exit
EOF
      mongorestore -u$MongoAppstoreUser -p=$MongoAppstorePass -h$MongoAppstoreHost -d$MongoAppstoreDB  --drop $BackUpDir/$CurrentDate/appstore > /dev/null 2>&1
      if [ $? -ne 0 ];then
                mongorestore -u$MongoHotfixUser -p=$MongoHotfixPass -h$MongoHotfixSlave -d$MongoHotfixDB  --drop $BackUpDir/$CurrentDate/appstore > /dev/null 2>&1
                [ $? -eq 0 ] && echo "$CurrentDate appstore salve mongo restore to appstore ok !" >> /tmp/qyloud_mongo-restore-hotfix.log
      else
        echo "$CurrentDate appstore mongo restore to appstore ok !" >> /tmp/qyloud_mongo-restore-hotfix.log
      fi

####门户portal恢复
MongoPorUser=portal
MongoPorDB=portal
MongoPorPass=4gFKawwtd93portal
MongoPorHost="dds-bp16991c7a5e4b6433330.mongodb.rds.aliyuncs.com:3717"
#MongoPorSlave="dds-bp1a1e05a90b27b41.mongodb.rds.aliyuncs.com:3717"
MongoPorHost="dds-bp16991c7a5e4b6433330.mongodb.rds.aliyuncs.com:3717"
MongoPorAdminUser=root
MongoPorAdminPass=sl*32LSL3ssdfANQPOE
      mongo --host $MongoPorHost --username $MongoPorAdminUser --password $MongoPorAdminPass --authenticationDatabase admin <<EOF
use portal
db.dropDatabase()
exit
EOF
      mongorestore -u$MongoPorUser -p=$MongoPorPass -h$MongoPorHost -d$MongoPorDB  --drop $BackUpDir/$CurrentDate/portal > /dev/null 2>&1
      if [ $? -ne 0 ];then
                mongorestore -u$MongoPorUser -p=$MongoPorPass -h$MongoPorSlave -d$MongoPorDB  --drop $BackUpDir/$CurrentDate/portal > /dev/null 2>&1
                [ $? -eq 0 ] && echo "$CurrentDate portal salve mongo restore to portal ok !" >> /tmp/qyloud_mongo-restore-hotfix.log
      else
        echo "$CurrentDate portal mongo restore to portal ok !" >> /tmp/qyloud_mongo-restore-hotfix.log
      fi

if [ -d $BackUpDir/$CurrentDate ];then
	echo "$BackUpDir/$CurrentDate" >>/tmp/test.log
	#rm -rf $BackUpDir/$CurrentDate
fi
rm  /tmp/mongobackuptohotfix.pid
