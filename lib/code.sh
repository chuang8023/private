function PullCode {
echo ""
echo "$BranchName pulling the new code ..."
cd $ProjPath
git checkout .
git pull --rebase origin $BranchName 1>/dev/null 2>&1
if [[ $? == 0 ]]; then
    ChangePullOwn
    echo ""
    echo "$BranchName pull the new code is OK !"
    cd - 1>/dev/null 2>&1
else
    echo ""
    echo "$BranchName pull the new code is Fail !"
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
find $ProjPath -user root -exec chown $runuser:$runuser {} \;
}

function RollbackCode {
if [[ $CommitID != "" ]]; then
    echo ""
    echo "$BranchName rollbacking code to $CommitID ..."
    cd $ProjPath
    git reset --hard $CommitID 1>/dev/null 2>&1
    if [[ $? == 0 ]]; then
        echo ""
        echo "$BranchName rollback code is OK !"
        echo "Now commit id is $CommitID"
        cd - 1>/dev/null 2>&1
    else
        echo ""
        echo "$BranchName rollback code is Fail !"
        echo "Now commit id is $CommitID"
        exit 1
    fi
else
    echo ""
    echo "Commit_ID is empty !"
    exit 1
fi
}
