#!/bin/bash
#rundeck path
RundeckPath=/$HOME/scripts/rundeck
TemplatePath=$RundeckPath/template/feature
Date=`date +%Y_%m_%d_%m`

#run user
RunUser=`cat /etc/php/7.0/fpm/pool.d/www.conf|grep 'user ='|awk -F '=' '{print $2}'|sed 's/ //'`

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
MysqlDockerImage="mysql:dev.5.6.31"
MongoDockerImage="mongo:dev.3.2.8"


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
TWebPort="5566"
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
IsNormalBranch=`echo $ReleaseName |grep "/"`

[[ $IsNormalBranch == "" ]] && Branch=test
sBranchName=`echo $ReleaseName | awk -F"/" '{print $2}'`
[[ $sBranchName == "" ]] && sBranchName=$ReleaseName

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
if [[ -d /var/www/www.$Branch.$sBranchName.aysaas.com ]]; then
    rm -rf /var/www/www.$Branch.$sBranchName.aysaas.com
fi
cp -r $CodePath /var/www/www.$Branch.$sBranchName.aysaas.com
#chown -R $RunUser:$RunUser /var/www/www.$Branch.$sBranchName.aysaas.com
if [[ -d /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com ]]; then
    rm -rf /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com
fi
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
#git init
#git remote add origin git@e.coding.net:Safirst/AnYunProj.git
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

function ModifyConf () {
justModifyDB=$1

echo ""
echo "Modify config file ..."
DockerMysqlPort=`docker inspect -f '{{ (index (index .NetworkSettings.Ports "3306/tcp") 0).HostPort}}' $DockerMysqlName`
DockerMongoPort=`docker inspect -f '{{ (index (index .NetworkSettings.Ports "27017/tcp") 0).HostPort}}' $DockerMongoName`

if [[ $justModifyDB == "justModifyDB" ]]; then
    cd /var/www/www.$Branch.$sBranchName.aysaas.com
    TMongoPort=`ENV=development php -r "include 'bootstrap.php'; print( \Config('database.servers.mongodb.port'));"|awk -F ',' '{print $1}'`
    TMysqlPort=`ENV=development php -r "include 'bootstrap.php'; print( \Config('database.servers.default.port'));"|awk -F ',' '{print $1}'`
    sed -i "s/$TMysqlPort/$DockerMysqlPort/g" /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/database.php
    sed -i "s/$TMongoPort/$DockerMongoPort/" /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/database.php
    sed -i "s/database\.servers\.default\.port.*/database\.servers\.default\.port = $DockerMysqlPort/" /var/www/org.$Branch.$sBranchName.aysaas.com/conf/development.ini
else
    sed -i "s/$TBranchName/$sBranchName/" /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/app.php
    sed -i "s/$TBranch/$Branch/" /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/app.php
    #sed -i "s/$TBranchName/$DatabaseName/" /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/database.php
    sed -i "s/$TMysqlPort/$DockerMysqlPort/g" /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/database.php
    sed -i "s/$TMongoPort/$DockerMongoPort/" /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/database.php
    #sed -i "s/$TWebPort/$WebPort/" /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/app.php

    sed -i "s/$TBranch/$Branch/" /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com
    sed -i "s/$TBranchName/$sBranchName/" /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com
    #sed -i "s/$TWebPort/$WebPort/" /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com
    #cd /var/www/www.$Branch.$sBranchName.aysaas.com
    #if [ -e ./deploy/supervisor ] ;then 
    #  ./deploy/supervisor 
    #   sed  -i '/feature/d' /etc/supervisor/supervisord.conf
    #  cd -
    #fi
    #echo ""
    #echo "Modify config file is OK !"

    #####2017-07-27 更新队列配置文件，从base中获取最新的queue.php不再使用模板内的queue.php，默认开启多进程
    cp /var/www/www.$Branch.$sBranchName.aysaas.com/config/base/queue.php /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/queue.php
    sed -i "s/'multiProcess' => false/'multiProcess' => true/g" /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/queue.php

    cd /var/www/www.$Branch.$sBranchName.aysaas.com
    if [ -e ./deploy/supervisor ] ;then
      ./deploy/supervisor
       sed  -i '/feature/d' /etc/supervisor/supervisord.conf
      cd -
    fi
fi
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
 else
   echo "$DatabaseName is exists !"
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
	docker images $MysqlDockerImage|grep 'mysql' > /dev/null
	if [ ! $? -eq 0 ];then
		docker pull docker.aysaas.com/development/$MysqlDockerImage
		docker tag  docker.aysaas.com/development/$MysqlDockerImage $MysqlDockerImage
	fi
	docker ps -a|grep -w $DockerMysqlName > /dev/null 2>&1
	if [ ! $? -eq 0 ];then
	docker run -p 3306 --name $DockerMysqlName -d $MysqlDockerImage
	sleep 2
	echo "$DockerMysqlName has been created!"
	fi
}

