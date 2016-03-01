#!/bin/bash

Branch=$1
EMail=$2
IsDel=$3

ScriptPath="/root/scripts/rundeck"

function IsNew {
ConfigPath="$(cd `dirname $0`;pwd)/config"
while read LINE
do
    _ChkName=`echo $LINE | grep -v "#" | awk -F"|" '{print $1}' | awk 'gsub(/^ *| *$/,"")'`
    if [[ $_ChkName != $Branch ]]; then
        IsNew=1
    else
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
$ScriptPath/ext/deployBranch_feature.sh "deploy" $Branch > /tmp/_HookMail_$Branch &&\
$ScriptPath/run.sh "update" $Branch >> /tmp/_HookMail_$Branch &&\
$ScriptPath/run.sh "rbuild" $Branch >> /tmp/_HookMail_$Branch &&\
if [[ $? == 0 ]]; then
    $ScriptPath/ext/deployBranch_feature.sh "echo" $Branch >> /tmp/_HookMail_$Branch
else
    echo "分支部署失败!" >> /tmp/_HookMail_$Branch
fi
}

function Update {
Title="更新分支结果"
$ScriptPath/run.sh "update" $Branch
if [[ $? == 0 ]]; then
    echo "更新分支成功！" > /tmp/_HookMail_$Branch
else
    echo "更新分支失败! " > /tmp/_HookMail_$Branch
fi
}

function Del {
Title="删除分支结果"
$ScriptPath/ext/deployBranch_feature.sh "delete" $Branch
if [[ $? == 0 ]]; then
    echo "删除分支成功！" > /tmp/_HookMail_$Branch
else
    echo "删除分支失败! " > /tmp/_HookMail_$Branch
fi
}

function EMail {
if [[ $EMail != "null" ]]; then
    iconv -f UTF-8 -t GB2312 /tmp/_HookMail_$Branch /tmp/_HookMail_$Branch_GB
    heirloom-mailx -s "$Title" $EMail < /tmp/_HookMail_$Branch_GB
    rm -rf /tmp/_HookMail_$Branch_GB
fi
rm -rf /tmp/_HookMail_$Branch
}

if [[ -n $Branch ]]; then
    IsFeature
    #如果是release实现自动推送，则将下面的判断改成[[ ! -n $IsFeature ]]
    if [[ -n $IsFeature ]]; then
        if [[ $IsDel == "1" ]]; then
            Del
        elif [[ $IsNew == "1" ]]; then
            Deploy
        else
            Update
        fi
    fi
    EMail
fi
