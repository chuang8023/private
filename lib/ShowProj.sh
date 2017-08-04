#function ShowProj() {
#local _Path=$1
#local _Title=""
#echo ""
#echo "The Proj have :"
#echo "---------------------------"
#while read LINE
#do
#       echo -n -e "\033[31m" "项目名称：" "\033[0m"
#       echo $LINE | awk -F"|" '{print $1}'
#       _Title=$(echo $LINE | awk -F"|" '{print $3}')
#       cd  $_Title
#       echo -n -e "\033[31m" "分支：" "\033[0m"
#       echo `git branch | grep "*" | awk '{print $2}'`
#       echo "#######################################"
#done < $_Path/projinfo
#}

function ShowProj() {
local _ConPath=$1
local _Type=""
local _ProjConfpath=""
local _Infor=""
echo ""
echo "The Proj have :"
echo "----------------------------------------------------------------------------------------------------------"
while read LINE
do
        _ProjConfpath=$(echo $LINE | awk -F"|" '{print $3}')
        _Type=$(echo $LINE | awk -F"|" '{print $2}')
	cat $_ProjConfpath/config/$_Type/app.php | grep "sys_name" >/dev/null 2>&1
	if [ $? == "0" ];then
	        _Infor=`cat $_ProjConfpath/config/$_Type/app.php | grep "sys_name"| awk -F"=>" '{print $2}'|  sed "s/'//g" | sed "s/,//g"`
	else
		_Infor=`cat $_ProjConfpath/config/$_Type/app.php | grep "title"| awk -F"=>" '{print $2}'|  sed "s/'//g" | sed "s/,//g"`
	fi
        echo -n -e "\033[31m" "====================================================项目全称:" "\033[0m"
        echo $_Infor
        echo -n -e "\033[31m" "=================================================Branch_Name:" "\033[0m"
        echo $LINE | awk -F"|" '{print $1}'
        cd  $_ProjConfpath
        echo -n -e "\033[31m" "=====================================================代码分支:" "\033[0m"
        echo `git branch | grep "*" | awk '{print $2}'`
        echo -n -e "\033[31m" "=====================================================访问地址:" "\033[0m"
	echo `cat $_ProjConfpath/config/$_Type/app.php | grep "www_domain" | awk -F"=>" '{print $2}' | sed "s/'//g" | sed "s/,//g"`
        echo "###############################################################################################"
done < $_ConPath/projinfo
}
