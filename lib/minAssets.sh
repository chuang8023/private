function MinAssets () {
local _Status=$1
local _Env=$2

if [[ $_Status == "close" ]]; then
    echo ""
    echo "Closing the minassets ..."
    if [ "${_Env}" == "qycloud" ];then
    	sed -i "s/minAssets:.*/minAssets: false/" $ProjConfPath/assets.yml
    else
	sed -i "s/minAssets'.*/minAssets' => false,/" $ProjConfPath/assets.php
    fi
    if [[ $? == 0 ]]; then
        echo ""
        echo "Close the minassets is OK !"
    else
        echo ""
        echo "Close the minassets is Fail !"
        exit 1
    fi
    ChangePullOwn
fi
if [[ $_Status == "open" ]]; then
    echo ""
    echo "Opening the minassets ..."
    if [ "${_Env}" == "qycloud" ];then
    	sed -i "s/minAssets:.*/minAssets: true/" $ProjConfPath/assets.yml
    else
	sed -i "s/minAssets'.*/minAssets' => true,/" $ProjConfPath/assets.php
    fi
    if [[ $? == 0 ]]; then
        echo ""
        echo "Open the minassets is OK !"
    else
        echo ""
        echo "Open the minassets is Fail !"
        exit 1
    fi
    ChangePullOwn
fi
}
