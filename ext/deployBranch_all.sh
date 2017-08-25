#!/bin/bash
#rundeck path
RundeckPath=/root/scripts/rundeck
TemplatePath=$RundeckPath/deploy/anyuan
Date=`date +%Y_%m_%d_%m`

#run user
RunUser=anyuan

# 运行前请检查以下模板是否存在、位置是否正确:
# 源码:$CodePath
# Nginx:$NginxConfPath
# 数据库:$DBPath


CodePath=/root/scripts/rundeck/deploy/anyuan/www.SysType.SysName.aysaas.com
NginxConfPath=/root/scripts/rundeck/deploy/anyuan/www.SysType.SysName.aysaas.com-nginx
DBPath=/root/scripts/rundeck/deploy/anyuan/template.sql


Param1=$1
Param2=$2
Param3=$3
Param4=$4
Param5=$5
Param6=$6
Param7=$7
Param8=$8


#System info
ENVType=development
BranchName="$Param2"
ExtranetIp="$Param3"
SysType=`echo "$Param2"|awk -F "/" '{print $1}'`
SysName=`echo "$Param2"|awk -F "/" '{print $2}'`

##Database info
SQLname="template.sql"
MysqlHost="$Param4"
MysqlUser="$Param5"
MysqlPass="$Param6"
RedisHost="$Param7"

##mysql-root info
DBIP="localhost"
DBUser="root"
DBPasswd="saas"

##Mongo info
MongoAdminUser=""
MongoAdminPass=""
MongoHost="$Param8"
MongoUser="$SysName"
MongoPass=`date +%s | sha256sum | base64 | head -c 16 ; echo`


#Template info
TSysType="feature"
TSysName="templateRelease"
TWebPort1=""
TWebPort2=""
TWebPort3=""
Port1=""
Port2=""
Port3=""

#######################################



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
BranchName=`echo $Param2 | awk 'gsub(/^ *| *$/,"")'`
cat $RundeckPath/config/projinfo | grep $BranchName
if [ $? == 0 ];then
	echo -e  "\033[31m" "警告：部署的分支已存在，请联系SA确认避免覆盖！" "\033[0m"
	echo -e  "\033[31m" "警告：部署的分支已存在，请联系SA确认避免覆盖！" "\033[0m"
	
	exit 1
fi
if [[ $_Param1 != "NoCheck" ]]; then
    CheckTemplate
    cd $CodePath
    echo "Test branch name $BranchName ..."
    git fetch origin $BranchName:$BranchName 1>/dev/null
    if [[ $? != 0 ]]; then
        echo ""
        echo "Branch name is wrong or network  is not good , check branch name and try it again !"
        exit 1
    else
        echo ""
        echo "Test branch name $BranchName is OK !"
        git branch -D $BranchName 1>/dev/null 2>&1
        cd - 1>/dev/null 2>&1
    fi
fi

SysType=`echo "$BranchName"|awk -F "/" '{print $1}'`
IsNormalBranch=`echo "$BranchName" | grep "/"`
[[ $IsNormalBranch == "" ]] && SysType=test
SysName=`echo "$BranchName"|awk -F "/" '{print $2}'`
[[ $SysName == "" ]] && SysName=$SysType

SysType=`ConversionA2a "$SysType"`
SysName=`ConversionA2a "$SysName"`
DatabaseName=${SysType}_${SysName}
unset _Param1
}

function CopyTemplate {
echo ""
echo "Copy template to www.$SysType.$SysName.aysaas.com ..."
if [[ ! -d /var/www/www.$SysType.$SysName.aysaas.com ]]; then
    cp -r $CodePath /var/www/www.$SysType.$SysName.aysaas.com
else
    rm -rf /var/www/www.$SysType.$SysName.aysaas.com
    cp -r $CodePath /var/www/www.$SysType.$SysName.aysaas.com
fi

cp $NginxConfPath /etc/nginx/sites-available/www.$SysType.$SysName.aysaas.com
ln -sf /etc/nginx/sites-available/www.$SysType.$SysName.aysaas.com /etc/nginx/sites-enabled/

if [[ $? != 0 ]]; then
    echo ""
    echo "Copy template to www.$SysType.$SysName.aysaas.com is Fail !"
    exit 1
else
    echo ""
    echo "Copy template to www.$SysType.$SysName.aysaas.com is OK !"
fi
chown -R $RunUser:$RunUser /etc/nginx/
}

