function StopWebsocket {
echo ""
echo "Stopping websocket ..."
cd $ProjPath
ENV=$ProjType ./deploy/websocket stop 1>/dev/null
}

function StartWebsocket {
echo ""
echo "Starting websocket ..."
cd $ProjPath
ENV=$ProjType ./deploy/websocket start 1>/dev/null
}

