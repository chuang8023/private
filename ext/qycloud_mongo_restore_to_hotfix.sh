#!/bin/bash
CurrentDate=`date +%Y-%m-%d`
ls /tmp/mongobackuptohotfix.pid > /dev/null
[ $? -eq 0 ] && exit 1
BackUpDir="/home/anyuankeji/databases/mongo_backup"
MongoHost=dds-bp1a1e05a90b27b42.mongodb.rds.aliyuncs.com
MongoPort=3717
MongoAdminUser=root
MongoAdminPass=DpMTcTltiqNbD4R4
     touch /tmp/mongobackuptohotfix.pid
     mongo --host $MongoHost:$MongoPort  --username $MongoAdminUser --password $MongoAdminPass --authenticationDatabase admin <<EOF
use hotfix
db.dropDatabase()
exit
EOF
#备份恢复到hotfix
   mongorestore --host $MongoHost:$MongoPort  --username $MongoAdminUser --password $MongoAdminPass --authenticationDatabase admin --db hotfix  --drop $BackUpDir/$CurrentDate/qycloud      
      [ $? -eq 0 ] && echo "$CurrentDate qycloud mongo restore to hotfix ok !" >> /tmp/qyloud_mongo-restore-hotfix.log
 rm /tmp/mongobackuptohotfix.pid
