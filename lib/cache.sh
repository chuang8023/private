function Cache () {
_Option=$1

cd $ProjPath
case $_Option in
"rebuild_org_tree")
if [[ $Ent == "" ]]; then
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
    echo "rebuilding $Ent org tree ..."
    ./vendor/phing/phing/bin/phing rebuild_org_tree 1>/dev/null << EOF
1
$Ent
EOF
echo ""
echo "rebuild $Ent org tree is OK !"
fi
;;
"rebuild_to_redis")
if [[ $Ent != "" ]]; then
    echo ""
    echo "rebuilding $Ent to redis"
    ./vendor/phing/phing/bin/phing rebuild_to_redis 1>/dev/null << EOF
5
$Ent
EOF
echo ""
echo "rebuild $Ent to redis is OK !"
else
    echo ""
    echo "Enterprise name cannot be empty !"
    exit 1
fi
;;
esac
cd - 1>/dev/null 2>&1
}
