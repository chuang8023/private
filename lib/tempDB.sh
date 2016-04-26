function CreateTempDB () {
local _DBId=$1
local _DBUrl="$(php $(cd `dirname $0`;pwd)/ext/manageTempDB.php $_DBId createTempDB).mysql.rds.aliyuncs.com"
local _IsSuccess=`echo $_DBUrl | grep "^sub"`   #后期可以把判断条件换成ping
if [[ $_IsSuccess != "" ]]; then
    modifyDBurl "${_DBUrl/_/-}" "nocheck"
    echo "Create temp database successfully !"
    echo "use function \"View temporary instance status\""
    echo "when the status is \"Running\", run migrate"
fi
}

function DeleteTempDB () {
local _DBId=$1
php $(cd `dirname $0`;pwd)/ext/manageTempDB.php $_DBId deleteTempDB
}

function AutoTempDB () {
local _DBId=$1
local _DBUrl="$(php $(cd `dirname $0`;pwd)/ext/manageTempDB.php $_DBId).mysql.rds.aliyuncs.com"
local _IsSuccess=`echo $_DBUrl | grep "^sub"`    #后期可以把判断条件换成ping
if [[ $_IsSuccess != "" ]]; then
    modifyDBurl "${_DBUrl/_/-}" "nocheck"
fi
}

function TempDBStatus () {
local _DBId=$1
local _Status=$(php $(cd `dirname $0`;pwd)/ext/manageTempDB.php $_DBId tempDBStatus)
if [[ $_Status != "" ]]; then
    echo $_Status
else
    echo "Cannot get temp database status !"
    exit 1
fi
}

function TempDBExpireTime () {
local _DBId=$1
local _Time=$(php $(cd `dirname $0`;pwd)/ext/manageTempDB.php $_DBId expireTime)
if [[ $_Time != "" ]]; then
    echo $_Time
else
    echo "Cannot get temp database expire time !"
    exit 1
fi
}
