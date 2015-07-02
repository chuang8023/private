function ShowMigrate {
cd $ProjPath
./script/phpmig status | grep -v "** MISSING **" | tail -n 30
cd - 1>/dev/null 2>&1
}

function CheckMigrate {
cd $ProjPath
#if [[ -f ./script/phpmig ]]; then
#   _MigStat=`./script/phpmig status | grep down`
#else
#    _MigStat=`./script/phpmig.php status | grep down`
#fi
./script/phpmig status | grep "20120822094445" 1>/dev/null
if [[ $? != 0 ]]; then
    echo "wrong"
fi

_MigStat=`./script/phpmig status | grep "down"`
if [[ $? == 0 ]]; then
    echo $_MigStat
fi
cd - 1>/dev/null 2>&1
unset _MigStat
}

function MigrateAll {
MigStat=`CheckMigrate`
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
    ./script/phpmig migrate 1>/dev/null 
    if [[ $? == 0 ]]; then
        MigStat=`CheckMigrate`
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

function MigrateOne {
cd $ProjPath
echo ""
echo "Down migration $MigrationID ..."
./script/phpmig down $MigrationID 1>/dev/null 2>&1
if [[ $? == 0 ]]; then
    echo ""
    echo "Down migration $MigrationID is OK !"
    echo ""
    echo "Starting migration $MigrationID ..."
    ./script/phpmig up $MigrationID 1>/dev/null 2>&1
    if [[ $? == 0 ]]; then
        echo ""
        echo "Start migration $MigrationID is OK !"
    else
        echo ""
        echo "Starting migration $MigrationID is Fail !"
        exit 1
    fi
else
    echo ""
    echo "Down migration $MigrationID is Fail !"
    exit 1
fi
}
