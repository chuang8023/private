function modifyDBurl {
if [[ $DBUrl != "" ]]; then
    echo ""
    echo "Modify database URL ..."
    DBNum=$(sed -n "/'default' => array/=" $ProjConfPath/database.php)
    DBNum=$((${DBNum} + 1))
    sed -i "${DBNum},/)/s/'host.*/'host'     => '$DBUrl',/" $ProjConfPath/database.php
    cd $ProjPath
    ENV=$ProjType ./script/phpmig status 1>/dev/null 2>&1
    if [[ $? == 0 ]]; then
        echo ""
        echo "Modify database URL is OK !"
    else
        echo ""
        echo "Modify database URL is Fail !"
        exit 1
    fi
    unset DBNum
    cd - 1>/dev/null 2>&1
fi
}
