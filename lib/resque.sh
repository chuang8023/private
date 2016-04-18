function ChkStopResque () {
local Resque1=`ENV=$ProjType ./deploy/resque status | grep "Resque:default" | grep "stopped"`
local Resque2=`ENV=$ProjType ./deploy/resque status | grep "Resque:rules_engine" | grep "stopped"`

if [[ $Resque1 != "" && $Resque2 != "" ]]; then
    echo ""
    echo "Stop resque is OK !"
    sudo -u $runuser /usr/bin/env TERM=xterm ENV=$ProjType ./deploy/resque start 1>/dev/null
    local Resque1=`ENV=$ProjType ./deploy/resque status | grep "Resque:default" | grep "running"`
    local Resque2=`ENV=$ProjType ./deploy/resque status | grep "Resque:rules_engine" | grep "running"`

    if [[ $Resque1 != "" && $Resque2 != "" ]]; then
        echo ""
        echo "Start resque is Ok !"
    else
        echo ""
        echo "Start resque is Fail !"
    fi
fi
}

function RestartResque {
echo ""
echo "Restarting resque ..."
cd $ProjPath
ENV=$ProjType ./deploy/resque stop 1>/dev/null
ENV=$ProjType ./deploy/resque stop 1>/dev/null
ENV=$ProjType ./deploy/resque stop 1>/dev/null
ChkStopResque
if [[ $Resque1 == "" || $Resque2 == "" ]]; then
    local PIDNum=(`ps -ef | grep -v "grep" | grep "resque" | grep "$ProjRealPath" | awk '{print $2}'`)
    for (( i=0;i<${#PIDNum[*]};i++ ))
    do
        kill -9 ${PIDNum[i]} 2>/dev/null
    done
fi
ChkStopResque
cd - 1>/dev/null 2>&1
}

function ResqueStat {
cd $ProjPath
echo ""
ENV=$ProjType ./deploy/resque status
cd - 1>/dev/null 2>&1
}
