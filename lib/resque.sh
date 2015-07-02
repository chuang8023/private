function ChkResque {
Resque1=`./deploy/resque status | grep "Resque:default" | grep "stopped"`
Resque2=`./deploy/resque status | grep "Resque:rules_engine" | grep "stopped"`
if [[ $Resque1 != "" && $Resque2 != "" ]]; then
    echo ""
    echo "Stop resque is OK !"
    sudo -u $runuser /usr/bin/env TERM=xterm ./deploy/resque start 1>/dev/null
    Resque1=`./deploy/resque status | grep "Resque:default" | grep "running"`
    Resque2=`./deploy/resque status | grep "Resque:rules_engine" | grep "running"`
    if [[ $Resque1 != "" && $Resque2 != "" ]]; then
        echo ""
        echo "Start resque is Ok !"
    else
        echo ""
        echo "Start resque is Fail !"
    fi
fi
}

function Resque {
echo ""
echo "Restarting resque ..."
cd $ProjPath
./deploy/resque stop 1>/dev/null
./deploy/resque stop 1>/dev/null
./deploy/resque stop 1>/dev/null
ChkResque
if [[ $Resque1 == "" || $Resque2 == "" ]]; then
    PIDNum=(`ps -ef | grep -v "grep" | grep "resque" | grep "$ProjRealPath" | awk '{print $2}'`)
    for (( i=0;i<${#PIDNum[*]};i++ ))
    do
        kill -9 ${PIDNum[i]} 2>/dev/null
    done
fi
ChkResque
cd - 1>/dev/null 2>&1
}
