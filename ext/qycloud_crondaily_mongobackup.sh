#!/bin/bash
BackUpDate=`date +%Y-%m-%d`
BackUpDir=/home/anyuankeji/databases/mongo_backup
MongoUser="qycloud"
MongoPass="4gFKawwtUBd93QmJ"
MongoHost="dds-bp1beb87fe210e942.mongodb.rds.aliyuncs.com"
MongoPort="3717"
MongoDbname="qycloud"
mongodump -u$MongoUser -p=$MongoPass -h$MongoHost:$MongoPort --excludeCollection system.profile  -d$MongoDbname -o $BackUpDir/$BackUpDate > /dev/null 2>&1
echo "$BackUpDate qycloud mongo backup ok !" 
echo "$BackUpDate qycloud mongo backup ok !" >> /tmp/qyloud_mongo-bak.log
echo  $BackUpDir
sleep 20
find $BackUpDir/* -type d -mtime +5 -exec rm -rf {} \;

