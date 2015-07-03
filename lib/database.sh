function RunBackup {
echo ""
echo "Backuping database ..."
while read LINE
do
    _Key=`echo $LINE | grep "=>" | awk -F"=>" '{print $1}' | awk 'gsub(/^ *| *$/,"")' | sed "s/'//g"`
    case $_Key in
    "host")
        _Host=`echo $LINE | awk -F"=>" '{print $2}' | awk 'gsub(/^ *| *$/,"")' | sed "s/'//g" | sed "s/,$//"`
        ;;
    "port")
        _Port=`echo $LINE | awk -F"=>" '{print $2}' | awk 'gsub(/^ *| *$/,"")' | sed "s/'//g" | sed "s/,$//"`
        ;;
    "dbname")
        _DBName=`echo $LINE | awk -F"=>" '{print $2}' | awk 'gsub(/^ *| *$/,"")' | sed "s/'//g" | sed "s/,$//"`
        ;;
    "user")
        _DBUser=`echo $LINE | awk -F"=>" '{print $2}' | awk 'gsub(/^ *| *$/,"")' | sed "s/'//g" | sed "s/,$//"`
        ;;
    "password")
        _DBPasswd=`echo $LINE | awk -F"=>" '{print $2}' | awk 'gsub(/^ *| *$/,"")' | sed "s/'//g" | sed "s/,$//"`
        ;;
    esac
done < $ProjConfPath/database.php

if [[ $TimeStamp == "" ]]; then
    mysqldump -h"$_Host" -u"$_DBUser" -p"$_DBPasswd" $_DBName > $BackupDir${_DBName}_`date +%y%m%d%H%M%S`.sql
    _Status=$?
else
    mysqldump -h"$_Host" -u"$_DBUser" -p"$_DBPasswd" $_DBName > ${_DBName}_$TimeStamp.sql
    _Status=$?
fi
 
if [[ $_Status == 1 ]]; then
    echo ""
    echo "It looks like something wrong when backup database !"
    exit 1
else
    echo ""
    echo "Backup database is OK !"
fi
unset _Key
unset _Host
unset _Port
unset _DBName
unset _DBUser
unset _DBPasswd
unset _Status

}

function RunRollback {
echo ""
echo "Rollbacking database ..."
while read LINE
do
    _Key=`echo $LINE | grep "=>" | awk -F"=>" '{print $1}' | awk 'gsub(/^ *| *$/,"")' | sed "s/'//g"`
    case $_Key in
    "host")
        _Host=`echo $LINE | awk -F"=>" '{print $2}' | awk 'gsub(/^ *| *$/,"")' | sed "s/'//g" | sed "s/,$//"`
        ;;
    "port")
        _Port=`echo $LINE | awk -F"=>" '{print $2}' | awk 'gsub(/^ *| *$/,"")' | sed "s/'//g" | sed "s/,$//"`
        ;;
    "dbname")
        _DBName=`echo $LINE | awk -F"=>" '{print $2}' | awk 'gsub(/^ *| *$/,"")' | sed "s/'//g" | sed "s/,$//"`
        ;;
    "user")
        _DBUser=`echo $LINE | awk -F"=>" '{print $2}' | awk 'gsub(/^ *| *$/,"")' | sed "s/'//g" | sed "s/,$//"`
        ;;
    "password")
        _DBPasswd=`echo $LINE | awk -F"=>" '{print $2}' | awk 'gsub(/^ *| *$/,"")' | sed "s/'//g" | sed "s/,$//"`
        ;;
    esac
done < $ProjConfPath/database.php

TimeStamp=`cat $DataPath/pullog | grep $CommitID | tail -n 1 | awk -F"|" '{print $2}'`
if [[ -f ${_DBName}_$TimeStamp.sql ]]; then
    echo ""
    echo "Dropping database $_DBName ..."
    mysql -h"$_Host" -u"$_DBUser" -p"$_DBPasswd" -e "drop database $_DBName"
    if [[ $? == 0 ]]; then
        echo ""
        echo "Dropping database $_DBName is OK !"
        echo ""
        echo "Creating database $_DBName ..."
        mysql -h"$_Host" -u"$_DBUser" -p"$_DBPasswd" -e "create database $_DBName"
        if [[ $? == 0 ]]; then
            echo ""
            echo "Create database $_DBName is OK !"
            echo ""
            echo "Importing ${_DBName}_$TimeStamp.sql ..."
            mysql -h"$_Host" -u"$_DBUser" -p"$_DBPasswd" $_DBName < ${_DBName}_$TimeStamp.sql
            if [[ $? == 0 ]]; then
                echo ""
                echo "Import ${_DBName}_$TimeStamp.sql is OK !"
                echo ""
                echo "Rollback database is OK !"
            else
                echo ""
                echo "Import ${_DBName}_$TimeStamp.sql is Fail !"
                echo ""
                echo "Rollback database is Fail !"
            fi
        else
            echo ""
            echo "Create database $_DBName is Fail !"
            echo ""
            echo "Rollback database is Fail !"
        fi
    else
        echo ""
        echo "Dropping database $_DBName is Fail !"
        echo ""
        echo "Rollback database is Fail !"
    fi
else
    echo ""
    echo "Not find ${_DBName}_$TimeStamp.sql !"
    echo ""
    echo "Rollback database is Fail !"
fi
unset _Key
unset _Host
unset _Port
unset _DBName
unset _DBUser
unset _DBPasswd
unset _Status
}

function BackupDB () {
cd $ProjPath
if [[ $1 == "-f" ]]; then
    RunBackup
fi
NeedMigrate=`git diff $CommitID | grep "diff --git a/db/migrations/"`
if [[ $NeedMigrate != "" && $DBType == "base" ]]; then
    RunBackup
fi
cd - 1>/dev/null 2>&1
}

function RollbackDB {
cd $ProjPath
NeedMigrate=`git diff $CommitID | grep "diff --git a/db/migrations/"`
if [[ $NeedMigrate != "" && $DBType == "base" ]]; then
    RunRollback
fi
cd - 1>/dev/null 2>&1
}
