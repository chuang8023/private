#!/bin/bash

#传入参数有3个，第1个参数是分支名，第2个参数是E-Mail地址，第3个是是否删除分支的标志位（0为不删除，1为删除）
Branch=$1
EMail=$2
IsDel=$3

ScriptPath="/root/scripts/rundeck"

function GetServerType {
IPAddr=`ip -oneline route get 192.168.0.1 | awk '{print $5}'`
cd `dirname $0`
ServerType=`cat config/serverType | grep $IPAddr | awk -F":" '{print $1}'`
cd - >/dev/null 2>&1
}

function IsNew {
ConfigPath="$(cd `dirname $0`;pwd)/config"
IsNew=""
while read LINE
do
    _ChkName=`echo $LINE | grep -v "#" | awk -F"|" '{print $1}' | awk 'gsub(/^ *| *$/,"")'`
    if [[ $_ChkName == $Branch ]]; then
        IsNew=0
    fi
done < $ConfigPath/projinfo
unset _ChkName
}

function IsFeature {
IsFeature=`echo $Branch | grep "^feature/"`
if [[ -n $IsFeature ]]; then
    IsFeature="1"
fi
}

function Deploy {
Title="部署feature结果"
$ScriptPath/ext/deployBranch_feature.sh "deploy" $Branch > /tmp/_HookMail_${Branch//\//_} &&\
$ScriptPath/run.sh "update" $Branch >> /tmp/_HookMail_${Branch//\//_} &&\
$ScriptPath/run.sh "rbuild" $Branch >> /tmp/_HookMail_${Branch//\//_} &&\
if [[ $? == 0 ]]; then
    echo "分支${Branch}部署成功 !" > /tmp/_HookDeployURL_${Branch//\//_}
    echo "" >> /tmp/_HookDeployURL_${Branch//\//_}
    $ScriptPath/ext/deployBranch_feature.sh "echo" $Branch >> /tmp/_HookDeployURL_${Branch//\//_}
    Content=`cat /tmp/_HookDeployURL_${Branch//\//_}`
    rm -rf /tmp/_HookDeployURL_${Branch//\//_}
else
    Content="分支${Branch}部署失败 !"
fi
}

function Update {
Title="更新分支结果"
$ScriptPath/run.sh "update" $Branch > /tmp/_HookMail_${Branch//\//_}
if [[ $? == 0 ]]; then
    Content="更新分支${Branch}成功！"
else
    Content="更新分支${Branch}失败! "
fi
}

function Del {
Title="删除分支结果"
$ScriptPath/ext/deployBranch_feature.sh "delete" $Branch > /tmp/_HookMail_${Branch//\//_}
if [[ $? == 0 ]]; then
    Content="删除分支${Branch}成功！"
else
    Content="删除分支${Branch}失败! "
fi
}

function EMail () {
UserName=($*)

if [[ $EMail != "null" || ${#UserName[*]} != "0" ]]; then
    if [[ -n $Title && -n $Content ]]; then
        iconv -f UTF-8 -t GB2312 /tmp/_HookMail_${Branch//\//_} > /tmp/${Branch//\//_}_Logging.txt
        echo "$Content" | heirloom-mailx -s "$Title" -a "/tmp/${Branch//\//_}_Logging.txt" $EMail ${UserName[*]}
        rm -rf /tmp/${Branch//\//_}_Logging.txt
    fi
fi
rm -rf /tmp/_HookMail_${Branch//\//_}
}

function MergeHotfix () {
SAASPath="$HOME/saas"
cd $SAASPath
Date=`date +%Y-%m-%d`

function GitMerge ()
{
  FromBranch=$1
  ToBranch=$2
  echo "start to merge $FromBranch  to $ToBranch !"
  sleep 10
  git checkout $FromBranch
  git pull --rebase origin $FromBranch
  git checkout $ToBranch
  git pull --rebase origin $ToBranch
  git merge $FromBranch --no-ff --no-edit
  if [ $? -eq 0 ] 
    then
     echo "$FromBranch merge to $ToBranch is ok !"
     echo "$Date : merge $FromBranch to $ToBranch is ok !" >> /$HOME/merge_hotfix.log
         if [[ $FromBranch == "master" ]] 
           then
            echo "$Date : $HotFixAuthor : $HotFixBranch : $HotFixInfo" >> /$HOME/master_merge_hotfix.log
         fi
     echo "start to push $ToBranch ...."
     sleep 10
     git push origin $ToBranch:$ToBranch
    else
     echo ""
     echo "merge $FromBranch to $ToBranch is failed !"
     echo ""
     echo "请手动解决冲突后,再执行合并动作 !"
     echo ""
     echo "$Date : merge $FromBranch to $ToBranch is failed !" >> /$HOME/merge_hotfix.log
     sleep 10
     echo "$HotFixBranch merge to branchs is failed ! please check hotfix merge locally !" | heirloom-mailx -s "hotfix auto merge results"  $EMail
     exit 1
 fi
}
if [[ $Branch = "master" ]]; then
  
  git checkout master 
  git pull --rebase origin master
  git log  -n 1 --name-only --grep "hotfix"|grep hotfix > /dev/null 
   if [ $? -eq 0 ]; then
      HotFixInfo=`git log  -n 1 --name-only --grep "hotfix"|grep hotfix|awk '{print $5}'`
      HotFixBranch=`git log  -n 1 --name-only --grep "hotfix"|grep hotfix|awk -F ":" '{print $2}'|awk -F "->" '{print $1}'|sed 's/(//'`
      HotFixAuthor=`git log  -n 1 --name-only --grep "hotfix"|grep "Created"|awk -F ":" '{print $2}'|sed 's/@//'`
      GitMerge master release
      GitMerge release intergration
      echo "$HotFixBranch merge to branchs is ok !" | heirloom-mailx -s "hotfix auto merge results"  $EMail
   fi
fi
}

if [[ -n $Branch ]]; then
    GetServerType
    IsFeature
    if [[ -n $IsFeature && $ServerType == "feature" ]]; then
        IsNew
        if [[ $IsDel == "1" ]]; then
            Del
            EMail
        elif [[ $IsNew == "0" ]]; then
            Update
            EMail
        else
            Deplog
        fi
    fi

MergeHotfix

fi
