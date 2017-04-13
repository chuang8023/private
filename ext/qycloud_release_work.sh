#!/bin/bash
ReleaseWorkFlow=$1
SaaSRepertoryPath="$HOME/saas"
#master打tag
function MasterPickupTag () {
cd $SaaSRepertoryPath
TagName="master-v`date +%y%m%d`"
git checkout master
git pull origin master
git tag|grep $TagName
[ $? -eq 0 ] && git push origin :$TagName && git tag -d $TagName
git tag -a $TagName -m $TagName
git push origin $TagName:$TagName
CurrentMigrationTag=`ls -l db/migrations|awk '{print $9}'|awk -F '_' '{print $1}'|tail -1`
LastMigrationTag=`cat deploy/othersaas/UpgradeData.php|grep master-v|awk -F '=>' '{print $1}'|sed "s/'//g"|tail -1|sed 's/ //g'`
 if [ $CurrentMigrationTag != $LastMigrationTag ];then
     sed -i  "/$LastMigrationTag/a\        '$CurrentMigrationTag' => '$TagName',"  deploy/othersaas/UpgradeData.php	
     git add deploy/othersaas/UpgradeData.php
     git commit -m "新增新$TagName标记"
     git push origin master
 fi
exit 0
}
#新切推送master修复分支
function CreateMasterHotfix () {
cd $SaaSRepertoryPath
NewMasterHotfixName="hotfix/master-`date +%y%m%d`"
OldMasterHotfixName=`git branch|grep hotfix/master`
OldMasterHotfixName=`echo $OldMasterHotfixName|sed 's/  //'|sed 's/* //'`
[ $? -eq 0 ] && git push origin :$OldMasterHotfixName && git branch -D $OldMasterHotfixName
git checkout master
git checkout -b $NewMasterHotfixName
git push origin $NewMasterHotfixName:$NewMasterHotfixName
exit 0
}
#更新软件
function UpdateSoft () {
echo ""
echo "update server soft source !"
echo ""
apt-fast update > /dev/null 2>&1
apt-fast -y upgrade > /dev/null 2>&1
[ $? -eq 0 ] && echo "update server soft ok !"
}
[ $ReleaseWorkFlow = "MasterPickupTag" ] && MasterPickupTag 
[ $ReleaseWorkFlow = "CreateMasterHotfix" ] && CreateMasterHotfix 
[ $ReleaseWorkFlow = "UpdateSoft" ] && UpdateSoft
