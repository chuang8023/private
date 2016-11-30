#!/bin/bash
#rundeck path
RundeckPath=/root/scripts/rundeck
TemplatePath=$RundeckPath/template/feature
Date=`date +%Y_%m_%d_%m`

#run user
RunUser=anyuan

# 运行前请检查以下模板是否存在、位置是否正确:
# 源码:$CodePath
# Nginx:$NginxConfPath
# 数据库:$DBPath
CodePath=/root/scripts/rundeck/template/feature/www.feature.templateRelease.aysaas.com
NginxConfPath=/root/scripts/rundeck/template/feature/www.feature.templateRelease.aysaas.com-nginx
DBPath=/root/scripts/rundeck/template/feature/template.sql

#Database info
SQLname="template.sql"
DBIP="localhost"
DBUser="root"
DBPasswd="saas"

#Mongo info
MongoAdminUser="admin"
MongoAdminPass="LBc8SQaA8zoJK1"
MongoNomalUser="feature"
MongoNomalPass="LBc8SQaA8zoJK1IWMUHDiSwN4"


#Web info
#WebPort="55555"

#Template info
TBranch="feature"
TBranchName="templateRelease"
TWebPort="55555"
TMysqlPort="3306"
TMongoPort="27017"

#######################################

Param1=$1
Param2=$2

function ConversionA2a () {
str=`echo $1 | tr '[A-Z]' '[a-z]'`
echo $str
}

function CheckTemplate {
if [[ ! -d $CodePath ]]; then
    echo ""
    echo "Template of Code is NOT exist !"
    exit 1
fi
if [[ ! -f $NginxConfPath ]]; then
    echo ""
    echo "Template of Nginx is NOT exist !"
    exit 1
fi
if [[ ! -f $DBPath ]]; then
    echo ""
    echo "Template of Mysql is NOT exist !"
    exit 1
fi
}

function InPut () {
_Param1=$1
ReleaseName=`echo $Param2 | awk 'gsub(/^ *| *$/,"")'`
if [[ $_Param1 != "NoCheck" ]]; then
    CheckTemplate
    cd $CodePath
    echo "Test branch name $ReleaseName ..."
    git fetch origin $ReleaseName:$ReleaseName 1>/dev/null
    if [[ $? != 0 ]]; then
        echo ""
        echo "Branch name is wrong or network  is not good , check branch name and try it again !"
        exit 1
    else
        echo ""
        echo "Test branch name $ReleaseName is OK !"
        git branch -D $ReleaseName 1>/dev/null 2>&1
        cd - 1>/dev/null 2>&1
    fi
fi
Branch=`echo $ReleaseName | awk -F"/" '{print $1}'`
sBranchName=`echo $ReleaseName | awk -F"/" '{print $2}'`

Branch=`ConversionA2a "$Branch"`
sBranchName=`ConversionA2a "$sBranchName"`

DatabaseName=${Branch}_${sBranchName}
DockerMysqlName=Mysql_$DatabaseName
DockerMongoName=Mongo_$DatabaseName
unset _Param1
}

function CopyTemplate {
echo ""
echo "Copy template to www.$Branch.$sBranchName.aysaas.com ..."
if [[ ! -d /var/www/www.$Branch.$sBranchName.aysaas.com ]]; then
    cp -r $CodePath /var/www/www.$Branch.$sBranchName.aysaas.com
else
    rm -rf /var/www/www.$Branch.$sBranchName.aysaas.com
    cp -r $CodePath /var/www/www.$Branch.$sBranchName.aysaas.com
fi
#chown -R $RunUser:$RunUser /var/www/www.$Branch.$sBranchName.aysaas.com
cp $NginxConfPath /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com
ln -sf /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com /etc/nginx/sites-enabled/
if [[ $? != 0 ]]; then
    echo ""
    echo "Copy template to www.$Branch.$sBranchName.aysaas.com is Fail !"
    exit 1
else
    echo ""
    echo "Copy template to www.$Branch.$sBranchName.aysaas.com is OK !"
fi
}