function DockerMongo {
	docker images $MongoDockerImage|grep 'mongo' > /dev/null
	if [ ! $? -eq 0 ];then
		docker pull docker.aysaas.com/development/$MongoDockerImage
		docker tag docker.aysaas.com/development/$MongoDockerImage $MongoDockerImage
	fi
	docker ps -a|grep -w $DockerMongoName > /dev/null 2>&1
	if [ ! $? -eq 0 ];then
	docker run -p 27017 --name $DockerMongoName -d $MongoDockerImage
	sleep 2
	echo "$DockerMongoName has been created!"
	fi
}

function ReService {
echo ""
echo "Restart nginx ..."
service nginx reload
echo ""
echo "Restart nginx is OK !"
echo ""
echo "Restart supervisor..."
echo ""
service supervisor stop
sleep 60
service supervisor start
echo ""
[ $? -eq 0 ] && echo "Restart supervisor is OK!"
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
echo "$ReleaseName|development|/var/www/www.$Branch.$sBranchName.aysaas.com|aliyun|||" >> $RundeckPath/config/projinfo
cat $RundeckPath/config/projinfo | sort | uniq > $RundeckPath/config/_tmp.projinfo
mv $RundeckPath/config/_tmp.projinfo $RundeckPath/config/projinfo
}

function DelCode {
echo ""
local _Name=""
_Name=`cat /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/app.php | grep "application_name" | awk '{print $3}' | sed "s/'//g" | sed "s/,//g"`
echo "Delete code ..."
rm -rf /var/www/www.$Branch.$sBranchName.aysaas.com
rm -rf /etc/supervisor/conf.d/${_Name}_queue.conf
rm -rf /var/www/org.$Branch.$sBranchName.aysaas.com
echo ""
echo "Delete code is OK !"
}

function DelQueue {
echo ""
echo "Delete queue ..."
service supervisor stop
sleep 60
service supervisor start
echo "Delete queue is OK !"
}

