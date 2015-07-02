function EchoGitLog {
cd $ProjPath
CommitID=`git log | head -n 1 | awk '{print $2}'`
echo ""
echo "Commit id is $CommitID before update ."
LastLog=`cat $DataPath/pullog | grep "$ProjName" | tail -n 1 | awk -F"|" '{print $3}'`
if [[ $LastLog != $CommitID ]]; then
    echo "$ProjName|$TimeStamp|$CommitID" >> $DataPath/pullog
fi
}

function ShowGitLog {
echo ""
echo "Last 10 git log :"
echo "=================================================="
cat $DataPath/pullog | grep "$ProjName" | tail -n 10
}
