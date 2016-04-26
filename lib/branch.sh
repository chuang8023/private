function ShowBranch {
echo ""
echo "The current branch :"
echo "-------------------------"
echo $BranchName
}

function ChkoutBranch () {
local _Option=$1

ShowBranch
GitStatus
cd $ProjPath
echo ""
if [[ $_Option == "all" ]]; then
    echo "Drop all changes that are not saved ..."
    git checkout .
    if [[ $? == 0 ]]; then
        echo ""
        echo "OK !"
        GitStatus
    else
        echo ""
        echo "Fail !"
        exit 1
    fi
else
    echo "Checkout to $_Option ..."
    git fetch origin $_Option:$_Option 1>/dev/null 2>/tmp/rundeck_branch_errinfo &&
    git checkout $_Option
    if [[ $? == 0 ]]; then
        ChangePullOwn
        echo ""
        echo "Checkout to $_Option is OK !"
    else
        echo ""
        echo "Checkout to $_Option is Fail !"
        echo "--------------------------------------"
        cat /tmp/rundeck_branch_errinfo
        exit 1
    fi
fi
cd - 1>/dev/null 2>&1
}
