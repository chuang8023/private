function SaaSHotfixMergeRelease () {
SaaSRepertoryPath="$HOME/saas"
CurrentWeek=`date +%w`
CeShiMail="1533587684@qq.com"

cd $SaaSRepertoryPath

case $CurrentWeek in 
1)
ReleaseTime=`date -d'+2 day' +'%y%m%d'`
;;
2)
ReleaseTime=`date -d'+1 day' +'%y%m%d'`
;;
3)
ReleaseTime=`date +'%y%m%d'`
;;
4)
ReleaseTime=`date -d'-1 day' +'%y%m%d'`
;;
5)
ReleaseTime=`date -d'-2 day' +'%y%m%d'`
;;
*)
exit 1
;;
esac

HotfixReleaseBranch="hotfix/release-$ReleaseTime"

echo $Web_Url|grep SaaS > /dev/null 2>&1

IsSaaS=$?

if [[ $Branch = $HotfixReleaseBranch && $IsSaaS = 0 ]]; then
    
      git branch|grep $HotfixReleaseBranch  > /dev/null 2>&1
      [ ! $? -eq 0 ] && git fetch origin $HotfixReleaseBranch:$HotfixReleaseBranch        
      GitMerge $HotfixReleaseBranch release saas
      echo "SaaS's $HotfixReleaseBranch merge to Release is ok !" | heirloom-mailx -s "SaaS's $HotfixReleaseBranch merge to Release is ok"  $CeShiMail

	if [[ $CurrentWeek = 3 ]]; then
      GitMerge release pre/qycloud saas
      echo "SaaS's Release merge to pre/qycloud is ok !" | heirloom-mailx -s "SaaS's Release merge to pre/qycloud is ok"  $CeShiMail
	fi

fi
}

