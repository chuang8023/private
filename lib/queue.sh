function ChkStopResque () {
local Queue=`ENV=$ProjType ./deploy/$QueueName status | grep -i "running"`

if [[ $Queue = "" ]]; then
    echo ""
    echo "Stop Queue is OK !"
    if [ $QueueName = "queue" ]; then
           ENV=$ProjType ./deploy/$QueueName start 1>/dev/null
      else
          sudo -u $runuser /usr/bin/env TERM=xterm ENV=$ProjType ./deploy/$QueueName start 1>/dev/null
   fi

    local Queue=`ENV=$ProjType ./deploy/$QueueName status | grep -i "running"`

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
    if [ $QueueName = "queue" ]; then
           ENV=$ProjType ./deploy/$QueueName stop 1>/dev/null << EOF  
Y
EOF
      else
	   sudo -u $runuser /usr/bin/env TERM=xterm ENV=$ProjType ./deploy/$QueueName stop 1>/dev/null
	   sleep 2
	   sudo -u $runuser /usr/bin/env TERM=xterm ENV=$ProjType ./deploy/$QueueName stop 1>/dev/null
	   sleep 2
           sudo -u $runuser /usr/bin/env TERM=xterm ENV=$ProjType ./deploy/$QueueName stop 1>/dev/null
   fi
if [[ $? = 0 ]]; then
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
ENV=$ProjType ./deploy/$QueueName status
cd - 1>/dev/null 2>&1
}
