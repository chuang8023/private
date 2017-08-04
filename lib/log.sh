function CatPHPLog () {
       cd $ProjPath
       local _Num=$1
       Date=`date "+%Y/%m/%d"`
       PHPLogPath="log/${Date}.php"
       [ ! -e $PHPLogPath ] && echo "$PHPLogPath file doesn't exist!" && exit 1
       echo -e "\033[31m" "输出最新"$_Num"行日志信息：" "\033[0m"
       tail -$_Num $PHPLogPath
}

function CatResqueLog () {
	cd $ProjPath
	Date=`date +%Y%m%d`
        ResqueType=$1
        ResqueLogPath="log/queue"
        echo $ResqueLogPath
        echo $ResqueType
        if [ -e $ResqueLogPath/${ResqueType}.log ];then
        	 tail -f $ResqueLogPath/${ResqueType}.log
        elif [ -e $ResqueLogPath/${ResqueType} ];then
         	LogName=`ls  -l  $ResqueLogPath/${ResqueType}|tail -1|awk '{print $9}'`
        	echo $LogName 
		tail -f $ResqueLogPath/${ResqueType}/$LogName
        else
        	 echo -e "\033[31m" "该类型队列日志文件不存在！" "\033[0m"
        fi
}

function DownloadLog () {
	local _Type=$1
	local _Num=$2
	_Name=`echo $ProjPath | awk -F"/" '{print $4}'`
	if [ ! -d $ProjPath/DownLog/ ];then
                        mkdir -p $ProjPath/DownLog
                        chown -R anyuan:anyuan $ProjPath/DownLog
                fi

	case $_Type in
	"nginx")
		cd /var/log/nginx
                local _total=0
                for i in `ls $_Name-access.*`
                do
                        cp $i $ProjPath/DownLog/
                        _total=`expr $_total + 1`
                        if [ $_total == $_Num ];then
                                break;
                        fi
                done
		_total=0
		for i in `ls $_Name-error.*`
                do
                        cp $i $ProjPath/DownLog/
                        _total=`expr $_total + 1`
                        if [ $_total == $_Num ];then
                                break;
                        fi
                done

		echo $ProjPath/DownLog/
                cd $ProjPath
                tar -zcvf $_Name.tar.gz DownLog/ >/dev/null 2>&1
                if [ $? -ge 0 ];then
                        mv $_Name.tar.gz /home/anyuan/logbase
                        if [ $? -ge 0 ];then
                                rm -rf $ProjPath/DownLog/
                        fi
                fi
                ;;
		
	"php")
		Date=`date "+%Y/%m"`
		cd $ProjPath/log/$Date
		local _total=0
		for i in `ls *.php`
		do
			cp $i $ProjPath/DownLog/
			_total=`expr $_total + 1`
			if [ $_total == $_Num ];then
				break;
			fi 
		done
		cd $ProjPath
		tar -zcvf $_Name.tar.gz DownLog/ >/dev/null 2>&1
		if [ $? -ge 0 ];then
			mv $_Name.tar.gz /home/anyuan/logbase 
			if [ $? -ge 0 ];then
				rm -rf $ProjPath/DownLog/ 
			fi
		fi
		;;
	"tomcat")
		local _version=`ps -ef | grep tomcat | grep -v grep | grep "var/lib" | awk '{print $1}'`
	  	local _total=0
		cd /var/log/$_version
		for i in `ls catalina.out*`
		do
			cp $i $ProjPath/DownLog/
                        _total=`expr $_total + 1`
                        if [ $_total == $_Num ];then
                                break;
                        fi
		done	
		cd $ProjPath
                tar -zcvf tomcat.tar.gz DownLog/ >/dev/null 2>&1
                if [ $? -ge 0 ];then
                        mv tomcat.tar.gz /home/anyuan/logbase 
                        if [ $? -ge 0 ];then
                                rm -rf $ProjPath/DownLog/
                        fi
                fi

		;;
	esac
echo " ============================================================ 
方法一：使用Winscp软件，通过ftp方式连接服务器，点击进入，下载对应的日志文件！　
方法二：使用浏览器，输入ftp://IP，下载对应的日志文件！
FTP的IP地址为:192.168.0.209，用户名logftp,密码请与运维人员索取！！"

}

function CatTomcatLog () {
       local _Num=$1
       local _Version=`ps -ef | grep tomcat | grep -v grep | grep "var/lib" |awk '{print $1}'`
       cd /var/log/$_Version
       TomcatLogPath="catalina.out"
       echo -e "\033[31m" "输出最新"$_Num"行日志信息：" "\033[0m"
       tail -n $_Num $TomcatLogPath
}

