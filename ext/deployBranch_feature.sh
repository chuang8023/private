#!/bin/bash

cd `dirname $0`
. ../config/rundeck.cf

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
OrgCodePath=/root/scripts/rundeck/template/feature/org
NodeCodePath=/root/scripts/rundeck/template/feature/node



####saas标签&&&org标签
TigSaaS=saas
TigOrg=org

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

#Template info
TBranch="feature"
TBranchName="templateRelease"
TWebPort="templeateWebPort"
TPhpPort="templatePhpPort"

#read from rundeck.cf
#TWebPort="55555"

TMysqlPort="3306"
TMongoPort="27017"

#######################################

Param1=$1
Param2=$2
Param3=$3
Param4=$4

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
#if [[ ! -f $DBPath ]]; then
#    echo ""
#    echo "Template of Mysql is NOT exist !"
#    exit 1
#fi
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

function RND() {
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
return $rnd

}


#######	NODE部署&&配置
#######	@author:346619752@qq.com
####### @date: 2017-11-16
function NodeRelated () {

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


}

function PullNode () {
echo ""
echo "$NodeBN pulling the new node code ..."
cd $NodePath
git pull  --rebase origin $NodeBN:$NodeBN 1>/dev/null 2>/tmp/rundeck_node_errinfo
if [[ $? == 0 ]];then
	find . -user root -exec chown $runuser:$runuser {} \;
	echo ""
	echo "$NodeBN pull the new node code is OK !"
	cd - 1>/dev/null 2>&1
else
	echo ""
	echo "$NodeBN pull the new node code is Fail !"
	echo "---------------------------------------------"
	echo "请联系运维解决！！"  
	exit 1
	
fi
}

function BuildNode () {
echo ""
echo "$NodeBN build the  node code ..."
cd $NodePath
#if [[ $SHELL == "/bin/zsh" ]];then
#  cat ~/.zshrc|grep NODE_ENV
#  if [[ $? -ne 0 ]] ;then
#  echo 'export NODE_ENV="production"' >> ~/.zshrc
#  source ~/.zshrc
#  fi
#fi
#if [[ $SHELL == "/bin/bash" ]];then
#  cat ~/.bashrc|grep NODE_ENV
#  if [[ $? -ne 0 ]] ;then
#  echo 'export NODE_ENV="production"' >> ~/.bashrc
#  source ~/.bashrc
#  fi
#fi
npm i >/dev/null 2>&1
npm install canvas >/dev/null 2>&1
npm run static 1>/dev/null 2>/tmp/rundeck_code_errinfo
if [[ $? == 0 ]]; then
find . -user root -exec chown $runuser:$runuser {} \;
echo ""
echo "$NodeBN build  node code is OK !"
else
    echo ""
    echo "$NodeBN build node code is Fail !"
    echo "---------------------------------------------"
    cat /tmp/rundeck_code_errinfo | grep "ERR"
    if [ $? -eq 0 ];then
    	npm config set registry https://registry.npm.taobao.org
        which cnpm > /dev/null 2>&1
        [ $? -eq 1 ] && echo "install cnpm" && npm install -g cnpm --registry=https://registry.npm.taobao.org
        echo "update node modules...."
        NODE_ENV="development" cnpm i
	npm i >/dev/null 2>&1
        npm install canvas >/dev/null 2>&1
	[ $? -eq 0 ] && npm run static 1>/dev/null 2>/tmp/rundeck_code_errinfo
	echo "$NodeBN build  node code is OK !"
	find . -user root -exec chown $runuser:$runuser {} \;
    else
        echo ""
        echo "请联系运维解决！！"  
        exit 1
    fi

fi
pm2 start app.js --name node_$sBranchName
}
 
function RestartPm2 () {
echo ""
echo "Restart pm2 ..."
cd $NodePath
pm2 restart node_$sBranchName 1>/dev/null 2>/tmp/rundeck_code_errinfo
if [[ $? == 0 ]]; then
    echo ""
    echo " restart pm2  is OK !"
    cd - 1>/dev/null 2>&1
else
    echo ""
    echo "restart pm2 is Fail !"
    echo "---------------------------------------------"
    cat /tmp/rundeck_code_errinfo
    exit 1
fi
}


