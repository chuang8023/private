#!/bin/bash

Param1=$1
Param2=$2
Param3=$3
Param4=$4

cd `dirname $0`
. config/rundeck.cf
. lib/migrate.sh
. lib/modifyDBurl.sh
. lib/code.sh
. lib/gulp.sh
. lib/queue.sh
. lib/pullLog.sh
. lib/minAssets.sh
. lib/cache.sh
. lib/database.sh
. lib/branch.sh
. lib/git.sh
. lib/tempDB.sh
. lib/cloneDB.sh
. lib/websocket.sh
. lib/log.sh
. lib/debug.sh
. lib/ShowProj.sh
. lib/professional.sh
. lib/mongo.sh
. lib/node.sh
. lib/ShowProj.sh

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
#    exit 1
fi

if [[ $INFOType == "File" ]]; then
    ConfigPath="$(cd `dirname $0`;pwd)/config"
    DataPath="$(cd `dirname $0`;pwd)/data"
    LogPath="$(cd `dirname $0`;pwd)/log"
    while read LINE
    do
        local _ChkName=`echo $LINE | grep -v "#" | awk -F"|" '{print $1}' | awk 'gsub(/^ *| *$/,"")'`
        if [[ $_ChkName == $ProjName ]]; then
            #只能按顺序在末尾新增，千万不可更改已有的顺序，灾难！
            ProjType=`echo $LINE | awk -F"|" '{print $2}' | awk 'gsub(/^ *| *$/,"")'`
            ProjPath=`echo $LINE | awk -F"|" '{print $3}' | awk 'gsub(/^ *| *$/,"")'`
            DBType=`echo $LINE | awk -F"|" '{print $4}' | awk 'gsub(/^ *| *$/,"")'`
            DBId=`echo $LINE | awk -F"|" '{print $5}' | awk 'gsub(/^ *| *$/,"")'`
            CloneDBId=`echo $LINE | awk -F"|" '{print $6}' | awk 'gsub(/^ *| *$/,"")'`
            NodePath=`echo $LINE | awk -F"|" '{print $7}' | awk 'gsub(/^ *| *$/,"")'`
        fi
    done < $ConfigPath/projinfo
fi

if [[ $ProjPath == "" ]]; then
    echo ""
    echo "Cannot find project named $ProjName !"
 #   exit 1
fi

AccessAddr=`cat ${ProjPath}/config/${ProjType}/app.php | grep "www_domain" | awk -F"=>" '{print $2}'  | awk 'gsub(/^ *| *$/,"")' | sed "s/'//g" | sed "s/,$//"`
echo -e "\033[31m 项目访问地址 : \033[0m"
echo -e "\033[31m" $AccessAddr "\033[0m"

case $ProjType in
"production") ;;
"development") ;;
*)
    echo ""
    echo "Project type is wrong !"
#    exit 1
esac

if [[ -d $ProjPath/config/$ProjType ]]; then
    cd $ProjPath
    [ -e ./deploy/pheanstalk ] && QueueName="pheanstalk"
    [ -e ./deploy/resque ] && QueueName="resque"
    [ -e ./deploy/queue ] && QueueName="queue"
    BranchName=`git branch | grep "*" | awk '{print $2}'`
    cd - > /dev/null
    if [[ $BranchName == "" ]]; then
        echo ""
        echo "$ProjPath not find git !"
#        exit 1
    fi
    ProjConfPath="$ProjPath/config/$ProjType"
else
    echo ""
    echo "Not find project or project type is wrong !"
#    exit 1
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
    UpdateVendor
    Migrate "all"
    Rgulp "$CommitID"
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
    Rgulp "$CommitID"
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
    BackupDB 
    Migrate "$_ID"
    ;;
"choicemigrate")
     _MID=$Param3
     _CID=$Param4
     Main
     Choice_Migrate "$_MID" "$_CID"
     ;;
"closeMinAssets")
    Main
    MinAssets "close"
    ;;
"openMinAssets")
    Main
    MinAssets "open"
    ;;
rbuild|rgulp)
    Main
    Rgulp "-f"
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
 "ftp_backupDB")
     FTP_backupDB
     ;;
 "mysql_restore")
     Main
     Mysql_Restore $Param3
     ;;
"showBranch")
    Main
    ShowBranch
    ;;
