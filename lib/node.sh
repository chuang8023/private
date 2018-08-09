function PullNode () {
echo ""
echo "$NodeBranchName pulling the new node code ..."
cd $NodePath
git pull --rebase origin master 1>/dev/null 2>/tmp/rundeck_code_errinfo
if [[ $? == 0 ]]; then
find . -user root -exec chown $runuser:$runuser {} \;
    echo ""
    echo "$NodeBranchName pull the new node code is OK !"
    cd - 1>/dev/null 2>&1
else
    echo ""
    echo "$NodeBranchName pull the new node code is Fail !"
    echo "---------------------------------------------"
    cat /tmp/rundeck_code_errinfo
    exit 1
fi
}


function BuildNode () {
echo ""
echo "$NodeBranchName build the  node code ..."
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
NODE_ENV="production" npm run static 1>/dev/null 2>/tmp/rundeck_code_errinfo
if [[ $? == 0 ]]; then
find . -user root -exec chown $runuser:$runuser {} \;
    echo ""
    echo "$NodeBranchName build  node code is OK !"
    cd - 1>/dev/null 2>&1
else
    echo ""
    echo "$NodeBranchName build node code is Fail !"
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






###新node
function PullNodeNew () {
echo ""
echo "$NodeBranchName pulling the new node code ..."
cd $NodePath
git pull --rebase origin $NodeBranchName 1>/dev/null 2>/tmp/rundeck_code_errinfo
if [[ $? == 0 ]]; then
find . -user root -exec chown $runuser:$runuser {} \;
    echo ""
    echo "$NodeBranchName pull the new node code is OK !"
    cd - 1>/dev/null 2>&1
else
    echo ""
    echo "$NodeBranchName pull the new node code is Fail !"
    echo "---------------------------------------------"
    cat /tmp/rundeck_code_errinfo
    exit 1
fi
}

#function RestartNodeNew () {
#	server_domain=`echo "$ProjPath" |awk -F"/" '{print $4}'`
#	echo "开始重启node服务"
#	cd $NodePath
#	npm run stop
#	[ $? -eq 0 ] && echo "node已停止" && npm start
#        [ $? -eq 0 ] && echo "node 已重启"
#}
#
#
#function BuildNodeNew () {
#echo ""
#echo "$NodeBranchName build the  node code ..."
#cd $NodePath
#npm run build-static 1>/dev/null 2>/tmp/rundeck_code_errinfo
#if [[ $? == 0 ]]; then
#find . -user root -exec chown $runuser:$runuser {} \;
#    echo ""
#    echo "$NodeBranchName build  node code is OK !"
#    cd - 1>/dev/null 2>&1
#else
#    echo ""
#    echo "$NodeBranchName build node code is Fail !"
#    echo "---------------------------------------------"
#    cat /tmp/rundeck_code_errinfo
#    exit 1
#fi
#}
####新node重启＆打包
function RestartNodeNew () {
        server_domain=`echo "$ProjPath" |awk -F"/" '{print $4}'`
        echo "开始重启node服务"
        cd $NodePath
        #npm run stop
        #[ $? -eq 0 ] && echo "node已停止" &&  npm start 
        npm run deploy
        [ $? -eq 0 ] && echo "node 已重启"
}

function BuildNodeNew () {
local _OldNodeCommitID=$1
echo ""
echo "$NodeBranchName build the  node code ..."
cd $NodePath

if [ "$_OldNodeCommitID" == "-f" ];then
        npm run build-static 1>/dev/null 2>/tmp/node_build.log
else
        for i in `cat /root/scripts/rundeck/config/nodepublic.log`
        do
                #git diff $_OldNodeCommitID | grep "diff --git a" | awk -F"/" '{print $4}' | grep -m 1 "$i"  > /dev/null 2>&1
                tag=`git diff $_OldNodeCommitID | grep "diff --git a" | awk -F"/" '{print $4}' | grep -m 1 "$i"`
                #[ $? -eq 0 ] && npm run build-static $i 1>/dev/null 2>/tmp/node_build.log
                echo $tag
                if [ "$i" == "$tag" ];then
                        echo "开始打包 $i"
                        npm run build-static $i >>/tmp/node_build.log
                fi
        done

        npm run build-static web 1>/dev/null 2>>/tmp/node_build.log
        npm run build-static wap 1>/dev/null 2>>/tmp/node_build.log
        npm run build-static framework 1>/dev/null 2>>/tmp/node_build.log
        [ $? -eq 0 ] && echo "打包成功"
fi
if [[ $? == 0 ]]; then
find . -user root -exec chown $runuser:$runuser {} \;
    echo ""
    echo "$NodeBranchName build  node code is OK !"
    cd - 1>/dev/null 2>&1
else
    echo ""
    echo "$NodeBranchName build node code is Fail !"
    echo "---------------------------------------------"
    cat /tmp/rundeck_code_errinfo
    exit 1
fi
}
