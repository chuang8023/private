function PullNode () {
echo ""
local NodeName=`git branch | grep "*" | awk '{print $2}'`
echo "$NodeName pulling the new node code ..."
cd $NodePath
git pull --rebase origin $NodeName 1>/dev/null 2>/tmp/rundeck_code_errinfo
if [[ $? == 0 ]]; then
find . -user root -exec chown $runuser:$runuser {} \;
    echo ""
    echo "$NodeName pull the new node code is OK !"
    cd - 1>/dev/null 2>&1
else
    echo ""
    echo "$NodeName pull the new node code is Fail !"
    echo "---------------------------------------------"
    cat /tmp/rundeck_code_errinfo
    exit 1
fi
}

function BuildNode () {
echo ""
echo "$NodeName build the  node code ..."
cd $NodePath
#if [[ $SHELL == "/bin/zsh" ]];then
#  cat ~/.zshrc|grep NODE_ENV
#  if [[ $? -ne 0 ]] ;then
#  echo 'export NODE_ENV="production"' >> ~/.zshrc
#  source ~/.zshrc
#  fi
#fi
#if [[ $SHELL == "/bin/bash" ]];then
#  cat ~/.bashrc|grep NODE_ENV
#  if [[ $? -ne 0 ]] ;then
#  echo 'export NODE_ENV="production"' >> ~/.bashrc
#  source ~/.bashrc
#  fi
#fi
npm run static 1>/dev/null 2>/tmp/rundeck_code_errinfo
if [[ $? == 0 ]]; then
find . -user root -exec chown $runuser:$runuser {} \;
    echo ""
    echo "$NodeName build  node code is OK !"
    cd - 1>/dev/null 2>&1
else
    echo ""
    echo "$NodeName build node code is Fail !"
    echo "---------------------------------------------"
    cat /tmp/rundeck_code_errinfo
    exit 1
fi
 }
 
function RestartPm2 () {
echo ""
echo "Restart pm2 ..."
cd $NodePath
pm2 restart all 1>/dev/null 2>/tmp/rundeck_code_errinfo
if [[ $? == 0 ]]; then
    echo ""
    echo " restart pm2  is OK !"
    cd - 1>/dev/null 2>&1
else
    echo ""
    echo "restart pm2 is Fail !"
    echo "---------------------------------------------"
    cat /tmp/rundeck_code_errinfo
    exit 1
fi
}

