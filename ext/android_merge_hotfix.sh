function AndroidMergeHotFix () {

#echo $RepName | grep "$AndroidRepName" > /dev/null 2>&1
#IsAndroid=$?

#if [[ $Branch = "master" && $IsAndroid = 0 ]]; then
if [[ $Branch = "master" ]]; then
 
  cd $AndroidRepertoryPath
 
  git checkout master 
  git pull --rebase origin master
  git log  -n 1 --name-only --grep "hotfix"|grep hotfix > /dev/null 
   if [ $? -eq 0 ]; then
      HotFixBranch=`git log  -n 1 --name-only --grep "hotfix"|grep hotfix|awk -F ":" '{print $2}'|awk -F "->" '{print $1}'|sed 's/(//'`
      GitMerge master release  android
      GitMerge release integration android
      echo "Android's $HotFixBranch merge to branchs is ok !" | heirloom-mailx -s "Android's $HotFixBranch merge to branchs is ok"  $EMail
   fi
fi
}

