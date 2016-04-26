#!/bin/bash

Param1=$1
Param2=$2
Param3=$3

cd `dirname $0`
. config/rundeck.cf
. lib/migrate.sh
. lib/modifyDBurl.sh
. lib/code.sh
. lib/rbuild.sh
. lib/resque.sh
. lib/pullLog.sh
. lib/minAssets.sh
. lib/cache.sh
. lib/database.sh
. lib/branch.sh
. lib/git.sh

function RealPath () {
local _Path=$1
local _Tag=`ls -la $_Path | head -n 1 | cut -b 1`
if [[ $_Tag == "l" ]]; then
    local _Path=`ls -la $_Path | awk -F" -> " '{print $2}'`
    RealPath $_Path
else
    echo "$_Path"
fi
}

function Main {
ProjName=`echo $Param2 | awk 'gsub(/^ *| *$/,"")'`

if [[ $ProjName == "" ]]; then
    echo ""
    echo "The project name cannot be empty !"
    exit 1
fi

if [[ $INFOType == "File" ]]; then
    ConfigPath="$(cd `dirname $0`;pwd)/config"
    DataPath="$(cd `dirname $0`;pwd)/data"
    while read LINE
    do
        local _ChkName=`echo $LINE | grep -v "#" | awk -F"|" '{print $1}' | awk 'gsub(/^ *| *$/,"")'`
        if [[ $_ChkName == $ProjName ]]; then
            ProjPath=`echo $LINE | awk -F"|" '{print $3}' | awk 'gsub(/^ *| *$/,"")'`
            ProjType=`echo $LINE | awk -F"|" '{print $2}' | awk 'gsub(/^ *| *$/,"")'`
            DBType=`echo $LINE | awk -F"|" '{print $4}' | awk 'gsub(/^ *| *$/,"")'`
            DBId=`echo $LINE | awk -F"|" '{print $5}' | awk 'gsub(/^ *| *$/,"")'`
        fi
    done < $ConfigPath/projinfo
fi

if [[ $ProjPath == "" ]]; then
    echo ""
    echo "Cannot find project named $ProjName !"
    exit 1
fi

case $ProjType in
"production") ;;
"development") ;;
*)
    echo ""
    echo "Project type is wrong !"
    exit 1
esac

if [[ -d $ProjPath/config/$ProjType ]]; then
    cd $ProjPath
    BranchName=`git branch | grep "*" | awk '{print $2}'`
    cd - > /dev/null
    if [[ $BranchName == "" ]]; then
        echo ""
        echo "$ProjPath not find git !"
        exit 1
    fi
    ProjConfPath="$ProjPath/config/$ProjType"
else
    echo ""
    echo "Not find project or project type is wrong !"
    exit 1
fi

ProjRealPath=`RealPath "$ProjPath"`
TimeStamp=`date +%y%m%d%H%M%S`
}

case $Param1 in
"update")
    _DBUrl=$Param3
    Main
    modifyDBurl "$_DBUrl" "check"
    GetPullLog
    PullCode
    BackupDB
    EchoPullLog
    Migrate "all"
    Rbuild "$CommitID"
    RestartResque
    ;;
"showPullLog")
    Main
    ShowPullLog
    ;;
"rollback")
    _CommitID=$Param3
    Main
    RollbackCode "$_CommitID"
    RollbackDB "$_CommitID"
    Migrate "all"
    Rbuild "$CommitID"
    Resque
    ;;
"resqueStat")
    Main
    ResqueStat
    ;;
"restartResque")
    Main
    RestartResque
    ;;
"showMigrate")
    Main
    ShowMigrate
    ;;
"migrate")
    _ID=$Param3
    Main
    Migrate "$_ID"
    ;;
"closeMinAssets")
    Main
    MinAssets "close"
    ;;
"openMinAssets")
    Main
    MinAssets "open"
    ;;
"rbuild")
    Main
    Rbuild "-f"
    ;;
"rebuild_org_tree")
    _Ent=$Param3
    Main
    Cache "$_Ent" "rebuild_org_tree"
    ;;
"rebuild_to_redis")
    _Ent=$Param3
    Main
    Cache "$_Ent" "rebuild_to_redis"
    ;;
"backupDB")
    Main
    BackupDB "-f"
    ;;
"showBranch")
    Main
    ShowBranch
    ;;
"gco")
    _BranchName=$Param3
    Main
    ChkoutBranch "$_BranchName"
    ;;
"cleanUserChatToken")
    _DBHost=$Param3
    Main
    CleanUserChatToken "$_DBHost"
    ;;
"stash")
    Main
    GitStash
    ;;
"stashpop")
    Main
    GitStashPop
    ;;
"gst")
    Main
    GitStatus
    ;;
"tempDBStatus")
    Main
    _Status=$(php $(cd `dirname $0`;pwd)/ext/manageTempDB.php $DBId tempDBStatus)
    if [[ $_Status != "" ]]; then
        echo $_Status
    else
        echo "Cannot get temp database status !"
        exit 1
    fi
    ;;
"tempDBExpireTime")
    Main
    _Time=$(php $(cd `dirname $0`;pwd)/ext/manageTempDB.php $DBId expireTime)
    if [[ $_Time != "" ]]; then
        echo $_Time
    else
        echo "Cannot get temp database expire time !"
        exit 1
    fi
    ;;
"createTempDB")
    Main
    _DBUrl="$(php $(cd `dirname $0`;pwd)/ext/manageTempDB.php $DBId createTempDB).mysql.rds.aliyuncs.com"
    _IsSuccess=`echo $_DBUrl | grep "^sub"`   #后期可以把判断条件换成ping
    if [[ $_IsSuccess != "" ]]; then
        modifyDBurl "${_DBUrl/_/-}" "nocheck"
        echo "Create temp database successfully !"
        echo "use function \"View temporary instance status\""
        echo "when the status is \"Running\", run migrate"
    fi
    ;;
"deleteTempDB")
    Main
    php $(cd `dirname $0`;pwd)/ext/manageTempDB.php $DBId deleteTempDB
    ;;
"autoTempDB")
    Main
    _DBUrl="$(php $(cd `dirname $0`;pwd)/ext/manageTempDB.php $DBId).mysql.rds.aliyuncs.com"
    _IsSuccess=`echo $_DBUrl | grep "^sub"`    #后期可以把判断条件换成ping
    if [[ $_IsSuccess != "" ]]; then
        modifyDBurl "${_DBUrl/_/-}" "nocheck"
    fi
    ;;
"updateVendor")
    Main
    UpdateVendor
    ;;
esac