function NginxPort() {
i=6000
Port=0
cat /etc/nginx/nginx.conf | grep 127.0.0.1 | awk -F":" '{print $2}' |awk -F";" '{print $1}' | grep -v "LISTEN" >/tmp/port.log
num=`cat /tmp/port.log | wc -l`
while (($i <=8000))
do
        ss -tln | grep $i >> /dev/null
        if [ $? -eq 1 ];then
                for j in `cat /tmp/port.log`
                do
                        if [ $i == $j ];then
                                flag=1
                                break
                        else
                                flag=0
                        fi
                done
        if [ $flag == 0 ];then
                Port=$i
                echo $Port
                break
        fi
        fi
        i=$(($i+10))
done
return $Port
}



####### NODE部署&&配置
####### @author:346619752@qq.com
####### @date: 2017-11-16
function DeployNode {
echo "################开始Node部署#########################"
NodeBN=`echo $Param4 | awk 'gsub(/^ *| *$/,"")'`
NodeBranch=`echo $NodeBN | awk -F"/" '{print $1}'`
NodeName=`echo $NodeBN | awk -F"/" '{print $2}'`
if [ ! $NodeName ];then
        NodeName=$NodeBranch
fi

##拉取代码、配置文件
cp -r  $NodeCodePath /var/www/Node-$sBranchName
NodePath=/var/www/Node-$sBranchName
cd $NodePath
git pull --rebase origin $NodeName:$NodeName

######修改node-development.js
NodePort=`NginxPort`
sed -i "s/port:.*/port: $NodePort,/" /var/www/Node-$sBranchName/config/development.js
sed -i "s/api:.*/api: 'http:\/\/www.$Branch.$sBranchName.aysaas.com:55555',/" /var/www/Node-$sBranchName/config/development.js
sed -i "s/static:.*/static: 'http:\/\/nodestatic.$Branch.$sBranchName.aysaas.com:55555',/" /var/www/Node-$sBranchName/config/development.js
sed -i "s/fileio:.*/fileio: 'http:\/\/fileio.$Branch.$sBranchName.aysaas.com:55555',/" /var/www/Node-$sBranchName/config/development.js
sed -i "s/port:.*/port: $NodePort,/" /var/www/Node-$sBranchName/config/production.js
sed -i "s/api:.*/api: 'http:\/\/www.$Branch.$sBranchName.aysaas.com:55555',/" /var/www/Node-$sBranchName/config/production.js
sed -i "s/static:.*/static: 'http:\/\/nodestatic.$Branch.$sBranchName.aysaas.com:55555',/" /var/www/Node-$sBranchName/config/production.js
sed -i "s/fileio:.*/fileio: 'http:\/\/fileio.$Branch.$sBranchName.aysaas.com:55555',/" /var/www/Node-$sBranchName/config/production.js

##修改node-nginx
sed -i "s/Node-SaaS/Node-$sBranchName/g" /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com
sed -i "s/nodetest/node_$sBranchName/g" /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com
sleep 10
nginx -t
nginx -s reload

##修改node-nginx.conf
sed -i "/^http.*/a\upstream node_$sBranchName {\n    server 127.0.0.1:$NodePort;\n}" /etc/nginx/nginx.conf

#PullNode
BuildNode
RestartPm2
}

########删除node
function DelNode {
if [ -d /var/www/Node-$sBranchName ];then
        echo "代码目录存在，可以删除"
	rm -rf /var/www/Node-$sBranchName
fi

sed -i "/upstream node_$sBranchName /,+2d" /etc/nginx/nginx.conf
if [ $? == 0 ];then
	echo "删除nginx.conf配置成功！"
fi
nginx -t
nginx -s reload

}


