#/bin/bash
SaaSRepertoryPath="$HOME/saas"
cd $SaaSRepertoryPath
TagName="master-v`date +%Y%m%d`"
NewMasterHotfixName="hotfix/master-`date +%Y%m%d`"
OldMasterHotfixName=`git branch|grep hotfix/master`
#master打tag
git checkout master
git tag -a $TagName -m $TagName
git push origin $TagName:$TagName
#新切推送master修复分支
[ ! $OldMasterHotfixName == "" ] && git push origin :$OldMasterHotfixName
git checkout -b $NewMasterHotfixName
git push origin $NewMasterHotfixName:$NewMasterHotfixName
