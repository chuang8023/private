function OpenDebug () {
echo "Opening the debug ..."
sed -i "s/is_debug'.*/is_debug' => true,/" $ProjConfPath/app.php
 if [[ $? == 0 ]]; then
        echo ""
        echo "Open the debug is OK !"
    else
        echo ""
        echo "Open the debug is Fail !"
        exit 1
 }

function CloseDebug () {
echo "Closing the debug ..."
sed -i "s/is_debug'.*/is_debug' => false,/" $ProjConfPath/app.php
 if [[ $? == 0 ]]; then
        echo ""
        echo "Close the debug is OK !"
    else
        echo ""
        echo "Close the debug is Fail !"
        exit 1
}
