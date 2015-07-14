function modifyDBurl {
if [[ $DBUrl != "" ]]; then
    echo ""
    echo "Modify database URL ..."
    cd $ProjPath
    sed -i "s/'host'.*/'host' => '$DBUrl',/" $ProjConfPath/database.php
    cd $ProjPath
    ./script/phpmig status 1>/dev/null 2>&1
    if [[ $? == 0 ]]; then
        echo ""
        echo "Modify database URL is OK !"
    else
        echo ""
        echo "Modify database URL is Fail !"
        exit 1
    fi
    cd - 1>/dev/null 2>&1
fi
}
