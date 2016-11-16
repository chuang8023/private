function SaaSHotfixMergeRelease () {
SaaSRepertoryPath="$HOME/saas"
CurrentWeek=`date +%w`
CurrentTime=`date +%y%m%d`
ReleaseTime=`echo $Branch|awk -F "-" '{print $2}'`
CeShiMail="1533587684@qq.com"

cd $SaaSRepertoryPath

case $CurrentWeek in 
1)
ReleaseMayTime1=`date -d'+2 day' +'%y%m%d'`
ReleaseMayTime2=`date -d'+9 day' +'%y%m%d'`
;;
2)
ReleaseMayTime1=`date -d'+1 day' +'%y%m%d'`
ReleaseMayTime2=`date -d'+8 day' +'%y%m%d'`
;;
3)
ReleaseMayTime1=`date +'%y%m%d'`
ReleaseMayTime2=`date -d'+7 day' +'%y%m%d'`
;;
4)
ReleaseMayTime1=`date -d'-1 day' +'%y%m%d'`
ReleaseMayTime2=`date -d'+6 day' +'%y%m%d'`
;;
5)
ReleaseMayTime1=`date -d'-2 day' +'%y%m%d'`
ReleaseMayTime2=`date -d'+5 day' +'%y%m%d'`
;;
*)
exit 1
;;
esac

HotfixReleaseMayBranch1="hotfix/release-$ReleaseMayTime1"
HotfixReleaseMayBranch2="hotfix/release-$ReleaseMayTime2"

echo $Web_Url|grep SaaS > /dev/null 2>&1

IsSaaS=$?

if [[ ($Branch = $HotfixReleaseMayBranch1 || $Branch = $HotfixReleaseMayBranch2) && $IsSaaS = 0 ]]; then
    
      git branch|grep $Branch  > /dev/null 2>&1
      [ ! $? -eq 0 ] && git fetch origin $Branch:$Branch        
	if [[ $CurrentWeek = 3 && $ReleaseTime = $CurrentTime ]]; then
      GitMerge $Branch release saas
      git checkout $Branch
      HotFixInfo=`git log  -n 1 --name-only|grep "Date" -A2|grep -v "Date"|sed '/^$/d'`
      HotFixAuthor=`git log  -n 1 --name-only|grep "Author"|awk   '{print $2}'`
      echo "SaaS's $Branch($HotFixAuthor:$HotFixInfo) merge to Release is ok !" | heirloom-mailx -s "SaaS's $Branch($HotFixAuthor:$HotFixInfo) merge to Release is ok !"  $CeShiMail
      GitMerge release pre/qycloud saas
      echo "SaaS's Release merge to pre/qycloud is ok !" | heirloom-mailx -s "SaaS's Release merge to pre/qycloud is ok"  $CeShiMail
	fi
fi
}

