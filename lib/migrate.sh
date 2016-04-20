function ShowMigrate {
cd $ProjPath
ENV=$ProjType ./script/phpmig status | grep -v "** MISSING **" | tail -n 30
cd - 1>/dev/null 2>&1
}

function CheckMigrate {
cd $ProjPath
#if [[ -f ./script/phpmig ]]; then
#   _MigStat=`./script/phpmig status | grep down`
#else
#    _MigStat=`./script/phpmig.php status | grep down`
#fi
ENV=$ProjType ./script/phpmig status | grep "20120822094445" 1>/dev/null
if [[ $? != 0 ]]; then
    echo "wrong"
fi

local _MigStat=`ENV=$ProjType ./script/phpmig status | grep "down"`
if [[ $? == 0 ]]; then
    echo $_MigStat
fi
cd - 1>/dev/null 2>&1
}

function Migrate () {
local _ID=$1
if [[ $_ID == "all" ]]; then
    MigrateAll
else
    MigrateOne "$_ID"
fi
}

function MigrateAll {
local MigStat=`CheckMigrate`
if [[ $MigStat == "" ]]; then
    echo ""
    echo "Migrate status is OK !"
elif [[ $MigStat == "wrong" ]]; then
    echo ""
    echo "Migrate status is wrong !"
    exit 1
else
    echo ""
    echo "Running migrate ..."
    cd $ProjPath
    ENV=$ProjType ./script/phpmig migrate 1>/dev/null 
    if [[ $? == 0 ]]; then
        local MigStat=`CheckMigrate`
        if [[ $MigStat == "" ]]; then
            echo ""
            echo "Migrate status is OK !"
        else
            echo ""
            echo "Migrate is not all up !"
        fi
    else
        echo ""
        echo "It looks like something wrong when run migrate !"
        exit 1
    fi
    cd - 1>/dev/null 2>&1
fi
}

function MigrateOne () {
local _MigrationID=$1
cd $ProjPath
echo ""
echo "Down migration $_MigrationID ..."
ENV=$ProjType ./script/phpmig down $_MigrationID 1>/dev/null 2>/tmp/rundeck_errinfo
if [[ $? == 0 ]]; then
    echo ""
    echo "Down migration $_MigrationID is OK !"
    echo ""
    echo "Starting migration $_MigrationID ..."
    ENV=$ProjType ./script/phpmig up $_MigrationID 1>/dev/null 2>/tmp/rundeck_errinfo
    if [[ $? == 0 ]]; then
        echo ""
        echo "Start migration $_MigrationID is OK !"
    else
        echo ""
        echo "Starting migration $_MigrationID is Fail !"
        echo "------------------------------------------------------"
        cat /tmp/rundeck_errinfo
        exit 1
    fi
else
    echo ""
    echo "Down migration $_MigrationID is Fail !"
    echo "------------------------------------------------------"
    cat /tmp/rundeck_errinfo
    exit 1
fi
}
