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
      elif [ -e $ResqueLogPath/${ResqueType} ]
	then
         LogName=`ls  -l  $ResqueLogPath/${ResqueType}|tail -1|awk '{print $9}'`
         tail -f $ResqueLogPath/${ResqueType}/$LogName
      else
         echo "该类型队列日志文件不存在！"
      fi
}
