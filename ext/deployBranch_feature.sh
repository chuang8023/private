#!/bin/bash
#rundeck path
RundeckPath=/root/rundeck

#run user
RunUser=anyuan

# 运行前请检查以下模板是否存在、位置是否正确:
# 源码:$CodePath
# Nginx:$NginxConfPath
# 数据库:$DBPath
CodePath=/root/rundeck/template/feature/www.feature.templateRelease.aysaas.com
NginxConfPath=/root/rundeck/template/feature/www.feature.templateRelease.aysaas.com-nginx
DBPath=/root/rundeck/template/feature/template.sql

#Database info
SQLname="template.sql"
DBIP="127.0.0.1"
DBUser="root"
DBPasswd="saas"

#Web info
#WebPort="55555"

#Template info
TBranch="feature"
TBranchName="templateRelease"
TWebPort="55555"

#######################################

Param1=$1
Param2=$2

function ConversionA2a () {
str=`echo $1 | tr '[A-Z]' '[a-z]'`
echo $str
}

function CheckTemplate {
if [[ ! -d $CodePath ]]; then
    echo "Template of Code is NOT exist !"
    exit 1
fi
if [[ ! -f $NginxConfPath ]]; then
    echo "Template of Nginx is NOT exist !"
    exit 1
fi
if [[ ! -f $DBPath ]]; then
    echo "Template of Mysql is NOT exist !"
    exit 1
fi
}

function InPut {
ReleaseName=$Param2
CheckTemplate
cd $CodePath
echo "Test branch name $ReleaseName ..."
git fetch origin $ReleaseName:$ReleaseName 1>/dev/null 2>&1
if [[ $? != 0 ]]; then
    echo "Branch name is wrong !"
    exit 1
else
    echo "Test branch name $ReleaseName is OK !"
    git branch -D $ReleaseName 1>/dev/null 2>&1
    cd - 1>/dev/null 2>&1
fi

Branch=`echo $ReleaseName | awk -F"/" '{print $1}'`
sBranchName=`echo $ReleaseName | awk -F"/" '{print $2}'`

Branch=`ConversionA2a "$Branch"`
sBranchName=`ConversionA2a "$sBranchName"`

DatabaseName=${Branch}_${sBranchName}
}

function CopyTemplate {
echo "Copy template to www.$Branch.$sBranchName.aysaas.com ..."
cp -r $CodePath /var/www/www.$Branch.$sBranchName.aysaas.com
chown -R $RunUser:$RunUser /var/www/www.$Branch.$sBranchName.aysaas.com
cp $NginxConfPath /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com
ln -sf /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com /etc/nginx/sites-enabled/
if [[ $? != 0 ]]; then
    echo "Copy template to www.$Branch.$sBranchName.aysaas.com is Fail !"
    exit 1
else
    echo "Copy template to www.$Branch.$sBranchName.aysaas.com is OK !"
fi
}

function PullBranch {
echo "Pull branch $ReleaseName ..."
cd /var/www/www.$Branch.$sBranchName.aysaas.com
git fetch origin $ReleaseName:$ReleaseName 1>/dev/null 2>&1
git checkout $ReleaseName 1>/dev/null 2>&1
NoUsed=(`git branch | grep -v "*" | grep -v "$ReleaseName"`)
for (( i=0;i<${#NoUsed};i++ ))
do
    git branch -D ${NoUsed[i]} 1>/dev/null 2>&1
done
chmod -R 777 log upload
cd - 1>/dev/null 2>&1
echo "Pull branch $ReleaseName is OK !"
}

function ModifyConf {
echo "Modify config file ..."
sed -i "s/$TBranchName/$sBranchName/" /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/app.php
sed -i "s/$TBranch/$Branch/" /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/app.php
sed -i "s/$TBranchName/$DatabaseName/" /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/database.php
#sed -i "s/$TWebPort/$WebPort/" /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/app.php

sed -i "s/$TBranchName/$sBranchName/" /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com
#sed -i "s/$TWebPort/$WebPort/" /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com
echo "Modify config file is OK !"
}

function ManageDB {
DBIsExists=`mysql -h"$DBIP" -u"$DBUser" -p"$DBPasswd" -e "show databases like '$DatabaseName'"`
if [[ $? != 0 ]]; then
    echo "Database connect fail !"
    exit 1
fi
if [[ $DBIsExists == "" ]]; then
    echo "Create database $DatabaseName ..."
    mysql -h"$DBIP" -u"$DBUser" -p"$DBPasswd" -e "create database $DatabaseName;"
    echo "Create database $DatabaseName is OK !"
    echo "Import database $DatabaseName ..."
    mysql -h"$DBIP" -u"$DBUser" -p"$DBPasswd" $DatabaseName < $DBPath
    echo "Import database $DatabaseName is OK !"
fi
}

function ReService {
echo "Restart nginx ..."
service nginx reload
echo "Restart nginx is OK !"
}

function CreateCrontab {
echo "Create crontab ..."
cd /var/www/www.$Branch.$sBranchName.aysaas.com
sudo -u $RunUser /usr/bin/env TERM=xterm ./deploy/crontab
cd - 1>/dev/null 2>&1
echo "Create crontab is OK !"
}

function EchoFeatureInfo {
echo "$ReleaseName|development|/var/www/www.$Branch.$sBranchName.aysaas.com|aliyun" >> $RundeckPath/config/projinfo
}

function OutPut {
echo ""
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "The URL is http://www.$Branch.$sBranchName.aysaas.com:$TWebPort"
echo ""
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
}

##############################################

case $Param1 in
"deploy")
    InPut
    CopyTemplate
    PullBranch
    ModifyConf
    ManageDB
    ReService
    CreateCrontab
    ;;
"echo")
    InPut
    EchoFeatureInfo
    OutPut
    ;;
esac
