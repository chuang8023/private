function ShowMigrate {
cd $ProjPath
ENV=$ProjType ./script/phpmig status | grep -v "** MISSING **" | tail -n 20
ENV=$ProjType ./script/phpmig status | grep -v "** MISSING **" | grep "down" 1>/dev/null 
if [ $? -eq 0 ];then
	echo -e  "\033[31m" "提醒：分支有迁移状态为down，可使用【运行迁移】来运行迁移，迁移前会备份数据库！！下列显示状态为down的迁移信息" "\033[0m"
	ENV=$ProjType ./script/phpmig status | grep -v "** MISSING **" | grep "down" 
else
	echo -e  "\033[31m" "提醒：分支迁移状态都为up，无需运行迁移" "\033[0m"
fi
cd - 1>/dev/null 2>&1
}

function CheckMigrate {
cd $ProjPath
##不适用无忧&物联网
#ENV=$ProjType ./script/phpmig status | grep "20120822094445" 1>/dev/null
#if [[ $? != 0 ]]; then
#    echo "wrong"
#fi

local _MigStat=`ENV=$ProjType ./script/phpmig status | grep "down"`
if [[ $? == 0 ]]; then
    echo $_MigStat
fi
cd - 1>/dev/null 2>&1
}

function Migrate () {
local _ID=$1
local _Envirment=$2
if [[ $_ID == "all" ]]; then
    MigrateAll ${_Envirment}
else
    MigrateOne ${_Envirment} "$_ID"
fi
}

function MigrateAll {
local MigStat=`CheckMigrate`
local _Env=$1
if [[ $MigStat == "" ]]; then
    echo ""
    echo -e "\033[31m" "迁移状态已经为up，不需要再迁移" "\033[0m"
else
    echo ""
    echo "Running migrate ..."
    cd $ProjPath
    if [ "${_Env}" == "qycloud" ];then
    	ENV=$ProjType ./script/phpmig migrate_dist  2>/tmp/rundeck_migrate_errinfo  
    else
    	ENV=$ProjType ./script/phpmig migrate  2>/tmp/rundeck_migrate_errinfo  
    fi
    if [[ $? == 0 ]]; then
	RestartResque
        local MigStat=`CheckMigrate`
        if [[ $MigStat == "" ]]; then
            echo ""
            echo "Migrate status is OK !"
	    echo -e "\033[31m" "迁移状态全部为up！！" "\033[0m"
        else
            echo ""
	    echo -e "\033[31m" "迁移状态有down！！" "\033[0m"
        fi
    else
        echo ""
	echo -e "\033[31m" "迁移报错，请检查参数输入，或者联系中台处理！！" "\033[0m"
        echo "------------------------------------------------------"
        cat /tmp/rundeck_migrate_errinfo
        exit 1
    fi
    cd - 1>/dev/null 2>&1
fi
}

function MigrateOne () {
local _Env=$1
local _MigrationID=$2
cd $ProjPath
echo ""
echo "Down migration $_MigrationID ..."
if [ "${_Env}" == "qycloud" ];then
       ENV=$ProjType ./script/phpmig down_dist $_MigrationID 1>/dev/null 2>/tmp/rundeck_migrate_errinfo
   else
       ENV=$ProjType ./script/phpmig down $_MigrationID 1>/dev/null 2>/tmp/rundeck_migrate_errinfo
fi
if [[ $? == 0 ]]; then
    echo ""
    echo "Down migration $_MigrationID is OK !"
    echo ""
    echo "Starting migration $_MigrationID ..."
    ENV=$ProjType ./script/phpmig up $_MigrationID  2>/tmp/rundeck_migrate_errinfo
    if [[ $? == 0 ]]; then
        echo ""
        echo "Start migration $_MigrationID is OK !"
    else
        echo ""
        echo "Starting migration $_MigrationID is Fail !"
        echo "------------------------------------------------------"
        cat /tmp/rundeck_migrate_errinfo
        exit 1
    fi
else
    echo ""
    echo "Down migration $_MigrationID is Fail !"
    echo "------------------------------------------------------"
    cat /tmp/rundeck_migrate_errinfo
    exit 1
fi
}

function AutoMigrate {
local tempDBStatus=`TempDBStatus "$DBId"`
local nowHour=`date -u +%H`
if [[ $tempDBStatus == "Running" ]]; then
#与 ext/manageTempDB.php 中第170行规定时间相符
    if [[ $nowHour > 12 && $nowHour < 22 ]]; then
    local PID=`ps -ef | grep "script/phpmig migrate" | grep -v "grep" | awk '{print $2}'`
        if [[ ! -n $PID ]]; then
            echo `date +%y%m%d%H%M` >> $LogPath/automigrate.log
            echo "-----------------------------------------" >> $LogPath/automigrate.log
            MigrateAll 2>>$LogPath/automigrate.log
            echo "" >> $LogPath/automigrate.log
        fi
    else
        echo "Time is Not allow"
    fi
fi
}
