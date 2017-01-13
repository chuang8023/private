function StopWebsocket {
echo ""
echo "Stopping websocket ..."
cd $ProjPath
sudo -u $runuser /usr/bin/env TERM=xterm ENV=$ProjType ./deploy/websocket stop 1>/dev/null
}

function StartWebsocket {
echo ""
echo "Starting websocket ..."
cd $ProjPath
sudo -u $runuser /usr/bin/env TERM=xterm ENV=$ProjType ./deploy/websocket start 1>/dev/null
}

