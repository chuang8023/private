#!/bin/bash
ReleaseWorkFlow=$1
SaaSRepertoryPath="$HOME/saas"
cd $SaaSRepertoryPath
#master打tag
function MasterPickupTag () {
TagName="master-v`date +%y%m%d`"
git checkout master
git tag -a $TagName -m $TagName
git push origin $TagName:$TagName
exit 0
}
#新切推送master修复分支
function CreateMasterHotfix () {
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
