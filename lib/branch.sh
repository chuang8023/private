function ShowBranch {
echo ""
echo "The current branch :"
echo "-------------------------"
echo $BranchName
}

function ChkoutBranch () {
_Option=$1

ShowBranch

cd $ProjPath
echo ""
echo "The current git status:"
echo "--------------------------"
git status

echo ""
echo "Stash away changes to dirty working directory now ..."
git stash
echo ""
if [[ $? == 0 ]]; then
    echo "Stash is OK !"
else
    echo "Stash is Fail !"
    exit 1
fi

echo ""
echo "Checkout to $_Option ..."
git fetch origin $_Option 1>/dev/null 2>&1 &&
git checkout $_Option &&
git pull --rebase origin $_Option 1>/dev/null 2>&1
echo ""
if [[ $? == 0 ]]; then
    ChangePullOwn
    echo "Checkout to $_Option is OK !"
else
    echo "Checkout to $_Option is Fail !"
    exit 1
fi
cd - 1>/dev/null 2>&1
}
