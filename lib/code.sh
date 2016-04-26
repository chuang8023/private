function PullCode {
echo ""
echo "$BranchName pulling the new code ..."
cd $ProjPath
git checkout .
git pull --rebase origin $BranchName 1>/dev/null 2>/tmp/rundeck_errinfo
if [[ $? == 0 ]]; then
    ChangePullOwn
    echo ""
    echo "$BranchName pull the new code is OK !"
    cd - 1>/dev/null 2>&1
else
    echo ""
    echo "$BranchName pull the new code is Fail !"
    echo "---------------------------------------------"
    cat /tmp/rundeck_errinfo
    exit 1
fi
}

function ChangePullOwn {
#ChangeFile=(`git diff $CommitID | grep "diff --git a" | awk '{print $4}' | cut -c 3-`)
#for (( i=0;i<${#ChangeFile[*]};i++ ))
#do
#    chown $runuser:$runuser ${ChangeFile[i]} 2>/dev/null
#done
#chown -R $runuser:$runuser .git
find . -user root -exec chown $runuser:$runuser {} \;
}

function RollbackCode () {
local _CommitID=$1

if [[ $_CommitID != "" ]]; then
    echo ""
    echo "$BranchName rollbacking code to $_CommitID ..."
    cd $ProjPath
    git reset --hard $_CommitID 1>/dev/null 2>/tmp/rundeck_errinfo
    if [[ $? == 0 ]]; then
        echo ""
        echo "$BranchName rollback code is OK !"
        echo "Now commit id is $_CommitID"
        cd - 1>/dev/null 2>&1
    else
        echo ""
        echo "$BranchName rollback code is Fail !"
        echo "Now commit id is $_CommitID"
        echo "----------------------------------------------"
        cat /tmp/rundeck_errinfo
        exit 1
    fi
else
    echo ""
    echo "Commit_ID is empty !"
    exit 1
fi
}

function UpdateVendor {
cd $ProjPath
echo ""
echo "Updating vendor ..."
./script/vendor unpackaging
if [[ $? == 0 ]]; then
    echo ""
    echo "Update vendor is OK !"
else
    echo ""
    echo "Update vendor is fail !"
    exit 1
fi
cd - 1>/dev/null 2>&1
}
