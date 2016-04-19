function RunRbuild {
echo ""
echo "Running rbuild ..."
sed -i "s/minAssets'.*/minAssets' => false,/" $ProjConfPath/assets.php
#sudo -u $runuser /usr/bin/env TERM=xterm rbuild -rf 1>/dev/null
sudo -u root /usr/bin/env TERM=xterm /usr/bin/front -rf 1>/dev/null
if [[ $? == 0 ]]; then
    echo ""
    echo "Rbuild is OK !"
else
    echo ""
    echo "It looks like something wrong when run rbuild !"
fi
sed -i "s/minAssets'.*/minAssets' => true,/" $ProjConfPath/assets.php
}

function Rbuild () {
local _CommitID=$1

cd $ProjPath
if [[ $1 == "-f" ]]; then
    RunRbuild
else
    local minAssets=`cat $ProjConfPath/assets.php | grep "minAssets" | grep "true"`
    if [[ $minAssets != "" ]]; then
        local NeedRbuild=`git diff $_CommitID | grep "diff --git a" | awk '{print $4}' | cut -c 3- | egrep "\.js|\.css"`
        if [[ $NeedRbuild != "" ]]; then
            RunRbuild
        else
            echo ""
            echo "No .js or .css !"
        fi
    else
        echo ""
        echo "Not need to run rbuild !"
    fi
fi
cd - 1>/dev/null 2>&1
}
