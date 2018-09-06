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
        #exit 1
    fi
fi
cd - 1>/dev/null 2>&1
}

#####show 新node分支
function ShowNodeBranch {
echo ""
echo "The current branch :"
echo "-------------------------"
echo $NodeBranchName 
}

####新node切换分支
function ChkoutNodeBranch () {
local _OptionNode=$1
ShowNodeBranch
NodeGitStatus
cd $NodePath
local _nodebranch=`git branch | grep "*"|awk '{print $2}' |sed 's/ //g'`
echo ""
if [[ $_OptionNode == "all" ]]; then
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
    echo "Checkout to $_OptionNode ..."
    if [ ${_nodebranch} != ${_OptionNode} ];then
	    git fetch origin $_OptionNode:$_OptionNode 1>/dev/null 2>/tmp/rundeck_branch_errinfo
    	    git checkout $_OptionNode
    else
	echo "您当前就在$_OptionNode分支上！！！"
    	git checkout $_OptionNode
    fi
    if [[ $? == 0 ]]; then
        ChangePullOwn
        echo ""
        echo "Checkout to $_OptionNode is OK !"
    else
        echo ""
        echo "Checkout to $_OptionNode is Fail !"
        echo "--------------------------------------"
        cat /tmp/rundeck_branch_errinfo
        exit 1
    fi
fi
cd - 1>/dev/null 2>&1
}
