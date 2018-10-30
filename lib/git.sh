function GitStatus {
cd $ProjPath
echo ""
echo "The current git status:"
echo "--------------------------"
git status
}

function GitStash {
cd $ProjPath
echo ""
echo "Stash away changes to dirty working directory now ..."
git stash
if [[ $? == 0 ]]; then
    echo ""
    echo "Stash is OK !"
else
    echo ""
    echo "Stash is Fail !"
    exit 1
fi
GitStatus
cd - 1>/dev/null 2>&1
}

function GitStashPop {
cd $ProjPath
echo ""
echo "Pop last stash now ..."
git stash pop
if [[ $? == 0 ]]; then
    echo ""
    echo "Stash pop is OK !"
else
    echo ""
    echo "Stash pop is Fail !"
    exit 1
fi
GitStatus
cd - 1>/dev/null 2>&1
}

###新node状态查看
function NodeGitStatus {
cd $NodePath
echo ""
echo "The current git status:"
echo "--------------------------"
git status
}
