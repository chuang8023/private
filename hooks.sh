#!/bin/bash

cd `dirname $0`
. ext/postman_test.sh 
. ext/git_merge.sh
. ext/android_merge_hotfix.sh
. ext/ios_merge_hotfix.sh
. ext/saas_merge_hotfix.sh

#传入参数有3个，第1个参数是分支名，第2个参数是E-Mail地址，第3个是是否删除分支的标志位（0为不删除，1为删除）
Branch=$1
EMail=$2
Web_Url=$3
HOME="/root"

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

#saas hotfix 合并
SaaSMergeHotFix
#android hotfix 合并
AndroidMergeHotFix
#ios hotfix 合并
IOSMergeHotFix

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


#integration 触发post-man测试
     if [[ $Branch = "integration" ]]; then
	 echo $Web_Url|grep SaaS > /dev/null 2>&1
         [ $? -eq 0 ] && StartPostMan
     fi
fi
