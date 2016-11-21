function CatPHPLog () {
       cd $ProjPath
       Date=`date "+%Y/%m/%d"`
       PHPLogPath="log/${Date}.php"
       [ ! -e $PHPLogPath ] && echo "$PHPLogPath file doesn't exist!" && exit 1
       tail -500 $PHPLogPath
	}
function CatResqueLog () {
      cd $ProjPath
      Date=`date +%Y%m%d`
      ResqueType=$1
      ResqueLogPath="log/queue"
      if [ -e $ResqueLogPath/${ResqueType}.log ]
	 then
         tail -f $ResqueLogPath/${ResqueType}.log
      elif [ -e $ResqueLogPath/${ResqueType}/${Date}.log ]
	then
         tail -f $ResqueLogPath/${ResqueType}/${Date}.log
      else
         echo "该类型队列日志文件不存在！"
      fi
}
