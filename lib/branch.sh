function ShowBranch {
echo ""
echo "The current branch :"
echo "-------------------------"
cd $ProjPath 
local _PaasBranch=`git branch | grep "*" |awk '{print $2}'|sed 's/ //g'`
echo "Pass端当前分支为："$_PaasBranch

cd $NodePath 
local _NodeBranch=`git branch | grep "*" |awk '{print $2}'|sed 's/ //g'`
echo "Node端当前分支为："$_NodeBranch

cd $OrgPath 
local _OrgBranch=`git branch | grep "*" |awk '{print $2}'|sed 's/ //g'`
echo "Org端当前分支为："$_OrgBranch
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
    git  clean -f
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
    git checkout .
    git  clean -f
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

function ChkoutNodeBranch () {
local _NodeBranch=$1
ShowBranch
GitStatus
cd $NodePath
echo ""
git checkout .
git  clean -f
echo "Checkout to $_NodeBranch ..."
git fetch origin $_NodeBranch:$_NodeBranch 1>/dev/null 2>/tmp/rundeck_branch_errinfo &&
git checkout $_NodeBranch
if [[ $? == 0 ]]; then
    ChangePullOwn
    echo ""
    echo "Checkout to $_NodeBranch is OK !"
else
    echo ""
    echo "Checkout to $_NodeBranch is Fail !"
    echo "--------------------------------------"
    cat /tmp/rundeck_branch_errinfo
    exit 1
fi
cd - 1>/dev/null 2>&1
}

function ChkoutOrgBranch () {
local _OrgBranch=$1
ShowBranch
GitStatus
cd $OrgPath
echo ""
git checkout .
git  clean -f
echo "Checkout to $_OrgBranch ..."
git fetch origin $_OrgBranch:$_OrgBranch 1>/dev/null 2>/tmp/rundeck_branch_errinfo &&
git checkout $_OrgBranch
if [[ $? == 0 ]]; then
    ChangePullOwn
    echo ""
    echo "Checkout to $_OrgBranch is OK !"
else
    echo ""
    echo "Checkout to $_OrgBranch is Fail !"
    echo "--------------------------------------"
    cat /tmp/rundeck_branch_errinfo
    exit 1
fi
cd - 1>/dev/null 2>&1
}
