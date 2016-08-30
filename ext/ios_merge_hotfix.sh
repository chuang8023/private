function IOSMergeHotFix () {
IOSRepertoryPath="$HOME/ios"
cd $IOSRepertoryPath

echo $Web_Url|grep iOS > /dev/null 2>&1

IsIOS=$?

if [[ $Branch = "master" && $IsIOS = 0 ]]; then
  
  git checkout master 
  git pull --rebase origin master
  git log  -n 1 --name-only --grep "hotfix"|grep hotfix > /dev/null 
   if [ $? -eq 0 ]; then
      HotFixBranch=`git log  -n 1 --name-only --grep "hotfix"|grep hotfix|awk -F ":" '{print $2}'|awk -F "->" '{print $1}'|sed 's/(//'`
      GitMerge master release  ios
      GitMerge release integration ios
      echo "IOS's $HotFixBranch merge to branchs is ok !" | heirloom-mailx -s "IOS's $HotFixBranch merge to branchs is ok"  $EMail
   fi
fi
}

