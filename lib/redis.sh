function CleanAppName () {
AppNamePath="$ProPath/config/$ProjType/app.php"
AppName="cat $AppNamePath|grep application_name|awk -F "=>" '{print $2}'|sed 's/,//'"
RedisPassPath="$ProPath/config/$ProjType/redis.php"
RedisPass="cat $RedisPassPath|awk -F "," '{print $1}'|awk -F "=>" '{print $2}'"
redis-cli -p 6379 -a $RedisPass keys "$AppName*" | xargs redis-cli -p 6379 -a  $RedisPass del >> /dev/null
}
