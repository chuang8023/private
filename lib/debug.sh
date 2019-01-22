function OpenDebug () {
echo "Opening the debug ..."
sed -i "s/is_debug:.*/is_debug: true/" $ProjConfPath/app.yml
[ "$ProjType" == "production" ] || [ "$ProjType" == "development" ] && sed -i "s/\$debug = false;/\$debug = true;/" $ProjPath/bootstrap.php
 if [[ $? == 0 ]]; then
        echo ""
        echo "Open the debug is OK !"
    else
        echo ""
        echo "Open the debug is Fail !"
        exit 1
fi
 }

function CloseDebug () {
echo "Closing the debug ..."
sed -i "s/is_debug:.*/is_debug: false/" $ProjConfPath/app.yml
[ "$ProjType" == "production" ] || [ "$ProjType" == "development" ] && sed -i "s/\$debug = true;/\$debug = false;/" $ProjPath/bootstrap.php
 if [[ $? == 0 ]]; then
        echo ""
        echo "Close the debug is OK !"
    else
        echo ""
        echo "Close the debug is Fail !"
        exit 1
fi
}
