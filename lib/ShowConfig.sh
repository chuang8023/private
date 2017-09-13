function ShowConfig() {
	cd $ProjPath
	echo "项目配置信息如下所示："
	local Mysql_host=`ENV=$ProjType php -r "include 'bootstrap.php'; print( \Config('database.servers.default.host'));"|awk -F ',' '{print $1}'`
	local Mysql_port=`ENV=$ProjType php -r "include 'bootstrap.php'; print( \Config('database.servers.default.port'));"|awk -F ',' '{print $1}'`
	local Mysql_dbname=`ENV=$ProjType php -r "include 'bootstrap.php'; print( \Config('database.servers.default.dbname'));"|awk -F ',' '{print $1}'`
	local Mysql_user=`ENV=$ProjType php -r "include 'bootstrap.php'; print( \Config('database.servers.default.user'));"|awk -F ',' '{print $1}'`
	local Mysql_pwd=`ENV=$ProjType php -r "include 'bootstrap.php'; print( \Config('database.servers.default.password'));"|awk -F ',' '{print $1}'`

	local Mongo_host=`ENV=$ProjType php -r "include 'bootstrap.php'; print( \Config('database.servers.mongodb.host'));"|awk -F ',' '{print $1}'`
	local Mongo_port=`ENV=$ProjType php -r "include 'bootstrap.php'; print( \Config('database.servers.mongodb.port'));"|awk -F ',' '{print $1}'`
	local Mongo_dbname=`ENV=$ProjType php -r "include 'bootstrap.php'; print( \Config('database.servers.mongodb.dbname'));"|awk -F ',' '{print $1}'`
	local Mongo_user=`ENV=$ProjType php -r "include 'bootstrap.php'; print( \Config('database.servers.mongodb.user'));"|awk -F ',' '{print $1}'`
	local Mongo_pwd=`ENV=$ProjType php -r "include 'bootstrap.php'; print( \Config('database.servers.mongodb.password'));"|awk -F ',' '{print $1}'`

	local Redis_host=`ENV=$ProjType php -r "include 'bootstrap.php'; print( \Config('redis.servers.default'));"|awk -F ':' '{print $1}'`
	local Redis_port=`ENV=$ProjType php -r "include 'bootstrap.php'; print( \Config('redis.servers.default'));"|awk -F ':' '{print $2}'`
	local Redis_pwd=`ENV=$ProjType php -r "include 'bootstrap.php'; print( \Config('redis.auth'));"|awk '{print $1}'`

	
	local Root_domain=`ENV=$ProjType php -r "include 'bootstrap.php'; print( \Config('app.root_domain'));"|awk '{print $1}'`
	local Www_domain=`ENV=$ProjType php -r "include 'bootstrap.php'; print( \Config('app.www_domain'));"|awk '{print $1}'`
	local Fileio_domain=`ENV=$ProjType php -r "include 'bootstrap.php'; print( \Config('app.fileio_domain'));"|awk '{print $1}'`
	local Static_domain=`ENV=$ProjType php -r "include 'bootstrap.php'; print( \Config('app.static_domain'));"|awk '{print $1}'`
	local Preview_domain=`ENV=$ProjType php -r "include 'bootstrap.php'; print( \Config('app.preview_domain'));"|awk -F "/" '{print $1}'`
	
	#InternalIp=`/sbin/ifconfig eth0|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"|sed s/"地址"//`
	echo "====================================="
	echo "数据库Mysql配置信息："
	if [ ${Mysql_host} == "localhost" ];then
		Mysql_host="127.0.0.1"
	fi
	if [ ${Mongo_host} == "localhost" ];then
		Mongo_host="127.0.0.1"
	fi
	if [ ${Redis_host} == "localhost" ];then
		Redis_host="127.0.0.1"
	fi
	
	echo "host      =>"${Mysql_host}
	echo "port      =>"${Mysql_port}
        echo "dbname    =>"${Mysql_dbname}
        echo "user      =>"${Mysql_user}
        echo "password  =>"${Mysql_pwd}
	echo "====================================="
	echo "缓存Mongo配置信息："
	echo "host      =>"${Mongo_host}
        echo "port      =>"${Mongo_port}
        echo "dbname    =>"${Mongo_dbname}
        echo "user      =>"${Mongo_user}
        echo "password  =>"${Mongo_pwd}
        echo "====================================="
	echo "缓存Redis配置信息："
	echo "host      =>"${Redis_host}
        echo "port      =>"${Redis_port}
        echo "password  =>"${Redis_pwd}
	echo "====================================="
	echo "平台域名访问配置信息:"
	echo "root_domain    =>"${Root_domain}
        echo "www_domain     =>"${Www_domain}
        echo "static_domain  =>"${Static_domain}
        echo "fileio_domain  =>"${Fileio_domain}
        echo "preview_domain =>"${Preview_domain}
}
