function RunGulp {
GulpFiles=$1
echo ""
echo "Running gulp ..."
sed -i "s/minAssets'.*/minAssets' => false,/" $ProjConfPath/assets.php
#sudo -u $runuser /usr/bin/env TERM=xterm rbuild -rf 1>/dev/null
if [ -e public/gulpfile.js ];then
	node -v|grep v0 > /dev/null 2>&1
	[ $? -eq 0 ] && echo "update server's node version" && apt-get install nodejs 
	which gulp > /dev/null 2>&1
	[ $? -eq 1 ] && echo "install gulp environment" && npm --registry=https://registry.npm.taobao.org  i gulp -g
	cd  $ProjPath/public 
	echo "update node modules...."                 
	npm --registry=https://registry.npm.taobao.org  i  > /dev/null 2>&1
	cd ..
	echo "start gulp ....."
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
if [[ $? == 0 ]];then
    echo ""
    echo "Gulp is OK !"
    echo -e "\033[31m" "项目访问地址为：`cat $ProjConfPath/app.php | grep "www_domain" | awk -F"=>" '{print $2}' | awk 'gsub(/^ *| *$/,"")' | sed "s/'//g" | sed "s/,$//"`" "\033[0m"
    

else
    echo ""
    echo "It looks like something wrong when run gulp !"
fi
sed -i "s/minAssets'.*/minAssets' => true,/" $ProjConfPath/assets.php
ChangePullOwn
}

function Rgulp () {
local _CommitID=$1

cd $ProjPath
if [[ $1 == "-f" ]]; then
    RunGulp
else
    local NeedGulp=`git diff $_CommitID | grep "diff --git a" | awk '{print $4}' | cut -c 3- | egrep "\.js|\.css|\.scss|\.json|\.vue"`
    if [[ $NeedGulp != "" ]]; then
        RunGulp $NeedGulp
    else
        echo ""
        echo "No .js or .css or .vue!"
    fi
    sed -i "s/minAssets'.*/minAssets' => true,/" $ProjConfPath/assets.php
fi
cd - 1>/dev/null 2>&1
}