function PullBranch {
echo ""
echo "Pull branch $BranchName ..."
cd /var/www/www.$SysType.$SysName.aysaas.com
git fetch origin $BranchName:$BranchName 1>/dev/null
git checkout $BranchName 1>/dev/null
NoUsed=(`git branch | grep -v "*" | grep -v "$BranchName"`)
for (( i=0;i<${#NoUsed};i++ ))
do
    git branch -D ${NoUsed[i]} 1>/dev/null 2>&1
done
./script/vendor unpackaging
mkdir -p /var/www/www.$SysType.$SysName.aysaas.com/upload
chmod -R 777 upload
chmod -R 777 log
chown -R $RunUser:$RunUser /var/www/www.$SysType.$SysName.aysaas.com
cd - 1>/dev/null 2>&1
echo ""
echo "Pull branch $BranchName is OK !"
}

function ModifyConf {
echo ""
echo "Modify config file ..."
[[ $ENVType == "production"  ]] && cp -a  $TemplatePath/base /var/www/www.$SysType.$SysName.aysaas.com/config/$ENVType
[[ $ENVType == "development"  ]] && cp -a  $TemplatePath/base /var/www/www.$SysType.$SysName.aysaas.com/config/$ENVType

sed -i "s/$TSysName/$SysName/" /var/www/www.$SysType.$SysName.aysaas.com/config/$ENVType/app.php
sed -i "s/$TSysType/$SysType/" /var/www/www.$SysType.$SysName.aysaas.com/config/$ENVType/app.php

sed -i "s/$TSysName/$DatabaseName/" /var/www/www.$SysType.$SysName.aysaas.com/config/$ENVType/database.php
sed -i "s/MysqlUser/$MysqlUser/" /var/www/www.$SysType.$SysName.aysaas.com/config/$ENVType/database.php
sed -i "s/MysqlHost/$MysqlHost/" /var/www/www.$SysType.$SysName.aysaas.com/config/$ENVType/database.php
sed -i "s/MysqlPass/$MysqlPass/" /var/www/www.$SysType.$SysName.aysaas.com/config/$ENVType/database.php
sed -i "s/MongoHost/$MongoHost/" /var/www/www.$SysType.$SysName.aysaas.com/config/$ENVType/database.php
sed -i "s/MongoUser/$MongoUser/" /var/www/www.$SysType.$SysName.aysaas.com/config/$ENVType/database.php
sed -i "s/MongoPass/$MongoPass/" /var/www/www.$SysType.$SysName.aysaas.com/config/$ENVType/database.php


sed -i "s/$TSysName/$SysName/" /var/www/www.$SysType.$SysName.aysaas.com/config/$ENVType/assets.php

sed -i  "s/RedisHost/$RedisHost/" /var/www/www.$SysType.$SysName.aysaas.com/config/$ENVType/redis.php 

sed -i  "s/RedisHost/$RedisHost/" /var/www/www.$SysType.$SysName.aysaas.com/config/$ENVType/resque.php

sed -i "s/TWebPort1/$Port1/" /var/www/www.$SysType.$SysName.aysaas.com/config/$ENVType/app.php
sed -i "s/TWebPort2/$Port2/" /var/www/www.$SysType.$SysName.aysaas.com/config/$ENVType/app.php
sed -i "s/TWebPort3/$Port3/" /var/www/www.$SysType.$SysName.aysaas.com/config/$ENVType/app.php

sed -i "s/$TSysName/$SysName/" /etc/nginx/sites-available/www.$SysType.$SysName.aysaas.com
sed -i "s/$TSysType/$SysType/" /etc/nginx/sites-available/www.$SysType.$SysName.aysaas.com
sed -i "s/TWebPort1/$Port1/" /etc/nginx/sites-available/www.$SysType.$SysName.aysaas.com
sed -i "s/TWebPort2/$Port2/" /etc/nginx/sites-available/www.$SysType.$SysName.aysaas.com
sed -i "s/TWebPort3/$Port3/" /etc/nginx/sites-available/www.$SysType.$SysName.aysaas.com
sed -i "s/ENVType/$ENVType/" /etc/nginx/sites-available/www.$SysType.$SysName.aysaas.com
#[[ ! $ExtranetIp == "" ]] && sed -i "s/server_name.*/server_name $ExtranetIp;/" /etc/nginx/sites-available/www.$SysType.$SysName.aysaas.com && sed -i "s/[a-z]*.proj.jacaq.aysaas.com/$ExtranetIp/" /var/www/www.$SysType.$SysName.aysaas.com/config/$ENVType/app.php

#[[ ! $ExtranetIp == "" ]] && sed -i "s/server_name.*/server_name $ExtranetIp;/" /etc/nginx/sites-available/www.$SysType.$SysName.aysaas.com

echo ""
echo "Modify config file is OK !"
}

function GetServerInfo {
InternalIp=`/sbin/ifconfig eth0|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"|sed s/"地址"//`
case $InternalIp in
192.168.0.223)
 Port1="55555" && Port2="55555" Port3="55555" && ENVType="development"
;;
10.0.0.207)
Port1="5207" && Port2="5207" Port3="5207" && ENVType="development"
;;
10.0.0.157)
 Port1="5210" && Port2="5210" Port3="5210" && ENVType="development"
;;
10.0.0.191) 
 Port1="22000" && Port2="22000" Port3="22000" && ENVType="development"
