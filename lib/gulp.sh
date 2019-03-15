function RunGulp {
GulpFiles=$1
local _Envirment=$2

echo ""
echo "Running gulp ..."
#sudo -u $runuser /usr/bin/env TERM=xterm rbuild -rf 1>/dev/null
if [ "${_Envirment}" == "qycloud" ];then
       sed -i "s/minAssets:.*/minAssets: false/" $ProjConfPath/assets.yml
   else
       sed -i "s/minAssets'.*/minAssets' => false,/" $ProjConfPath/assets.php
fi
if [ -e public/gulpfile.js ];then
	node -v|grep v0 > /dev/null 2>&1
	[ $? -eq 0 ] && echo "update server's node version" && apt-get install nodejs 
	which gulp > /dev/null 2>&1
	[ $? -eq 1 ] && echo "install gulp environment" && npm --registry=https://registry.npm.taobao.org  i gulp -g
	cd  $ProjPath/public 
	                 
	#NODE_DEV="development" npm --registry=https://registry.npm.taobao.org  i  > /dev/null 2>&1
	##设置npm使用淘宝源
        npm config set registry https://registry.npm.taobao.org
        which cnpm > /dev/null 2>&1
	[ $? -eq 1 ] && echo "install cnpm" && npm install -g cnpm --registry=https://registry.npm.taobao.org 
	echo "update node modules...."
	NODE_DEV="development" cnpm i
	
	cd ..
	echo "start gulp ....."
        chown -R $runuser:$runuser $ProjPath/
	gulp ge --cwd=public
              # echo $GulpFiles|egrep "\.js|\.json"
              # gulp js >/dev/null 2>&1
              # echo $GulpFiles|egrep "\.css|\.scss"
	      # gulp css  >/dev/null 2>&1
	if [ $? -eq 1 ];then
		chown -R anyuan:anyuan /tmp/grunt.json
	    	/usr/bin/env TERM=xterm /usr/bin/frontBuild -b 1>/dev/null
	fi
fi
if [ "${_Envirment}" == "qycloud" ];then
       sed -i "s/minAssets:.*/minAssets: true/" $ProjConfPath/assets.yml
   else
       sed -i "s/minAssets'.*/minAssets' => true,/" $ProjConfPath/assets.php
fi

if [[ $? == 0 ]];then
    echo ""
    echo "Gulp is OK !"
else
    echo ""
    echo "It looks like something wrong when run gulp !"
    echo "压缩运行报错，请联系运维处理！！！"
    exit 1
    
fi
ChangePullOwn
}

function Rgulp () {
local _CommitID=$1
local _Env=$2

cd $ProjPath
if [ "${_Env}" == "qycloud" ];then
       sed -i "s/minAssets:.*/minAssets: false/" $ProjConfPath/assets.yml
   else
       sed -i "s/minAssets'.*/minAssets' => false,/" $ProjConfPath/assets.php
fi
if [[ $1 == "-f" ]]; then
    RunGulp ${_CommitID} ${_Env}
else
    local NeedGulp=`git diff $_CommitID | grep "diff --git a" | awk '{print $4}' | cut -c 3- | egrep "\.js|\.css|\.scss|\.json|\.vue"`
    if [[ $NeedGulp != "" ]]; then
        RunGulp $NeedGulp ${_Env}
    else
        echo ""
        echo "No .js or .css or .vue!"
    fi
fi
if [ "${_Env}" == "qycloud" ];then
    sed -i "s/minAssets:.*/minAssets: true/" $ProjConfPath/assets.yml
else
    sed -i "s/minAssets'.*/minAssets' => true,/" $ProjConfPath/assets.php
fi
cd - 1>/dev/null 2>&1
}