"gco")
    _BranchName=$Param3
    Main
    ChkoutBranch "$_BranchName"
    UpdateVendor
    Migrate "all"
    Rgulp "-f"
    EmptyCache "all"
    Cache "all" "rebuild_to_redis"
    RestartResque
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
    TempDBStatus "$DBId"
    ;;
"tempDBExpireTime")
    Main
    TempDBExpireTime "$DBId"
    ;;
"createTempDB")
    Main
    CreateTempDB "$DBId"
    ;;
"deleteTempDB")
    Main
    DeleteTempDB "$DBId"
    ;;
"showTempDBUrl")
    Main
    ShowTempDBUrl "$DBId"
    ;;
"autoTempDB")
    Main
    AutoTempDB "$DBId"
    ;;
"cloneDBStatus")
    Main
    CloneDBStatus "$CloneDBId"
    ;;
"cloneDBExpireTime")
    Main
    CloneDBExpireTime "$CloneDBId"
    ;;
"createCloneDB")
    Main
    CreateCloneDB "$DBId"
    ;;
"deleteCloneDB")
    Main
    DeleteCloneDB "$CloneDBId"
    ;;
"showCloneDBUrl")
    Main
    ShowCloneDBUrl "$CloneDBId"
    ;;
"autoCloneDB")
    Main
    AutoCloneDB "$DBId"
   ;;
"updateVendor")
    Main
    UpdateVendor
    ;;
"autoMigrate")
    Main
    AutoMigrate
    ;;
"stopwebsocket")
   Main        
   StopWebsocket       
    ;;
"startwebsocket")
   Main
   StartWebsocket
   ;;
"catphplog")
  Main
  CatPHPLog $Param3   
   ;;
"cattomcatlog")
   echo $Param2
   CatTomcatLog $Param2
   ;;
"catresquelog")
 Main
  ResqueTypeInPut=$Param3
  case $ResqueTypeInPut in
   "default")
   CatResqueLog default
    ;;
   ("information_watch")
   CatResqueLog  information_watch
   ;;
   ("message_send")
   CatResqueLog  message_send
   ;;
   ("rules_engine")
   CatResqueLog  rules_engine
   ;;
   ("rules_engine_1")
   CatResqueLog  rules_engine_1
   ;;
   ("rules_engine_2")
   CatResqueLog  rules_engine_2
   ;;
   ("rules_engine_3")
   CatResqueLog  rules_engine_3
   ;;
   ("rules_engine_4")
   CatResqueLog  rules_engine_4
   ;;
   ("rules_engine_5")
   CatResqueLog  rules_engine_5
   ;;
   ("wf_monitor")
   CatResqueLog  wf_monitor
   ;;
   ("opensearch_engine")
   CatResqueLog  opensearch_engine
   ;;
   ("wf_instance_0")
   CatResqueLog wf_instance_0
   ;;
   ("wf_instance_1")
   CatResqueLog wf_instance_1
   ;;
   ("wf_instance_2")
   CatResqueLog wf_instance_2
   ;;
   ("wf_instance_3")
   CatResqueLog wf_instance_3
   ;;
   ("wf_instance_4")
   CatResqueLog wf_instance_4
   ;;
  esac	
   ;;
  "downloadlog")
   Main
   DownloadLog $Param3 $Param4
   ;;
   ("opendebug")
   Main
   OpenDebug
   ;;
   ("closedebug")
   Main
   CloseDebug
   ;;
  ("cleanredis")
  Main
  EmptyCache "all"
  ;;
  ("convert_mongo")
  Main	
  Convert_mongodb
  ;;
 "professnalresque")
  Main
  ProfessnalResque
  ;;
 "showproj")
  ConfigPath="$(cd `dirname $0`;pwd)/config"
  ShowProj "$ConfigPath" "$ProjPath" "$ProjType"
  ;;
 "DebugBackUpMysql")
  Main
  RunBackup toftp
  ;;
 ("MongoDump")
  Main
  mongo mongodump
  ;;
  ("MongoRestore")
  Main
  mongo mongorestore
  ;;
"buildnode")
  Main
  BuildNode
  ;;
"restartpm2")
  Main
  RestartPm2
 ;;
"pullnode")
  Main
  PullNode
 ;;
"updatenode")
  Main
  PullNode
  BuildNode
  RestartPm2
esac