function CopyTemplate {
echo ""
echo "Copy template to www.$Branch.$sBranchName.aysaas.com ..."
if [[ -d /var/www/www.$Branch.$sBranchName.aysaas.com ]]; then
    rm -rf /var/www/www.$Branch.$sBranchName.aysaas.com
fi

if [[ ! -d /var/www/www.$Branch.$sBranchName.aysaas.com ]]; then
    mkdir -p /var/www/www.$Branch.$sBranchName.aysaas.com
    [ $? -eq 0 ] && echo "创建目录saas成功"
fi

cp -r $CodePath /var/www/www.$Branch.$sBranchName.aysaas.com/$TigSaaS

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
cd /var/www/www.$Branch.$sBranchName.aysaas.com/$TigSaaS
git fetch origin $ReleaseName:$ReleaseName 1>/dev/null
git checkout $ReleaseName 1>/dev/null
NoUsed=(`git branch | grep -v "*" | grep -v "$ReleaseName"`)
for (( i=0;i<${#NoUsed};i++ ))
do
    git branch -D ${NoUsed[i]} 1>/dev/null 2>&1
done
/home/anyuan/bin/composer.phar config -g repo.packagist composer https://packagist.phpcomposer.com >/dev/null 2>&1
/home/anyuan/bin/composer.phar update >/dev/null 2>&1
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
    cd /var/www/www.$Branch.$sBranchName.aysaas.com/$TigSaaS
    #TMongoPort=`ENV=development php -r "include 'bootstrap.php'; print( \Config('database.servers.mongodb.port'));"|awk -F ',' '{print $1}'`
    #TMysqlPort=`ENV=development php -r "include 'bootstrap.php'; print( \Config('database.servers.default.port'));"|awk -F ',' '{print $1}'`

    TMongoPort=`cat config/development/database.yml | grep mongodb -A 8 | grep port |awk '{print $2}'`
    TMysqlPort=`cat config/development/database.yml | grep default -A 8 | grep port |awk '{print $2}'`
    cd /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg
    OrgMysqlPort=`cat conf/development.yml | grep database -A 8 | grep port |awk '{print $2}'`
    OrgMongoPort=`cat conf/development.yml | grep mongodb -A 8 | grep port |awk '{print $2}'`
    sed -i "s/$TMysqlPort/$DockerMysqlPort/g" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigSaaS/config/development/database.yml
    sed -i "s/$TMongoPort/$DockerMongoPort/" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigSaaS/config/development/database.yml
    sed -i "s/$OrgMysqlPort/$DockerMysqlPort/" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg/conf/development.yml
    sed -i "s/$OrgMongoPort/$DockerMongoPort/" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg/conf/development.yml
else
    sed -i "s/$TBranchName/$sBranchName/" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigSaaS/config/development/services.yml
    sed -i "s/$TBranch/$Branch/" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigSaaS/config/development/services.yml
    sed -i "s/$TMysqlPort/$DockerMysqlPort/g" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigSaaS/config/development/database.yml
    sed -i "s/$TMongoPort/$DockerMongoPort/" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigSaaS/config/development/database.yml

    sed -i "s/$TWebPort/$webPort/g" /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com
    sed -i "s/$TPhpPort/$phpPort/g" /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com
    sed -i "s/$TBranch/$Branch/g" /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com
    sed -i "s/$TBranchName/$sBranchName/g" /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com

    sed -i "s/application_name: AYSaaS-master/application_name: AYSaaS-$sBranchName/g" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigSaaS/config/development/app.yml

    #####2017-07-27 更新队列配置文件，从base中获取最新的queue.php不再使用模板内的queue.php，默认开启多进程
    cp /var/www/www.$Branch.$sBranchName.aysaas.com/$TigSaaS/config/base/queue.yml /var/www/www.$Branch.$sBranchName.aysaas.com/$TigSaaS/config/development/queue.yml
    #sed -i "s/multiProcess: false/multiProcess: true/g" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigSaaS/config/development/queue.yml

    cd /var/www/www.$Branch.$sBranchName.aysaas.com/$TigSaaS
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
    cd /var/www/www.$Branch.$sBranchName.aysaas.com/$TigSaaS
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
cd /var/www/www.$Branch.$sBranchName.aysaas.com/$TigSaaS
sudo -u $RunUser /usr/bin/env TERM=xterm ./deploy/crontab
cd - 1>/dev/null 2>&1
echo ""
echo "Create crontab is OK !"
}

function EchoFeatureInfo {
echo "$ReleaseName|development|/var/www/www.$Branch.$sBranchName.aysaas.com/$TigSaaS|aliyun|/var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg||/var/www/Node-$sBranchName" >> $RundeckPath/config/projinfo
cat $RundeckPath/config/projinfo | sort | uniq > $RundeckPath/config/_tmp.projinfo
mv $RundeckPath/config/_tmp.projinfo $RundeckPath/config/projinfo
}

function DelCode {
echo ""
local _Name=""
_Name=`cat /var/www/www.$Branch.$sBranchName.aysaas.com/$TigSaaS/config/development/app.yml | grep "application_name" | awk '{print $2}' | sed "s/'//g" | sed "s/,//g"`
echo "Delete code ..."
rm -rf /var/www/www.$Branch.$sBranchName.aysaas.com
rm -rf /etc/supervisor/conf.d/${_Name}_queue.conf
echo ""
echo "Delete code is OK !"
}

#function DelQueue {
#echo ""
#echo "Delete queue ..."
#service supervisor stop
#sleep 60
#service supervisor start
#echo "Delete queue is OK !"
#}

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

function cleanDockerNetwork () {
dockerName=$1
networkID=`docker network ls  | grep bridge | awk '{print $1}'`
docker network disconnect -f $networkID $dockerName
}

function DelDockerMysql {
docker rm -f $DockerMysqlName
cleanDockerNetwork $DockerMysqlName
echo ""
echo "Delete DockerMysql is ok !"
}

function DelDockerMongo {
docker rm -f $DockerMongoName
cleanDockerNetwork $DockerMongoName
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
function DelDns {
	echo "$Branch.$sBranchName" > /root/deldns.log
	scp /root/deldns.log root@192.168.0.122:/root
	ssh -l root 192.168.0.122 "bash -x deldns.sh"

}


function OutPut () {
_Param1=$1
case $_Param1 in
"deploy")
echo ""
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "The URL is http://www.$Branch.$sBranchName.aysaas.com:$webPort"
echo ""
echo ""
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
;;
"del")
echo ""
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "       Delete $ReleaseName from $ipAddress is OK !"
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
	echo "##################开始部署微服务org###################"
	OrgBranch=$1

        cp -r $OrgCodePath /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg
	cd /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg
 	git pull --rebase origin $OrgBranch:$OrgBranch
        cd /var/www/www.$Branch.$sBranchName.aysaas.com/$TigSaaS
        MysqlName=`ENV=development php -r "include 'bootstrap.php'; print( \Config('database.servers.default.name'));"`
        MysqlHost=`ENV=development php -r "include 'bootstrap.php'; print( \Config('database.servers.default.host'));"`
        MysqlPort=`ENV=development php -r "include 'bootstrap.php'; print( \Config('database.servers.default.port'));"`
        MysqlUser=`ENV=development php -r "include 'bootstrap.php'; print( \Config('database.servers.default.user'));"`
        MysqlPass=`ENV=development php -r "include 'bootstrap.php'; print( \Config('database.servers.default.password'));"`
        MysqlDBName=`ENV=development php -r "include 'bootstrap.php'; print( \Config('database.servers.default.dbname'));"`

        MongoName=`ENV=development php -r "include 'bootstrap.php'; print( \Config('database.servers.mongodb.name'));"`
        MongoHost=`ENV=development php -r "include 'bootstrap.php'; print( \Config('database.servers.mongodb.host'));"`
        MongoPort=`ENV=development php -r "include 'bootstrap.php'; print( \Config('database.servers.mongodb.port'));"`
        MongoUser=`ENV=development php -r "include 'bootstrap.php'; print( \Config('database.servers.mongodb.user'));"`
        MongoPass=`ENV=development php -r "include 'bootstrap.php'; print( \Config('database.servers.mongodb.password'));"`
        MongoDBName=`ENV=development php -r "include 'bootstrap.php'; print( \Config('database.servers.mongodb.dbname'));"`

        QueueHost=`cat config/development/queue.yml | grep "host:" | awk '{print $2}'`
        RedisHost=`cat config/development/redis.yml | grep "default:"|sed "s/'//g" |awk '{print $2}'`
        RedisAuth=`cat config/development/redis.yml | grep "auth:"|sed "s/'//g" |awk '{print $2}'`

	sed -i "s/MysqlName/$MysqlName/" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg/conf/development.yml
	sed -i "s/MysqlHost/$MysqlHost/" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg/conf/development.yml
	sed -i "s/MysqlPort/$MysqlPort/" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg/conf/development.yml 
	sed -i "s/MysqlDbname/$MysqlDBName/" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg/conf/development.yml 
	sed -i "s/MysqlUser/$MysqlUser/" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg/conf/development.yml
	sed -i "s/MysqlPasswd/$MysqlPass/" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg/conf/development.yml

	sed -i "s/MysqlName/$MysqlName/" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg/conf/development.yml
	sed -i "s/MysqlHost/$MysqlHost/" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg/conf/development.yml
	sed -i "s/MysqlPort/$MysqlPort/" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg/conf/development.yml 
	sed -i "s/MysqlDbname/$MysqlDBName/" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg/conf/development.yml 
	sed -i "s/MysqlUser/$MysqlUser/" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg/conf/development.yml
	sed -i "s/MysqlPasswd/$MysqlPass/" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg/conf/development.yml

       	sed -i "s/application_name: .*/application_name: AYSaaS-$sBranchName/" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg/conf/development.yml
	sed -i "s/QueueHost/$QueueHost/" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg/conf/development.yml
	sed -i "s/RedisHost/$RedisHost/" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg/conf/development.yml
	sed -i "s/RedisAuth/$RedisAuth/" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg/conf/development.yml
	chown -R anyuan:anyuan /var/www/www.$Branch.$sBranchName.aysaas.com
}

function SetDns() {
        local _Ip=`ifconfig | grep inet | grep 192.168 |awk -F":" '{print $2}' | awk '{print $1}'`
        local _IpPort=`ifconfig | grep inet | grep 192.168 |awk -F":" '{print $2}' | awk '{print $1}'| awk -F"." '{print $4}'`
        app_name=`cat /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com |grep server_name | grep "\<www." | awk '{print $2}' |sed "s/;//g"`
        fileio_name=`cat /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com |grep server_name | grep "\<fileio." | awk '{print $2}' |sed "s/;//g"`
        static_name=`cat /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com |grep server_name | grep "\<static." | awk '{print $2}' |sed "s/;//g"`
        nodestatic_name=`cat /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com |grep server_name | grep "\<nodestatic." | awk '{print $2}' |sed "s/;//g"`
        echo "${_Ip} ${app_name}" > /root/dnsname${_IpPort}.log
        echo "${_Ip} ${fileio_name}" >> /root/dnsname${_IpPort}.log
        echo "${_Ip} ${static_name}" >> /root/dnsname${_IpPort}.log
        echo "${_Ip} ${nodestatic_name}" >> /root/dnsname${_IpPort}.log
        scp /root/dnsname${_IpPort}.log root@192.168.0.122:~/
        ssh -l root 192.168.0.122 "bash -x /root/setdomaintodns.sh ${_IpPort}"
}


#function TransYml() {
#if [[ -f /var/www/www.$Branch.$sBranchName.aysaas.com/$TigSaaS/deploy/config ]]; then
#    ########2017-12-30 生成yml文件
#    cd /var/www/www.$Branch.$sBranchName.aysaas.com/$TigSaaS
#    chown -R anyuan:anyuan /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg/conf/*
#    ./deploy/config
#    ./deploy/syncConfig
#else
#    ########2018-01-02 兼容master分支
#    cp /root/scripts/rundeck/template/feature/development.yml /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg/conf/
#    sed -i "s/BRANCHTYPE/$Branch/g" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg/conf/development.yml
#    sed -i "s/BRANCHNAME/$sBranchName/g" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg/conf/development.yml
#    sed -i "s/MYSQLPORT/$DockerMysqlPort/g" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg/conf/development.yml
#    sed -i "s/MONGOPORT/$DockerMongoPort/g" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg/conf/development.yml
#    sed -i "s/WEBPORT/$webPort/g" /var/www/www.$Branch.$sBranchName.aysaas.com/$TigOrg/conf/development.yml
#fi
#}

############################
#########调用jenkins
function JenKins() {

	#curl -X POST http://192.168.0.251:8080/jenkins/job/CheckIntegrationEnv/buildWithParameters --user apiadmin:aykj83752661
	curl -X POST http://192.168.0.251:8080/jenkins/job/CheckIntegrationEnv/build --user apiadmin:aykj83752661
	[ $? -eq 0 ] && echo "调用jenkins成功"
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
    PullOrg $Param3
    if [ "$Param4" != "" ];then
	DeployNode
    fi
    #TransYml
    #ManageDB
    #ManageMongo
    ReService
    CreateCrontab
    SetDns
    EchoFeatureInfo
    ;;
"deploynode")
    DeployNode
    ;;
"echo")
    InPut NoCheck
    OutPut deploy
    ;;
"delete")
    InPut "NoCheck"
    DelCode
    DelNginxConf
    #DelQueue
    #DelDB
    #DelMongo
    DelDockerMysql
    DelDockerMongo
    DelInfo
    DelRedis
    DelDns
    DelNode
    #use crontab to clean
    #DelCrontab
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
   ;;
"jenkins")
   JenKins
esac
