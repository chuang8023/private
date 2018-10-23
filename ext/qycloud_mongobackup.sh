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

###备份appstore
MongoAppUser="appstore"
MongoAppPass="4gFKawwtappsotre"
MongoAppHost="dds-bp191bca846221141.mongodb.rds.aliyuncs.com"
MongoAppPort="3717"
MongoAppDbname="appstore"
mongodump -u$MongoAppUser -p=$MongoAppPass -h$MongoAppHost:$MongoAppPort --excludeCollection system.profile  -d$MongoAppDbname -o $BackUpDir/$BackUpDate > /dev/null 2>&1
echo "$BackUpDate appstore mongo backup ok !" 
echo "$BackUpDate appstore mongo backup ok !" >> /tmp/qyloud_mongo-bak.log

###备份portal
MongoPorUser="portal"
MongoPorPass="4gFKawwtd93portal"
MongoPorHost="dds-bp191bca846221141.mongodb.rds.aliyuncs.com"
MongoPorPort="3717"
MongoPorDbname="portal"
mongodump -u$MongoPorUser -p=$MongoPorPass -h$MongoPorHost:$MongoPorPort --excludeCollection system.profile  -d$MongoPorDbname -o $BackUpDir/$BackUpDate > /dev/null 2>&1
echo "$BackUpDate portal mongo backup ok !" 
echo "$BackUpDate portal mongo backup ok !" >> /tmp/qyloud_mongo-bak.log

[ -d $BackUpDir ] && find $BackUpDir/* -type d -mtime +1 -exec rm -rf {} \;
