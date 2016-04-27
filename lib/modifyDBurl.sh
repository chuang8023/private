function modifyDBurl () {
local _DBUrl=$1
local _IsCheck=$2

if [[ $_DBUrl != "" ]]; then
    echo ""
    echo "Modify database URL ..."
    local DBNum=$(grep -n "'servers'  => \[" $ProjConfPath/database.php | awk -F":" '{print $1}')
    local DBNum=$((${DBNum} + 3))
    sed -i "${DBNum},/,/s/'host.*/'host'     => '$_DBUrl',/" $ProjConfPath/database.php
    if [[ $_IsCheck == "check" ]]; then
        cd $ProjPath
        ENV=$ProjType ./script/phpmig status 1>/dev/null 2>/tmp/rundeck_modify_errinfo
        if [[ $? == 0 ]]; then
            echo ""
            echo "Modify database URL is OK !"
        else
            echo ""
            echo "Modify database URL is Fail !"
            echo "--------------------------------------------"
            cat /tmp/rundeck_modify_errinfo
            exit 1
        fi
        cd - 1>/dev/null 2>&1
    fi
fi
}
