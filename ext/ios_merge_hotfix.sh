function SaaSMergeHotFix () {
IOSRepertoryPath="$HOME/ios"
cd $IOSRepertoryPath

echo $Web_Url|grep iOS > /dev/null 2>&1

IsIOS=$0

if [[ $Branch = "master" && $IsIOS = 0 ]]; then
  
  git checkout master 
  git pull --rebase origin master
  git log  -n 1 --name-only --grep "hotfix"|grep hotfix > /dev/null 
   if [ $? -eq 0 ]; then
      GitMerge master release  ios
      GitMerge release integration ios
      echo "$HotFixBranch merge to branchs is ok !" | heirloom-mailx -s "hotfix auto merge results"  $EMail
   fi
fi
}

