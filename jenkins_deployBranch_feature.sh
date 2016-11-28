#!/bin/bash
#rundeck path

workspaceBasePath=`pwd`

RundeckPath=$BasePath/scripts/rundeck

#run user
RunUser=`cat /etc/php5/fpm/pool.d/www.conf|grep 'user ='|awk -F '=' '{print $2}'|sed 's/ //'`

Param1=$1
Param2=$2
Param3=$3

cd `dirname $0`
. ext/deployBranch_feature.sh
. run.sh



NginxConfPath=./template/feature/www.feature.templateRelease.aysaas.com-nginx
FeatureConfPath=./template/feature/development

function ExistsCheck ()
{
     cat /var/log/FeatureDeplayDone.log |grep "$sBranchName" >/dev/null 2>&1
	if [[ $? -eq 0 ]]; then
	echo ""
	exit 0
	fi
}

function UpdateCode ()
{   
     [ ! -e /var/log/FeatureDeplayDone.log ] && touch /var/log/FeatureDeplayDone.log
     cat /var/log/FeatureDeplayDone.log |grep "$sBranchName" >/dev/null 2>&1
	if [[ $? -eq 0 ]]; then
		Main
   		UpdateVendor
    		Migrate "all"
	        Rbuild "$CommitID"
	fi
}

function ChangeCodeOwner ()
{
chown -R $RunUser:$RunUser /var/www/www.$Branch.$sBranchName.aysaas.com/
}

function InPut () {
_Param1=$1
ReleaseName=`echo $Param2 | awk 'gsub(/^ *| *$/,"")'`
if [[ $_Param1 != "NoCheck" ]]; then
    #CheckTemplate
    cd .
    echo "Test branch name $ReleaseName ..."
    echo "git fetch origin $ReleaseName:$ReleaseName"
    #git fetch origin $ReleaseName:$ReleaseName
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
[[ $Branch == "" ]] && Branch=test
sBranchName=`echo $ReleaseName | awk -F"/" '{print $2}'`

Branch=`ConversionA2a "$Branch"`
sBranchName=`ConversionA2a "$sBranchName"`

DatabaseName=${Branch}_${sBranchName}
unset _Param1
}



function CopyTemplate {
echo ""
echo "Copy template to www.$Branch.$sBranchName.aysaas.com ..."
if [[ -d /var/www/www.$Branch.$sBranchName.aysaas.com ]]; then
    #sudo mkdir -p /var/www/www.$Branch.$sBranchName.aysaas.com

   sudo rm -rf /var/www/www.$Branch.$sBranchName.aysaas.com
fi


#sudo ln -sf $workspaceBasePath /var/www/www.$Branch.$sBranchName.aysaas.com

shell1="sudo ln -sf $workspaceBasePath /var/www/www.$Branch.$sBranchName.aysaas.com"
`$shell1`
cp -a $FeatureConfPath /var/www/www.$Branch.$sBranchName.aysaas.com/config

[ ! -d log ] && mkdir log && chmod -R 777 log

[ ! -d upload ] && mkdir upload && chmod -R 777 upload 

chown -R $RunUser:$RunUser /var/www/www.$Branch.$sBranchName.aysaas.com/

sudo cp $NginxConfPath /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com

sudo ln -sf /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com /etc/nginx/sites-enabled/

if [[ $? != 0 ]]; then
    echo ""
    echo "Copy template to www.$Branch.$sBranchName.aysaas.com is Fail !"
    exit 1
else
    echo ""
    echo "Copy template to www.$Branch.$sBranchName.aysaas.com is OK !"
fi
}


function VendorUnpackaging {
echo ""
echo "Unpackaging vendor to www.$Branch.$sBranchName.aysaas.com ..."

cd /var/www/www.$Branch.$sBranchName.aysaas.com

./script/vendor unpackaging


cd - 1>/dev/null 2>&1
echo ""
echo "Unpackaging vendor $ReleaseName is OK !"

}

function ReService {
echo ""
echo "Restart nginx ..."
sudo service nginx reload
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

function MarkDeplayDone {
echo "$Branch.$sBranchName" > /var/log/FeatureDeplayDone.log
}
##############################################

InPut
case $Param1 in
"jenkins_pullBranch")
    UpdateCode
    ExistsCheck    
    EchoFeatureInfo
    CopyTemplate
    Main
    UpdateVendor
    #PullBranch
    ;;
"jenkins_modifyConf")
    ExistsCheck
    ModifyConf
    ;;
"jenkins_initDB")
    ExistsCheck
    ManageDB
    ManageMongo
    ;;
"jenkins_startService")
    ExistsCheck
    Main
    Migrate "all"
    Rbuild "-f"
    CreateCrontab
    ReService
    MarkDeplayDone
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
