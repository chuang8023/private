#!/bin/bash

_Branch=$1
_EMail=$2
_IsDel=$3

ScriptPath="/root/scripts/rundeck"

function IsNew {
ConfigPath="$(cd `dirname $0`;pwd)/config"
while read LINE
do
    _ChkName=`echo $LINE | grep -v "#" | awk -F"|" '{print $1}' | awk 'gsub(/^ *| *$/,"")'`
    if [[ $_ChkName != $_Branch ]]; then
        IsNew=1
    fi
done < $ConfigPath/projinfo
unset _ChkName
}

function IsFeature {
IsFeature=`echo $_Branch | grep "^feature/"`
if [[ -n $IsFeature ]]; then
    IsFeature="1"
fi
}

function Deploy {
Title="部署feature结果"
$ScriptPath/ext/deployBranch_feature.sh "deploy" $_Branch > /tmp/_HookMail_$_Branch &&\
$ScriptPath/run.sh "update" $_Branch >> /tmp/_HookMail_$_Branch &&\
$ScriptPath/run.sh "rbuild" $_Branch >> /tmp/_HookMail_$_Branch &&\
if [[ $? == 0 ]]; then
    $ScriptPath/ext/deployBranch_feature.sh "echo" $_Branch >> /tmp/_HookMail_$_Branch
else
    echo "分支部署失败!" >> /tmp/_HookMail_$_Branch
fi
}

function Update {
Title="更新分支结果"
$ScriptPath/run.sh "update" $_Branch
if [[ $? == 0 ]]; then
    echo "更新分支成功！" > /tmp/_HookMail_$_Branch
else
    echo "更新分支失败! " > /tmp/_HookMail_$_Branch
fi
}

function Del {
Title="删除分支结果"
$ScriptPath/ext/deployBranch_feature.sh "delete" $_Branch
if [[ $? == 0 ]]; then
    echo "删除分支成功！" > /tmp/_HookMail_$_Branch
else
    echo "删除分支失败! " > /tmp/_HookMail_$_Branch
fi
}

function EMail {
if [[ -n $_EMail ]]; then
    heirloom-mailx -s "$Title" $_EMail < /tmp/_HookMail_$_Branch
fi
rm -rf /tmp/_HookMail_$_Branch
}

if [[ -n $_Branch ]]; then
    IsFeature
    #如果是release实现自动推送，则将下面的判断改成[[ ! -n $IsFeature ]]
    if [[ -n $IsFeature ]]; then
        if [[ -n $Del ]]; then
            Del
        elif [[ -n $IsNew ]]; then
            Deploy
        else
            Update
        fi
    fi
    EMail
fi
