function EchoPullLog {
if [[ $LastLog != $CommitID ]]; then
    echo "$ProjName|$TimeStamp|$CommitID" >> $DataPath/pullog
fi
}

function ShowPullLog {
echo ""
echo "Last 10 pull log :"
echo "=================================================="
cat $DataPath/pullog | grep "$ProjName" | tail -n 10
}

function GetPullLog {
cd $ProjPath
CommitID=`git log | head -n 1 | awk '{print $2}'`
echo ""
echo "Commit id is $CommitID before update ."
if [[ -f $DataPath/pullog ]]; then
    LastLog=`cat $DataPath/pullog | grep "$ProjName" | tail -n 1 | awk -F"|" '{print $3}'`
else
    LastLog=""
fi
cd - 1>/dev/null 2>&1
}
