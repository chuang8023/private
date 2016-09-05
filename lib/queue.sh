function ChkStopResque () {
local Queue=`ENV=$ProjType ./deploy/pheanstalk status | grep "running"`

if [[ $Queue = "" ]]; then
    echo ""
    echo "Stop Queue is OK !"
    sudo -u $runuser /usr/bin/env TERM=xterm ENV=$ProjType ./deploy/pheanstalk start 1>/dev/null
    local Queue=`ENV=$ProjType ./deploy/pheanstalk status | grep "running"`

    if [[ $Queue != "" ]]; then
        echo ""
        echo "Start Queue is Ok !"
    else
        echo ""
        echo "Start Queue is Fail !"
    fi
fi
}

function RestartResque {
echo ""
echo "Restarting Queue ..."
cd $ProjPath
ENV=$ProjType ./deploy/pheanstalk stop 1>/dev/null
ENV=$ProjType ./deploy/pheanstalk stop 1>/dev/null
ENV=$ProjType ./deploy/pheanstalk stop 1>/dev/null
ChkStopResque
if [[ $Resque1 != "" ]]; then
    local PIDNum=(`ps -ef | grep -v "grep" | grep "pheanstalk" | grep "$ProjRealPath" | awk '{print $2}'`)
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
ENV=$ProjType ./deploy/pheanstalk status
cd - 1>/dev/null 2>&1
}
