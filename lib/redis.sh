function CleanRedis () {
echo "clean the project redis cache now ..."
AppNamePath="$ProjPath/config/$ProjType/app.php"
AppName=`cat $AppNamePath|grep application_name|awk -F "=>" '{print $2}'|sed 's/,//'`
RedisPassPath="$ProjPath/config/$ProjType/redis.php"
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

