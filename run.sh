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

function RealPath () {
_Path=$1
_Tag=`ls -la $_Path | head -n 1 | cut -b 1`
if [[ $_Tag == "l" ]]; then
    _Path=`ls -la $_Path | awk -F" -> " '{print $2}'`
    RealPath $_Path
else
    echo "$_Path"
fi
unset _Path
unset _Tag
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
        _ChkName=`echo $LINE | grep -v "#" | awk -F"|" '{print $1}' | awk 'gsub(/^ *| *$/,"")'`
        if [[ $_ChkName == $ProjName ]]; then
            ProjPath=`echo $LINE | awk -F"|" '{print $3}' | awk 'gsub(/^ *| *$/,"")'`
            ProjType=`echo $LINE | awk -F"|" '{print $2}' | awk 'gsub(/^ *| *$/,"")'`
            DBType=`echo $LINE | awk -F"|" '{print $4}' | awk 'gsub(/^ *| *$/,"")'`
        fi
    done < $ConfigPath/projinfo
    unset _ChkName
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
    DBUrl=$Param3
    Main
    modifyDBurl
    GetGitLog
    PullCode
    BackupDB
    EchoGitLog
    Migrate "all"
    Rbuild
    Resque
    ;;
"showPullLog")
    Main
    ShowPullLog
    ;;
"rollback")
    CommitID=$Param3
    Main
    RollbackCode
    RollbackDB
    Migrate "all"
    Rbuild
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
    unset _ID
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
    unset _Ent
    ;;
"rebuild_to_redis")
    _Ent=$Param3
    Main
    Cache "$_Ent" "rebuild_to_redis"
    unset _Ent
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
    unset _BranchName
    ;;
"cleanUserChatToken")
    _DBHost=$Param3
    Main
    CleanUserChatToken "$_DBHost"
    unset _DBHost
    ;;
esac