function DelNginxConf {
echo ""
echo "Delete from nginx ..."
rm -rf /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com /etc/nginx/sites-enabled/www.$Branch.$sBranchName.aysaas.com
rm -rf /etc/nginx/sites-available/org.$Branch.$sBranchName.aysaas.com /etc/nginx/sites-enabled/org.$Branch.$sBranchName.aysaas.com
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
IsExit=`cat ${RundeckPath}/config/projinfo | grep -n "${ReleaseName}|"`
if [[ -n $IsExit ]]; then
    RowNum=`echo $IsExit | awk -F":" '{print $1}' | head -n 1`
    sed -i "${RowNum}d" ${RundeckPath}/config/projinfo
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

####拉取微服务
function PullOrg  {
        cd /var/www
        git clone git@e.coding.net:Safirst/org.git Orgservice
        cd Orgservice/application
        mkdir log
        chmod 777 -R log
        cp /root/scripts/rundeck/template/feature/production.ini /var/www/Orgservice/conf/development.ini
        cp -r /root/scripts/rundeck/template/feature/vendor /var/www/Orgservice/
        cp /root/scripts/rundeck/template/feature/org.feature.moban.aysaas.com /etc/nginx/sites-available/org.$Branch.$sBranchName.aysaas.com
        cp /var/www/www.$Branch.$sBranchName.aysaas.com/config/base/services.php /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/
        mv /var/www/Orgservice  /var/www/org.$Branch.$sBranchName.aysaas.com

        cd /var/www/www.$Branch.$sBranchName.aysaas.com
        MysqlName=`ENV=development php -r "include 'bootstrap.php'; print( \Config('database.servers.default.name'));"`
        MysqlHost=`ENV=development php -r "include 'bootstrap.php'; print( \Config('database.servers.default.host'));"`
        MysqlPort=`ENV=development php -r "include 'bootstrap.php'; print( \Config('database.servers.default.port'));"`
        MysqlUser=`ENV=development php -r "include 'bootstrap.php'; print( \Config('database.servers.default.user'));"`
        MysqlPass=`ENV=development php -r "include 'bootstrap.php'; print( \Config('database.servers.default.password'));"`
        MysqlDBName=`ENV=development php -r "include 'bootstrap.php'; print( \Config('database.servers.default.dbname'));"`

        AppName=`ENV=development php -r "include 'bootstrap.php'; print( \Config('app.application_name'));"`
        FileioName=`ENV=development php -r "include 'bootstrap.php'; print( \Config('app.fileio_domain'));"`
        StaticName=`ENV=development php -r "include 'bootstrap.php'; print( \Config('app.static_domain'));"`
        QueueHost=`ENV=development php -r "include 'bootstrap.php'; print( \Config('queue.host'));"`
        RedisHost=`ENV=development php -r "include 'bootstrap.php'; print( \Config('redis.servers.default'));"`
        RedisAuth=`ENV=development php -r "include 'bootstrap.php'; print( \Config('redis.servers.auth'));"`

        rnd=0
        i=7000
        while (($i <=8000))
        do
                ss -tln | grep $i
                if [ $? == 1 ];then
                        rnd=$i
                        echo $rnd
                        break
                fi
                i=$(($i+1))
        done
        WwwName='192.168.0.241:'$rnd

	sed -i "s/database\.servers\.default\.name.*/database\.servers\.default\.name = $MysqlName/" /var/www/org.$Branch.$sBranchName.aysaas.com/conf/development.ini
	sed -i "s/database\.servers\.default\.host.*/database\.servers\.default\.host = $MysqlHost/" /var/www/org.$Branch.$sBranchName.aysaas.com/conf/development.ini
	sed -i "s/database\.servers\.default\.port.*/database\.servers\.default\.port = $MysqlPort/" /var/www/org.$Branch.$sBranchName.aysaas.com/conf/development.ini
	sed -i "s/database\.servers\.default\.dbname.*/database\.servers\.default\.dbname = $MysqlDBName/" /var/www/org.$Branch.$sBranchName.aysaas.com/conf/development.ini
	sed -i "s/database\.servers\.default\.user.*/database\.servers\.default\.user = $MysqlUser/" /var/www/org.$Branch.$sBranchName.aysaas.com/conf/development.ini
	sed -i "s/database\.servers\.default\.password.*/database\.servers\.default\.password = $MysqlPass/" /var/www/org.$Branch.$sBranchName.aysaas.com/conf/development.ini

	sed -i "s/app\.application_name.*/app\.application_name = $AppName/" /var/www/org.$Branch.$sBranchName.aysaas.com/conf/development.ini
	sed -i "s/app\.fileio_domain.*/app\.fileio_domain = $FileioName/" /var/www/org.$Branch.$sBranchName.aysaas.com/conf/development.ini
	sed -i "s/app\.static_domain.*/app\.static_domain = $StaticName/" /var/www/org.$Branch.$sBranchName.aysaas.com/conf/development.ini
	sed -i "s/queue\.host.*/queue\.host = $QueueHost/" /var/www/org.$Branch.$sBranchName.aysaas.com/conf/development.ini
	sed -i "s/redis\.servers\.default.*/redis\.servers\.default = $RedisHost/" /var/www/org.$Branch.$sBranchName.aysaas.com/conf/development.ini
	sed -i "s/redis\.auth.*/redis\.auth = $RedisAuth/" /var/www/org.$Branch.$sBranchName.aysaas.com/conf/development.ini
	sed -i "s/app\.www_domain.*/app\.www_domain = $WwwName/" /var/www/org.$Branch.$sBranchName.aysaas.com/conf/development.ini
	sed -i "s/'domain.*/'domain' => '$WwwName',/" /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/services.php 
	sed -i "s/'local.*/'local' => '$WwwName'/" /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/services.php 

	
	sed -i "s/Port/$rnd/" /etc/nginx/sites-available/org.$Branch.$sBranchName.aysaas.com
	sed -i "s/org\.feature\.moban/org\.$Branch\.$sBranchName/" /etc/nginx/sites-available/org.$Branch.$sBranchName.aysaas.com
	
	ln -s /etc/nginx/sites-available/org.$Branch.$sBranchName.aysaas.com /etc/nginx/sites-enabled/
	nginx -s reload
	chown -R anyuan:anyuan /var/www/org.$Branch.$sBranchName.aysaas.com
	chown -R anyuan:anyuan /var/www/www.$Branch.$sBranchName.aysaas.com

        

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
    PullOrg
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
    DelQueue
    #DelDB
    #DelMongo
    DelDockerMysql
    DelDockerMongo
    DelInfo
    DelRedis
#    DelCrontab
    ReService
    OutPut del
   ;;
"updb")
    InPut "NoCheck"
    UpdateDB
    ;;
"flushdb")
   InPut "NoCheck"
   DelDockerMysql
   DelDockerMongo
   DockerMysql
   DockerMongo
   ModifyConf "justModifyDB" 
esac
