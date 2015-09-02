#!/bin/bash
#rundeck path
RundeckPath=/root/scripts/rundeck

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
if [[ $_Param1 != "NoCheck" ]]; then
    ReleaseName=`echo $Param2 | awk 'gsub(/^ *| *$/,"")'`
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
chown -R $RunUser:$RunUser /var/www/www.$Branch.$sBranchName.aysaas.com
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
chmod -R 777 log upload
cd - 1>/dev/null 2>&1
echo ""
echo "Pull branch $ReleaseName is OK !"
}

function ModifyConf {
echo ""
echo "Modify config file ..."
sed -i "s/$TBranchName/$sBranchName/" /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/app.php
sed -i "s/$TBranch/$Branch/" /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/app.php
sed -i "s/$TBranchName/$DatabaseName/" /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/database.php
#sed -i "s/$TWebPort/$WebPort/" /var/www/www.$Branch.$sBranchName.aysaas.com/config/development/app.php

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

function OutPut () {
_Param1=$1
case $_Param1 in
"deploy")
echo ""
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "The URL is http://www.$Branch.$sBranchName.aysaas.com:$TWebPort"
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
    EchoFeatureInfo
    ;;
"echo")
    InPut NoCheck
    OutPut deploy
    ;;
"delete")
    InPut
    DelCode
    DelNginxConf
    DelDB
    DelInfo
    ReService
    OutPut del
esac
