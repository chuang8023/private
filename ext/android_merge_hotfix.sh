function AndroidMergeHotFix () {
AndroidRepertoryPath="$HOME/android"
cd $AndroidRepertoryPath

echo $Web_Url|grep Android > /dev/null 2>&1

IsAndroid=$0

if [[ $Branch = "master" && $IsAndroid = 0 ]]; then
  
  git checkout master 
  git pull --rebase origin master
  git log  -n 1 --name-only --grep "hotfix"|grep hotfix > /dev/null 
   if [ $? -eq 0 ]; then
      HotFixBranch=`git log  -n 1 --name-only --grep "hotfix"|grep hotfix|awk -F ":" '{print $2}'|awk -F "->" '{print $1}'|sed 's/(//'`
      GitMerge master release  android
      GitMerge release integration android
      echo "$HotFixBranch merge to branchs is ok !" | heirloom-mailx -s "hotfix auto merge results"  $EMail
   fi
fi
}

