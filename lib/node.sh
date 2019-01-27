###新node
function PullNodeNew () {
echo ""
echo "$NodeBranchName pulling the new node code ..."
cd $NodePath
local _nodebranch=`git branch | grep "*"|awk '{print $2}' |sed 's/ //g'`
#git pull --rebase origin ${_nodebranch} 1>/dev/null 2>/tmp/rundeck_code_errinfo
git pull origin ${_nodebranch} 1>/dev/null 2>/tmp/rundeck_code_errinfo
if [[ $? == 0 ]]; then
find . -user root -exec chown $runuser:$runuser {} \;
    echo ""
    echo "${_nodebranch} pull the new node code is OK !"
    cd - 1>/dev/null 2>&1
else
    echo ""
    echo "${_nodebranch} pull the new node code is Fail !"
    echo "---------------------------------------------"
    cat /tmp/rundeck_code_errinfo
    exit 1
fi
}

####新node重启＆打包
function RestartNodeNew () {
        echo "开始重启node服务"
        cd $NodePath
        npm run deploy
        [ $? -eq 0 ] && echo "node 已重启"
}

function BuildNodeNew () {
local _OldNodeCommitID=$1
echo ""
echo "$NodeBranchName build the  node code ..."
cd $NodePath

npm i 1>/dev/null 2>/tmp/node_build.log
if [ "$_OldNodeCommitID" == "-f" ];then
        npm run build-static 1>/dev/null 2>/tmp/node_build.log
        cd public/paas
        npm i > /dev/null 2>&1
        npm run ge > /dev/null 2>&1
else
    git diff $_OldNodeCommitID | grep "diff --git a" | grep "public/packages" >/dev/null 2>&1
    if [ $? -eq 0 ];then
        npm run build-static form view appmodule
    fi
    for i in `git diff $_OldNodeCommitID | grep "diff --git a" | grep "src" |grep -v "lego" | grep -v "cube" |awk -F"/" '{print $4 }'|uniq`
    do
        echo $i
        echo "开始打包 $i"
        npm run build-static $i >>/tmp/node_build.log
        if [ "$i" == "service" ];then
                npm run build-static view >>/tmp/node_build.log
                npm run build-static form >>/tmp/node_build.log
        fi
    done
    npm run build-static framework 1>/dev/null 2>>/tmp/node_build.log
    [ $? -eq 0 ] && echo "打包成功"
    git diff $_OldNodeCommitID | grep "diff --git a" | grep "/public/paas" 1>/dev/null 2>>/tmp/node_build.log
    if [ $? -eq 0 ];then
        cd $NodePath/public/paas
        npm i > /dev/null 2>&1
        npm run ge > /dev/null 2>&1
    fi
    [ $? -eq 0 ] && echo "paas打包成功"
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


###无忧node更新
#function RestartSafetyNode () {
#        echo "开始重启node服务"
#        cd $NodePath
#        node deploy.js
#        [ $? -eq 0 ] && echo "node 已重启"
#find . -user root -exec chown $runuser:$runuser {} \;
#}
