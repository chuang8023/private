function StopWebsocket {
echo ""
echo "Stopping websocket ..."
cd $ProjPath
sudo -u $runuser /usr/bin/env TERM=xterm ENV=$ProjType ./deploy/websocket stop 1>/dev/null
[ $? -eq 0 ] && echo "websocket 关闭成功!"
}

function StartWebsocket {
echo ""
echo "Starting websocket ..."
cd $ProjPath
sudo -u $runuser /usr/bin/env TERM=xterm ENV=$ProjType ./deploy/websocket start 1>/dev/null
[ $? -eq 0 ] && echo "websocket 开启成功!"
}

