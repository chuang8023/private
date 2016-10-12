#!/bin/bash
ReleaseWorkFlow=$1
SaaSRepertoryPath="$HOME/saas"
cd $SaaSRepertoryPath
#master打tag
function MasterPickupTag () {
TagName="master-v`date +%Y%m%d`"
git checkout master
git tag -a $TagName -m $TagName
git push origin $TagName:$TagName
}
#新切推送master修复分支
function CreateMasterHotfix () {
NewMasterHotfixName="hotfix/master-`date +%Y%m%d`"
OldMasterHotfixName=`git branch|grep hotfix/master`
[ ! $OldMasterHotfixName == "" ] && git push origin :$OldMasterHotfixName
git checkout -b $NewMasterHotfixName
git push origin $NewMasterHotfixName:$NewMasterHotfixName
}
[ $ReleaseWorkFlow = "MasterPickupTag" ] && MasterPickupTag
[ $ReleaseWorkFlow = "CreateMasterHotfix" ] && CreateMasterHotfix

