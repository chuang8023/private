function Cache () {
local _Ent=$1
local _Option=$2
cd $ProjPath
case $_Option in
"rebuild_org_tree")
_Option=`ENV=$ProjType ./vendor/phing/phing/bin/phing -l | grep $_Option`
if [[ $_Ent == "" ]]; then
    echo ""
    echo "rebuilding all enterprise org tree ..."
    ENV=$ProjType ./vendor/phing/phing/bin/phing $_Option 1>/dev/null << EOF
1
all
EOF
echo ""
echo "rebuild all enterprise org tree is OK !"
else
    echo ""
    echo "rebuilding $_Ent org tree ..."
    ENV=$ProjType ./vendor/phing/phing/bin/phing $_Option 1>/dev/null << EOF
1
$_Ent
EOF
echo ""
echo "rebuild $_Ent org tree is OK !"
fi
;;
"rebuild_to_redis")
_Option=`ENV=$ProjType ./vendor/phing/phing/bin/phing -l | grep $_Option`
if [[ $_Ent != "" ]]; then
    echo ""
    echo "rebuilding $_Ent to redis"
    ENV=$ProjType ./vendor/phing/phing/bin/phing $_Option 1>/dev/null << EOF
2
$_Ent
EOF
    ENV=$ProjType ./vendor/phing/phing/bin/phing $_Option 1>/dev/null << EOF
1
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
}

function CleanUserChatToken () {
local _Option=$1

if [[ -n $_Option ]]; then
    echo ""
    echo "deleting table sys_user_chat_token ..."

    Local DB=`cat $ProjConfPath/database.yml | grep -w -m 1 dbname | awk -F":" '{print $2}'|sed "s/ //g"`
    Local USER=`cat $ProjConfPath/database.yml | grep -w -m 1 user | awk -F ":" '{print $2}'|sed "s/ //g"`
    Local HOST=`cat $ProjConfPath/database.yml | grep -w -m 1 host | awk -F ":" '{print $2}'|sed "s/ //g"`
    Local PASS=`cat $ProjConfPath/database.yml | grep -w -m 1 password | awk -F ":" '{print $2}'|sed "s/ //g"`
    mysql -u${USER} -p${PASS} -h${HOST} -e "use ${DB};truncate sys_user_chat_token;"
    if [ $? -eq 0 ];then
	echo "truncate table sys_user_chat_token is OK !"
    else
	echo "truncate清理token失败，改用delete清理token"
	mysql -u${USER} -p${PASS} -h${HOST} -e "use ${DB};delete from sys_user_chat_token;"
	if [ $? -eq 0 ];then
		echo "delete table sys_user_chat_token is OK !"
	fi	
    fi
fi
}
#使用CleanRedis或EmptyCache均能清空缓存，清空缓存后，需要使用Cache函数，重建组织架构缓存
function CleanRedis () {
echo "clean the project redis cache now ..."
#AppNamePath="$ProjPath/config/$ProjType/app.php"
#AppName=`cat $AppNamePath|grep application_name|awk -F "=>" '{print $2}'|sed 's/,//'`
#RedisPassPath="$ProjPath/config/$ProjType/redis.php"
#RedisPass=`cat $RedisPassPath|grep auth|awk -F "," '{print $1}'|awk -F "=>" '{print $2}'`
#RedisHost=`cat $RedisPassPath|grep default|awk -F "=>" '{print $2}'|sed 's/,//'|sed 's/:6379//'|sed "s/'//g"`
AppNamePath="$ProjPath/config/$ProjType/app.yml"
AppName=`cat $AppNamePath|grep "application_name" | awk -F":" '{print $2}'|sed "s/ //g"`
RedisPassPath="$ProjPath/config/$ProjType/redis.yml"
RedisPass=`cat $RedisPassPath|grep auth | awk -F":" '{print $2}' |sed "s/ //g"`
RedisHost=`cat $RedisPassPath|grep default | awk -F":" '{print $2}'|sed 's/ //'|sed "s/'//g"`
=======
AppNamePath="$ProjPath/config/$ProjType/app.yml"
AppName=`cat $AppNamePath|grep application_name|awk -F "=>" '{print $2}'|sed 's/,//'`
#RedisPassPath="$ProjPath/config/$ProjType/redis.php"
RedisPassPath="$ProjPath/config/$ProjType/redis.yml"
RedisPass=`cat $RedisPassPath|grep auth|awk -F "," '{print $1}'|awk -F "=>" '{print $2}'`
RedisHost=`cat $RedisPassPath|grep default|awk -F "=>" '{print $2}'|sed 's/,//'|sed 's/:6379//'|sed "s/'//g"`
redis-cli -p 6379 -h $RedisHost -a $RedisPass keys "$AppName*" | xargs redis-cli -p 6379 -h $RedisHost -a  $RedisPass del >> /dev/null
 if [[ $? == 0 ]]; then
        echo ""
        echo "clean the project redis cache is ok !"
    else
        echo ""
        echo "clean the project redis cache is fail !"
        exit 1
fi
 }

function EmptyCache () {
cd $ProjPath
local _Ent=$1
local _Option=$2
_Option=`ENV=$ProjType ./vendor/phing/phing/bin/phing -l | grep $_Option`
if [[ $_Ent != "" ]]; then
    echo ""
    echo "starting clean ${_Ent}'s  redis !"
    ENV=$ProjType ./vendor/phing/phing/bin/phing $_Option 1>/dev/null << EOF
2
$_Ent
EOF
echo ""
echo "clean ${_Ent}'s redis is OK !"
else
    echo ""
    echo "Enterprise name cannot be empty !"
    exit 1
fi
}
function Convert_mongodb () {
cd $ProjPath
local _Option=$1
_Option=`ENV=$ProjType ./vendor/phing/phing/bin/phing -l | grep $_Option`
ENV=$ProjType ./vendor/phing/phing/bin/phing $_Option 2>/dev/null << EOF

n
n
EOF
}
