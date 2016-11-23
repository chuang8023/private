#!/bin/bash
#rundeck path

workspaceBasePath=`pwd`

RundeckPath=$BasePath/scripts/rundeck

#run user
RunUser=`cat /etc/php5/fpm/pool.d/www.conf|grep 'user ='|awk -F '=' '{print $2}'`

Param1=$1
Param2=$2
Param3=$3

cd `dirname $0`
. ext/deployBranch_feature.sh



NginxConfPath=./template/feature/www.feature.templateRelease.aysaas.com-nginx
FeatureConfPath=./template/feature/development


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
chown -R $RunUser:$RunUser /var/www/www.$Branch.$sBranchName.aysaas.com
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

[ ! -d log ] && mkdir log && chmod -R 777 log
[ ! -d upload ] && mkdir upload && chmod -R 777 upload 

sudo chown -R $RunUser:$RunUser /var/www/www.$Branch.$sBranchName.aysaas.com

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

##############################################

InPut

case $Param1 in
"jenkins_pullBranch")

    CopyTemplate
    #PullBranch
    VendorUnpackaging
    ;;
"jenkins_modifyConf")
    ModifyConf
    ;;
"jenkins_initDB")
    ManageDB
    ManageMongo
    ;;
"jenkins_startService")
    ReService
    CreateCrontab
    EchoFeatureInfo
    
    OutPut deploy
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