;;
192.168.0.209)
 Port1="23000" && Port2="23000" Port3="23000" && ENVType="development"
;;
192.168.0.122)
 Port1="23001" && Port2="23001" Port3="23001" && ENVType="development"
;;
*)
 Port1="8000" && Port2="8001" Port3="8002"
esac
}

function ManageDB {

mysql -h$DBIP -u$DBUser -p$DBPasswd -e "grant usage on *.* to $MysqlUser@"localhost" identified by '$MysqlPass';flush privileges;"
mysql -h$DBIP -u$DBUser -p$DBPasswd -e "grant all privileges on *.* to $MysqlUser@"localhost" identified by '$MysqlPass';flush privileges;"
#mysql -h$DBIP -u$DBUser -p$DBPasswd -e "grant all privileges on *.* to $MysqlUser@"%" identified by '$MysqlPass';flush privileges;"

DBIsExists=`mysql -h"$DBIP" -u"$DBUser" -p"$DBPasswd" -e "show databases like '$DatabaseName'"`
if [[ $? != 0 ]]; then
    echo ""
    echo "Database connect fail !"
    exit 1
fi
if [[ $DBIsExists == "" ]]; then
    echo ""
    echo "Create database $DatabaseName ..."
    mysql -h"$MysqlHost" -u"$MysqlUser" -p"$MysqlPass" -e "create database $DatabaseName"
    echo ""
    echo "Create database $DatabaseName is OK !"
    echo ""
    #echo "Import database $DatabaseName ..."
    #mysql -h"$MysqlHost" -u"$MysqlUser" -p"$MysqlPass" $DatabaseName < $DBPath
    #echo ""
    #echo "Import database $DatabaseName is OK !"
fi
}

function ManageMongo {
###mongo命令创建
MongoIsExists=`mongo --host $MongoHost:27017 admin --eval "db.adminCommand('listDatabases')" |grep $DatabaseName`
if [[ $MongoIsExists == "" ]]; then
    echo ""
    echo "Create Mongo  $DatabaseName ..."
    mongo --host $MongoHost:27017<<EOF 
use admin
use $DatabaseName
db.createUser(  
  {  
    user: "$MongoUser",  
    pwd: "$MongoPass",  
    roles: [ { role: "readWrite", db: "$DatabaseName" } ]  
  }  
) 
exit
EOF
    echo ""
    echo "Create Mongo $DatabaseName is OK !"
    echo ""
    echo "Convert data to Mongo  $DatabaseName ..."
    cd /var/www/www.$SysType.$SysName.aysaas.com
    local _Option=`ENV=$ProjType ./vendor/phing/phing/bin/phing -l | grep convert_mongodb`
    ./vendor/phing/phing/bin/phing ${_Option} << EOF

n
EOF
    echo ""
    echo "Convert data to Mongo $DatabaseName is OK !"
else 
    echo "Mongo $DatabaseName is Exists"
    exit 1
 fi


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
cd /var/www/www.$SysType.$SysName.aysaas.com
sudo -u $RunUser /usr/bin/env TERM=xterm ./deploy/crontab
cd - 1>/dev/null 2>&1
echo ""
echo "Create crontab is OK !"
echo "******************************"
}

