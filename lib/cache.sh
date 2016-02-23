function Cache () {
_Ent=$1
_Option=$2

cd $ProjPath
case $_Option in
"rebuild_org_tree")
if [[ $_Ent == "" ]]; then
    echo ""
    echo "rebuilding all enterprise org tree ..."
    ./vendor/phing/phing/bin/phing rebuild_org_tree 1>/dev/null << EOF
1
all
EOF
echo ""
echo "rebuild all enterprise org tree is OK !"
else
    echo ""
    echo "rebuilding $_Ent org tree ..."
    ./vendor/phing/phing/bin/phing rebuild_org_tree 1>/dev/null << EOF
1
$_Ent
EOF
echo ""
echo "rebuild $_Ent org tree is OK !"
fi
;;
"rebuild_to_redis")
if [[ $_Ent != "" ]]; then
    echo ""
    echo "rebuilding $_Ent to redis"
    ./vendor/phing/phing/bin/phing rebuild_to_redis 1>/dev/null << EOF
5
$_Ent
EOF
echo ""
echo "rebuild $_Ent to redis is OK !"
else
    echo ""
    echo "Enterprise name cannot be empty !"
    exit 1
fi
;;
esac
cd - 1>/dev/null 2>&1
unset _Option
}

function CleanUserChatToken {
echo ""
echo "deleting table sys_user_chat_token ..."
DB=`cat $ProjConfPath/database.php | grep -w -m 1 dbname | awk -F "'" '{print $4}'`
USER=`${DBCONF}|grep -w -m 1 user | awk -F "'" '{print $4}'`
HOST=`${DBCONF}|grep -w -m 1 host | awk -F "'" '{print $4}'`
PASS=`${DBCONF}|grep -w -m 1 password | awk -F "'" '{print $4}'`
mysql -u${USER} -p${PASS} -h${HOST} -e "use ${DB};truncate sys_user_chat_token;"
echo ""
echo "delete table sys_user_chat_token is OK !"
}

