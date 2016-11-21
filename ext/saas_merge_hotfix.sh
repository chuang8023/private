function SaaSMergeHotFix () {
SaaSRepertoryPath="$HOME/saas"
cd $SaaSRepertoryPath

echo $Web_Url|grep SaaS > /dev/null 2>&1

IsSaaS=$?

if [[ $Branch = "master" && $IsSaaS = 0 ]]; then
  
  git checkout master 
  git pull --rebase origin master
  HotfixRecord=1
  git log  -n 1 --name-only --grep "hotfix"|grep hotfix|grep release > /dev/null 
  [ $? -eq 0 ] && HotfixRecord=0
  git log  -n 1 --name-only --grep "hotfix"|grep hotfix > /dev/null 
   if [ $? -eq 0 ]; then
      HotFixInfo=`git log  -n 1 --name-only --grep "hotfix"|grep hotfix|awk '{print $5}'`
      HotFixBranch=`git log  -n 1 --name-only --grep "hotfix"|grep hotfix|awk -F ":" '{print $2}'|awk -F "->" '{print $1}'|sed 's/(//'`
      HotFixAuthor=`git log  -n 1 --name-only --grep "hotfix"|grep "Created"|awk -F ":" '{print $2}'|sed 's/@//'`
      GitMerge master proj/qycloud saas
      GitMerge master release  saas
      GitMerge release integration saas
      echo "SaaS's $HotFixBranch merge to branchs is ok !" | heirloom-mailx -s "SaaS's $HotFixBranch merge to branchs is ok"  $EMail
   fi
fi
}

