function SaaSReleaseMergePre () {

#echo $RepName | grep "$WebRepName" > /dev/null 2>&1
#IsSaaS=$?

#if [[ $Branch = "release" && $IsSaaS = 0 ]]; then
if [[ $Branch = "release" ]]; then

  cd $SaaSRepertoryPath

  git checkout release
  git pull --rebase origin release
  HotfixRecord=1
  git log  -n 1 --name-only --grep "pre/qycloud"|grep pre/qycloud|grep proj/qycloud > /dev/null
  [ $? -eq 0 ] && HotfixRecord=0
  git log  -n 1 --name-only --grep "hotfix"|grep hotfix > /dev/null
   if [ $? -eq 0 ]; then
      #HotFixInfo=`git log  -n 1 --name-only --grep "hotfix"|grep hotfix|awk '{print $5}'`
      #HotFixBranch=`git log  -n 1 --name-only --grep "hotfix"|grep hotfix|awk -F ":" '{print $2}'|awk -F "->" '{print $1}'|sed 's/(//'`
      #HotFixAuthor=`git log  -n 1 --name-only --grep "hotfix"|grep "Created"|awk -F ":" '{print $2}'|sed 's/@//'`
      GitMerge release pre/qycloud saas
      #echo "SaaS's $HotFixBranch merge to branchs is ok !" | heirloom-mailx -s "SaaS's $HotFixBranch merge to branchs is ok"  $EMail
   fi
fi
}
