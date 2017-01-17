function RunGulp {
GulpFiles=$1
echo ""
echo "Running gulp ..."
sed -i "s/minAssets'.*/minAssets' => false,/" $ProjConfPath/assets.php
#sudo -u $runuser /usr/bin/env TERM=xterm rbuild -rf 1>/dev/null
	if [ -e public/gulpfile.js ];then

		 node -v|grep v0 > /dev/null 2>&1

		[ $? -eq 0 ] && echo "please update server's node version" && exit 1 
               
                which gulp > /dev/null 2>&1
 
               [ ! $? -eq 0 ] && echo "please install gulp environment" && exit 1

	       cd  public 
           
               echo ""

               echo "update node modules...."                 
 
               npm --registry=https://registry.npm.taobao.org  i  > /dev/null 2>&1

	       echo ""
		
               echo "start gulp ....."
 
               echo $GulpFiles|egrep "\.js|\.json"
	        
               gulp js >/dev/null 2>&1

               echo $GulpFiles|egrep "\.css|\.scss"

	       gulp css  >/dev/null 2>&1
		
	  else

	    /usr/bin/env TERM=xterm /usr/bin/frontBuild -b 1>/dev/null
	fi
if [[ $? == 0 ]]; then
    echo ""
    echo "Gulp is OK !"
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
    local minAssets=`cat $ProjConfPath/assets.php | grep "minAssets" | grep "true"`
    if [[ $minAssets != "" ]]; then
        local NeedGulp=`git diff $_CommitID | grep "diff --git a" | awk '{print $4}' | cut -c 3- | egrep "\.js|\.css|\.scss|\.json"`
        if [[ $NeedGulp != "" ]]; then
            RunGulp $NeedGulp
        else
            echo ""
            echo "No .js or .css !"
        fi
    else
        echo ""
        echo "Not need to run gulp !"
    fi
fi
cd - 1>/dev/null 2>&1
}
