#!/bin/bash
Op=$1
CurrentDate=`date +%Y-%m-%d`
BackUpDir="/home/anyuankeji/databases/mongo_backup"
MongoPreUser=pre
MongoPreDB=pre
MongoPrePass=wGAAmCjkskLq2RTD
MongoPreHost="dds-bp1a1e05a90b27b42.mongodb.rds.aliyuncs.com:3717"
MongoHost="dds-bp1a1e05a90b27b42.mongodb.rds.aliyuncs.com:3717"
MongoAdminUser=root
MongoAdminPass=DpMTcTltiqNbD4R4

function CreatePreBranch () {
BranchPath="/var/www/pre.qycloud.com.cn"
cd $BranchPath
git checkout .
git clean -f
git pull origin proj/qycloud
git pull origin release
git checkout proj/qycloud
git branch -D pre/qycloud
git push origin :pre/qycloud
git checkout -b pre/qycloud
git merge --no-ff --no-edit release
[ ! $? -eq 0 ] && echo "release merge to pre/qycloud conflict,please login pre server to solve it !" && exit 1 
git push origin pre/qycloud:pre/qycloud
git checkout proj/qycloud
}

function DropPreMongo () {
      mongo --host $MongoHost --username $MongoAdminUser --password $MongoAdminPass --authenticationDatabase admin <<EOF
use $MongoPreDB
db.dropDatabase()
exit
EOF
}

function InitPreService () {
#Create Mysql
/root/scripts/rundeck/run.sh createCloneDB pre
for ((i=1;i<=60;i++))
do
  /root/scripts/rundeck/run.sh cloneDBStatus pre|grep Running > /dev/null 2>&1
  [ $? -eq 0 ] && break
   sleep 1m
done
/root/scripts/rundeck/run.sh autoCloneDB pre
/root/scripts/rundeck/run.sh cleanUserChatToken pre 1

#Create Mongo
ls /tmp/mongobackuptopre.pid > /dev/null 2>&1
[ $? -eq 0 ] && exit 1
     touch /tmp/mongobackuptopre.pid
DropPreMongo
      mongorestore -u$MongoPreUser -p=$MongoPrePass -h$MongoPreHost -d$MongoPreDB  --drop $BackUpDir/$CurrentDate/qycloud > /dev/null 2>&1
      [ $? -eq 0 ] && echo "$CurrentDate qycloud mongo restore to pre ok !" >> /tmp/qyloud_mongo-restore-pre.log
      rm  /tmp/mongobackuptopre.pid

/root/scripts/rundeck/run.sh gco pre pre/qycloud
/root/scripts/rundeck/run.sh startwebsocket pre
ln -sf /etc/nginx/sites-available/pre.qycloud.com.cn /etc/nginx/sites-enabled
nginx -s reload

}

function DropPreService () {
DropPreMongo
/root/scripts/rundeck/run.sh stopwebsocket pre
/root/scripts/rundeck/run.sh deleteCloneDB pre
rm /etc/nginx/sites-enabled/pre.qycloud.com.cn
nginx -s reload
}

case $Op in 
  create_pre_branch)
  CreatePreBranch
  ;; 
  init_pre_service)
 InitPreService
  ;;
  drop_pre_service)
 DropPreService
esac