function PullBranch {
echo ""
echo "Pull branch $ReleaseName ..."
cd /var/www/www.$Branch.$sBranchName.aysaas.com
git fetch origin $ReleaseName:$ReleaseName 1>/dev/null
git checkout $ReleaseName 1>/dev/null
NoUsed=(`git branch | grep -v "*" | grep -v "$ReleaseName"`)
for (( i=0;i<${#NoUsed};i++ ))
do
    git branch -D ${NoUsed[i]} 1>/dev/null 2>&1
done
./script/vendor unpackaging
chmod -R 777 log upload
chown -R $RunUser:$RunUser /var/www/www.$Branch.$sBranchName.aysaas.com
cd - 1>/dev/null 2>&1
echo ""
echo "Pull branch $ReleaseName is OK !"
}

function ModifyConf {
echo ""
echo "Modify config file ..."
sed -i "s/$TBranchName/$sBranchName/" /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/app.php
sed -i "s/$TBranch/$Branch/" /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/app.php
#sed -i "s/$TBranchName/$DatabaseName/" /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/database.php
sed -i "s/$TMysqlPort/$DockerMysqlPort/" /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/database.php
sed -i "s/$TMongoPort/$DockerMongoPort/" /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/database.php
#sed -i "s/$TWebPort/$WebPort/" /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/app.php

sed -i "s/$TBranch/$Branch/" /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com
sed -i "s/$TBranchName/$sBranchName/" /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com
#sed -i "s/$TWebPort/$WebPort/" /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com
echo ""
echo "Modify config file is OK !"
}

function ManageDB {
DBIsExists=`mysql -h"$DBIP" -u"$DBUser" -p"$DBPasswd" -e "show databases like '$DatabaseName'"`
if [[ $? != 0 ]]; then
    echo ""
    echo "Database connect fail !"
    exit 1
fi
if [[ $DBIsExists == "" ]]; then
    echo ""
    echo "Create database $DatabaseName ..."
    mysql -h"$DBIP" -u"$DBUser" -p"$DBPasswd" -e "create database $DatabaseName"
    echo ""
    echo "Create database $DatabaseName is OK !"
    echo ""
    echo "Import database $DatabaseName ..."
    mysql -h"$DBIP" -u"$DBUser" -p"$DBPasswd" $DatabaseName < $DBPath
    echo ""
    echo "Import database $DatabaseName is OK !"
fi
}



function ManageMongo {
MongoIsExists=`mongo admin -u$MongoAdminUser -p$MongoAdminPass --eval "db.adminCommand('listDatabases')" |grep $DatabaseName`
if [[ $MongoIsExists == "" ]]; then
    echo ""
    echo "Create Mongo  $DatabaseName ..."
    mongo<<EOF 
use admin
db.auth("$MongoAdminUser","$MongoAdminPass")
use $DatabaseName
db.createUser(  
  {  
    user: "$MongoNomalUser",  
    pwd: "$MongoNomalPass",  
    roles: [ { role: "dbOwner", db: "$DatabaseName" } ]  
  }  
) 
exit
EOF
    echo ""
    echo "Create Mongo $DatabaseName is OK !"
    echo ""
    echo "Convert data to Mongo  $DatabaseName ..."
    cd /var/www/www.$Branch.$sBranchName.aysaas.com
    ./vendor/phing/phing/bin/phing convert_mongodb << EOF 

n
EOF
    echo ""
    echo "Convert data to Mongo $DatabaseName is OK !"
else 
    echo "Mongo $DatabaseName is Exists"
    exit 1
 fi
}

function DockerMysql {
docker run -p 3306 --name $DockerMysqlName -d mysql:dev.5.6.31
DockerMysqlPort=`docker inspect -f '{{ (index (index .NetworkSettings.Ports "3306/tcp") 0).HostPort}}' $DockerMysqlName`
}

function DockerMongo {
docker run -p 27017 --name $DockerMongoName -d mongo:dev.3.2.8
DockerMongoPort=`docker inspect -f '{{ (index (index .NetworkSettings.Ports "27017/tcp") 0).HostPort}}' $DockerMongoName`
}

function ReService {
echo ""
echo "Restart nginx ..."
service nginx reload
echo ""
echo "Restart nginx is OK !"
}

function CreateCrontab {
echo ""
echo "Create crontab ..."
cd /var/www/www.$Branch.$sBranchName.aysaas.com
sudo -u $RunUser /usr/bin/env TERM=xterm ./deploy/crontab
cd - 1>/dev/null 2>&1
echo ""
echo "Create crontab is OK !"
}

function EchoFeatureInfo {
echo "$ReleaseName|development|/var/www/www.$Branch.$sBranchName.aysaas.com|aliyun" >> $RundeckPath/config/projinfo
cat $RundeckPath/config/projinfo | sort | uniq > $RundeckPath/config/_tmp.projinfo
mv $RundeckPath/config/_tmp.projinfo $RundeckPath/config/projinfo
}

function DelCode {
echo ""
echo "Delete code ..."
rm -rf /var/www/www.$Branch.$sBranchName.aysaas.com
echo ""
echo "Delete code is OK !"
}

function DelNginxConf {
echo ""
echo "Delete from nginx ..."
rm -rf /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com /etc/nginx/sites-enabled/www.$Branch.$sBranchName.aysaas.com
echo ""
echo "Delete from nginx is OK !"
}

function DelDB {
echo ""
echo "Delete from database ..."
mysql -h"$DBIP" -u"$DBUser" -p"$DBPasswd" -e "drop database $DatabaseName"
echo ""
echo "Delete from database is OK !"
}

function DelMongo {
echo ""
echo "Delete from mongo ..."
mongo<<EOF
use admin
db.auth("$MongoAdminUser","$MongoAdminPass")
use $DatabaseName
db.dropUser("$MongoNomalUser")
db.dropDatabase()
exit
EOF
}

function DelDockerMysql {
docker rm -f $DockerMysqlName
echo ""
echo "Delete DockerMysql is ok !"
}

function DelDockerMongo {
docker rm -f $DockerMongoName
echo ""
echo "Delete DockerMongo is ok !"
}

function DelInfo {
echo ""
echo "Delete project info"
IsExit=`cat $RundeckPath/config/projinfo | grep -n "$ReleaseName|development|/var/www/www.$Branch.$sBranchName.aysaas.com|aliyun"`
if [[ -n $IsExit ]]; then
    RowNum=`cat $RundeckPath/config/projinfo | grep -n "$ReleaseName|development|/var/www/www.$Branch.$sBranchName.aysaas.com|aliyun" | awk -F":" '{print $1}' | head -n 1`
    sed -i "${RowNum}d" $RundeckPath/config/projinfo
fi
echo ""
echo "Delete project info is OK !"
}

function DelRedis {
echo ""
echo "Delete redis ..."
for ((RedisPort=6379;RedisPort<=6382;RedisPort++))
do 
redis-cli -p $RedisPort keys "AYSaaS-$sBranchName*" | xargs redis-cli del >> /dev/null
done
echo "Delete project redis is OK !"
}

function DelCrontab {
echo ""
echo "Delete crontab ..."
sed -i '/^.*'$sBranchName'.*$/d' /var/spool/cron/crontabs/$RunUser
echo "Delete project crontab is OK !"
}


function OutPut () {
_Param1=$1
case $_Param1 in
"deploy")
echo ""
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "The URL is http://www.$Branch.$sBranchName.aysaas.com:$TWebPort"
echo ""
echo ""
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
;;
"del")
echo ""
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "       Delete $ReleaseName from 192.168.0.223 is OK !"
echo "       The branch $ReleaseName is still in Coding.net"
echo ""
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
;;
esac
unset _Param1
}

function UpdateDB   {
   echo "Start to update template db.."
   $RundeckPath/run.sh update feature/updatetemplatedb
   cd $TemplatePath
   tar -zcpf template.sql.bak.$Date.tar.gz template.sql
   mv template.sql.bak.$Date.tar.gz templdate_old
   mysqldump -uroot -psaas feature_updatetemplatedb > $TemplatePath/template.sql
   [ $? -eq 0 ] && echo "Update template db has been finished !"
}

##############################################

case $Param1 in
"deploy")
    InPut
    CopyTemplate
    PullBranch
    DockerMysql
    DockerMongo
    ModifyConf
    #ManageDB
    #ManageMongo
    ReService
    CreateCrontab
    EchoFeatureInfo
    ;;
"echo")
    InPut NoCheck
    OutPut deploy
    ;;
"delete")
    InPut "NoCheck"
    DelCode
    DelNginxConf
    #DelDB
    #DelMongo
    DelDockerMysql
    DelDockerMongo
    DelInfo
    DelRedis
    DelCrontab
    ReService
    OutPut del
   ;;
"updb")
    InPut "NoCheck"
    UpdateDB
esac