function EchoFeatureInfo {
echo "$BranchName|$ENVType|/var/www/www.$SysType.$SysName.aysaas.com|base" >> $RundeckPath/config/projinfo
cat $RundeckPath/config/projinfo | sort | uniq > $RundeckPath/config/_tmp.projinfo
mv $RundeckPath/config/_tmp.projinfo $RundeckPath/config/projinfo


echo "项目访问地址为："cat /var/www/www.$SysType.$SysName.aysaas.com/config/$ENVType/app.php | grep "www_domain" | awk -F"=>" '{print $2}' | awk 'gsub(/^ *| *$/,"")' | sed "s/'//g" | sed "s/,$//"
}

function DelCode {
echo ""
echo "Delete code ..."
rm -rf /var/www/www.$SysType.$SysName.aysaas.com
echo ""
echo "Delete code is OK !"
}

function DelNginxConf {
echo ""
echo "Delete from nginx ..."
rm -rf /etc/nginx/sites-available/www.$SysType.$SysName.aysaas.com /etc/nginx/sites-enabled/www.$SysType.$SysName.aysaas.com
echo ""
echo "Delete from nginx is OK !"
}

function DelDB {
echo ""
echo "Delete from database ..."
mysql -h"$MysqlHost" -u"$MysqlUser" -p"$MysqlPass" -e "drop database $DatabaseName"
echo ""
echo "Delete from database is OK !"
}

function DelMongo {
echo ""
echo "Delete from mongo ..."
mongo<<EOF
use admin
use $DatabaseName
db.dropUser("$MongoUser")
db.dropDatabase()
exit
EOF
}
function DelInfo {
echo ""
echo "Delete project info"
IsExit=`cat $RundeckPath/config/projinfo | grep -n "$BranchName|$ENVType|/var/www/www.$SysType.$SysName.aysaas.com|base"`
if [[ -n $IsExit ]]; then
    RowNum=`cat $RundeckPath/config/projinfo | grep -n "$BranchName|$ENVType|/var/www/www.$SysType.$SysName.aysaas.com|base" | awk -F":" '{print $1}' | head -n 1`
    sed -i "${RowNum}d" $RundeckPath/config/projinfo
fi
echo ""
echo "Delete project info is OK !"
}

function DelRedis {
echo ""
echo "Delete redis ..."
for ((RedisPort=6379;RedisPort<=6384;RedisPort++))
do 
redis-cli  -h$RedisHost -p $RedisPort keys "AYSaaS-$SysType-$SysName*" | xargs redis-cli del >> /dev/null
done
echo "Delete project redis is OK !"
}

function DelCrontab {
echo ""
echo "Delete crontab ..."
sed -i '/^.*'$SysName'.*$/d' /var/spool/cron/crontabs/$RunUser
echo "Delete project crontab is OK !"
}


function OutPut () {
_Param1=$1
case $_Param1 in
"deploy")
echo ""
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "The URL is http://www.$SysType.$SysName.aysaas.com:$Port1"
echo ""
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
;;
"del")
echo ""
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "       Delete $BranchName  is OK !"
echo "       The branch $BranchName  is still in Coding.net"
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
   mysqldump -uroot -psaas $DatabaseName > $TemplatePath/$DatabaseName-$Date.sql
   [ $? -eq 0 ] && echo "Update template db has been finished !"
}

##############################################

case $Param1 in
"deploy")
    GetServerInfo
    InPut
    CopyTemplate
    PullBranch
    ModifyConf
    ManageDB
    ManageMongo
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
    DelDB
    DelMongo
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
