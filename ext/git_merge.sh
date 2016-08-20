function GitMerge ()
{

  FromBranch=$1
  ToBranch=$2
  Repertory=$3
  Date=`date +%Y-%m-%d`
  echo "start to merge $FromBranch  to $ToBranch !"
  git checkout $FromBranch
  git pull --rebase origin $FromBranch
  git checkout $ToBranch
  git pull --rebase origin $ToBranch
  git merge $FromBranch --no-ff --no-edit
  if [ $? -eq 0 ] 
    then
     echo "$FromBranch merge to $ToBranch is ok !"
     echo "$Date : merge $FromBranch to $ToBranch is ok !" >> /$HOME/${Repertory}_merge_hotfix.log
         if [[ $ToBranch == "proj/qycloud" ]] 
           then
            [ $HotfixRecord -eq 1 ] && echo "$Date : $HotFixAuthor : $HotFixBranch : $HotFixInfo" >> /$HOME/${Repertory}_master_merge_hotfix.log
         fi
     echo "start to push $ToBranch ...."
     git push origin $ToBranch:$ToBranch
    else
     echo ""
     echo "merge $FromBranch to $ToBranch is failed !"
     echo ""
     echo "请手动解决冲突后,再执行合并动作 !"
     echo ""
     echo "$Date : merge $FromBranch to $ToBranch is failed !" >> /$HOME/${Repertory}_merge_hotfix.log
     echo "$Date : merge $FromBranch to $ToBranch is failed ! please check hotfix merge locally !" | heirloom-mailx -s "hotfix auto merge results"  $EMail
     exit 1
 fi
}

