function ChkStopResque () {
local Queue=`ENV=$ProjType ./deploy/$QueueName status | grep -i "RUNNING"`

if [[ $Queue = "" ]]; then
    echo ""
    echo "Stop Queue is OK !"
    if [ $QueueName = "queue" ]; then
           ENV=$ProjType ./deploy/$QueueName start 1>/dev/null
      else
          sudo -u $runuser /usr/bin/env TERM=xterm ENV=$ProjType ./deploy/$QueueName start 1>/dev/null
   fi

    local Queue=`ENV=$ProjType ./deploy/$QueueName status | grep -i "RUNNING"`

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
local _Name=""
echo "Restarting Queue ..."
cd $ProjPath
    if [ $QueueName = "queue" ]; then
	  # rm -rf log/queue/*
	  # _Name=`cat config/$ProjType/app.php | grep "application_name" | awk '{print $3}' | sed "s/'//g" | sed "s/,//g"`
	  # rm -rf /etc/supervisor/conf.d/${_Name}_queue.conf
	  # ENV=$ProjType ./deploy/supervisor
           ENV=$ProjType ./deploy/$QueueName restart 1>/dev/null << EOF  
Y
EOF
   	   if [ $? -eq 1 ];then
		echo "重启队列失败，删除队列配置文件和队列日志，重新生成配置文件，重启supervisor"
	   	rm -rf log/queue/*
	  	_Name=`cat config/$ProjType/app.php | grep "application_name" | awk '{print $3}' | sed "s/'//g" | sed "s/,//g"`
	   	rm -rf /etc/supervisor/conf.d/${_Name}_queue.conf
	   	ENV=$ProjType ./deploy/supervisor
	   	sudo -u $runuser supervisorctl stop all 1>/dev/null
	   	sudo -u $runuser service supervisor restart 1>/dev/null
	   fi
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
