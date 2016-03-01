#!/bin/bash

Branch=$1
EMail=$2
IsDel=$3

#如果是201、pre上使用则变为"release"; 如果是223使用，则写"feature"
ServerType="feature"
ScriptPath="/root/scripts/rundeck"

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
    echo "分支部署成功 !" > /tmp/_HookDeployURL_${Branch//\//_}
    echo "" >> /tmp/_HookDeployURL_${Branch//\//_}
    $ScriptPath/ext/deployBranch_feature.sh "echo" $Branch >> /tmp/_HookDeployURL_${Branch//\//_}
    Content=`cat /tmp/_HookDeployURL_${Branch//\//_}`
    rm -rf /tmp/_HookDeployURL_${Branch//\//_}
else
    Content="分支部署失败 !"
fi
}

function Update {
Title="更新分支结果"
$ScriptPath/run.sh "update" $Branch > /tmp/_HookMail_${Branch//\//_}
if [[ $? == 0 ]]; then
    Content="更新分支成功！"
else
    Content="更新分支失败! "
fi
}

function Del {
Title="删除分支结果"
$ScriptPath/ext/deployBranch_feature.sh "delete" $Branch > /tmp/_HookMail_${Branch//\//_}
if [[ $? == 0 ]]; then
    Content="删除分支成功！"
else
    Content="删除分支失败! "
fi
}

function EMail {
if [[ $EMail != "null" ]]; then
    iconv -f UTF-8 -t GB2312 /tmp/_HookMail_${Branch//\//_} > /tmp/${Branch//\//_}_Logging.txt
    echo "$Content" | heirloom-mailx -s "$Title" -a "/tmp/${Branch//\//_}_Logging.txt" $EMail
    rm -rf /tmp/${Branch//\//_}_Logging.txt
fi
rm -rf /tmp/_HookMail_${Branch//\//_}
}

if [[ -n $Branch ]]; then
    IsFeature
    if [[ -n $IsFeature && $ServerType == "feature" ]]; then
        IsNew
        if [[ $IsDel == "1" ]]; then
            Del
        elif [[ $IsNew == "0" ]]; then
            Update
        else
            Deploy
        fi
    fi
    if [[ ! -n $IsFeature && $ServerType == "release" ]]; then
        Update
    fi
    EMail
fi
