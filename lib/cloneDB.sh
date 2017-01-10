function CreateCloneDB () {
local _DBId=$1
local _DBUrl="$(php $(cd `dirname $0`;pwd)/ext/manageCloneDB.php $_DBId createCloneDB).mysql.rds.aliyuncs.com"
local _IsSuccess=`echo $_DBUrl | grep "^sub"`   #后期可以把判断条件换成ping
if [[ $_IsSuccess != "" ]]; then
    echo "Create clone database successfully !"
    echo "Clone database URL is $_DBUrl"
fi
}

function ShowCloneDBUrl () {
local _DBId=$1
local _CloneDB=$(php $(cd `dirname $0`;pwd)/ext/manageCloneDB.php $_DBId showCloneDB)
if [[ $_CloneDB != "" ]]; then
    local _DBUrl="${_CloneDB}.mysql.rds.aliyuncs.com"
    local _IsSuccess=`echo $_DBUrl | grep "^sub"`    #后期可以把判断条件换成ping
    local _CloneDBStat=`CloneDBStatus "$_DBId"`
    if [[ $_IsSuccess != "" ]]; then
        if [[ $_CloneDBStat == "Running" ]]; then
            modifyDBurl "${_DBUrl/_/-}" "nocheck"
            echo "Clone database URL is $_DBUrl"
        else
            echo "Clone database's status is $_CloneDBStat !"
        fi
    else
        echo "The clone database URL \"$_CloneDBUrl\" is wrong !"
    fi
else
    echo "Clone database URL is NULL !"
fi
}

function DeleteCloneDB () {
local _DBId=$1
php $(cd `dirname $0`;pwd)/ext/manageCloneDB.php $_DBId deleteCloneDB
}

function AutoCloneDB () {
local _DBId=$1
local _DBUrl="$(php $(cd `dirname $0`;pwd)/ext/manageCloneDB.php $_DBId).mysql.rds.aliyuncs.com"
local _IsSuccess=`echo $_DBUrl | grep "^sub"`    #后期可以把判断条件换成ping
local _CloneDBStat=`CloneDBStatus "$_DBId"`
if [[ $_IsSuccess != "" && $_CloneDBStat == "Running" ]]; then
    modifyDBurl "${_DBUrl/_/-}" "nocheck"
fi
}

function CloneDBStatus () {
local _DBId=$1
local _Status=$(php $(cd `dirname $0`;pwd)/ext/manageCloneDB.php $_DBId cloneDBStatus)
if [[ $_Status != "" ]]; then
    echo $_Status
else
    echo "Cannot get clone database status !"
    exit 1
fi
}

function CloneDBExpireTime () {
local _DBId=$1
local _Time=$(php $(cd `dirname $0`;pwd)/ext/manageCloneDB.php $_DBId expireTime)
if [[ $_Time != "" ]]; then
    echo $_Time
else
    echo "Cannot get clone database expire time !"
    exit 1
fi
}
