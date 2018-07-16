function MongoDump {
Param=$1
Tig=0
echo "begin to mongodump......."
####获取database.php中的参数配置
while read LINE
do
    #local _Key=`echo $LINE | grep "=>" | awk -F"=>" '{print $1}' | awk 'gsub(/^ *| *$/,"")' | sed "s/'//g"`
    #####加个键值Tig，用来获取mongo参数
    #if [ "$_Key" == "mongodb" ];then
    #    Tig=1
    #fi
    #case $_Key in
    #	"host")
    #   		local _Host=`echo $LINE | awk -F"=>" '{print $2}' | awk 'gsub(/^ *| *$/,"")' | sed "s/'//g" | sed "s/,$//"`
    #   		;;
    #	"port")
    #   		local _Port=`echo $LINE | awk -F"=>" '{print $2}' | awk 'gsub(/^ *| *$/,"")' | sed "s/'//g" | sed "s/,$//"`
    #   		;;
    #	"dbname")
    #            local _DBName=`echo $LINE | awk -F"=>" '{print $2}' | awk 'gsub(/^ *| *$/,"")' | sed "s/'//g" | sed "s/,$//"`
    #   		;;
    #	"user")
    #   		local _DBUser=`echo $LINE | awk -F"=>" '{print $2}' | awk 'gsub(/^ *| *$/,"")' | sed "s/'//g" | sed "s/,$//"`
    #   		;;
    #	"password")
    #   		local _DBPasswd=`echo $LINE | awk -F"=>" '{print $2}' | awk 'gsub(/^ *| *$/,"")' | sed "s/'//g" | sed "s/,$//"`
    #   		if [ $Tig == 1 ];then
    #    		break;
    #    	fi
    #   		;;
    #    esac
    local _Key=`echo $LINE | awk -F":" '{print $1}'|sed 's/ //'|sed "s/'//g"`
####加个键值Tig，用来获取mongo参数
    if [ "$_Key" == "mongodb" ];then
	Tig=1
    fi
    case $_Key in
    	"host")
       		local _Host=`echo $LINE | awk '{print $2}'|sed 's/ //'|sed "s/'//g"`
       		;;
    	"port")
       		local _Port=`echo $LINE | awk '{print $2}'|sed 's/ //'|sed "s/'//g"`
       		;;
    	"dbname")
 	        local _DBName=`echo $LINE | awk '{print $2}'|sed 's/ //'|sed "s/'//g"`
       		;;
    	"user")
       		local _DBUser=`echo $LINE | awk '{print $2}'|sed 's/ //'|sed "s/'//g"`
       		;;
    	"password")
       		local _DBPasswd=`echo $LINE | awk '{print $2}'|sed 's/ //'|sed "s/'//g"`
       		if [ $Tig == 1 ];then
			break;
		fi
       		;;
	esac
done < $ProjConfPath/database.yml
###备份mongo
mongodump -u$_DBUser -p=$_DBPasswd -h$_Host:$_Port -d$_DBName -o $BackupDir/${_DBName}_mongo_`date +%y%m%d%H%M%S`
if [ $? == 0 ];then
	echo -e "mongodump is ok! the mongodump file is in '$BackupDir',the name is '${_DBName}_mongo_`date +%y%m%d%H%M%S`' "
else
	echo "mongo备份失败，请检查，或者联系SA！"
fi
}

function MongoRestore {
mongorestore --username=$_DBUser --password=$_DBPasswd --host=$_Host:$_Port --db=$_DBName --drop $BackupDir/${_DBName}_mongo_`date +%y%m%d%H%M%S`/${_DBName}
if [ $? == 0 ];then
	echo "mongo恢复成功！"
else
	echo "mongo恢复失败，请检查，或者联系SA！"
fi
}

function mongo {
cd $ProjPath
if [ $1 == "mongodump" ]; then
   MongoDump 
elif [ $1 == "mongorestore" ];then
   MongoRestore
fi
}
