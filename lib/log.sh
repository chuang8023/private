function CatPHPLog () {
       cd $ProjPath
       Date=`date "+%Y/%m/%d"`
       PHPLogPath="log/${Date}.php"
       [ ! -e $PHPLogPath ] && echo "$PHPLogPath file doesn't exist!" && exit 1
       tail -500 $PHPLogPath
	}
function CatResqueLog () {
      cd $ProjPath
      ResqueType=$1
      ResqueLogPath="log/queue"
      tail -f $ResqueLogPath/${ResqueType}.log
}
