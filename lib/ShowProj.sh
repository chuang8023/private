
function ShowProj() {
local _Path=$1
local _Title=""
echo ""
echo "The Proj have :"
echo "---------------------------"
while read LINE
do
       echo -n -e "\033[31m" "项目名称：" "\033[0m"
       echo $LINE | awk -F"|" '{print $1}'
       _Title=$(echo $LINE | awk -F"|" '{print $3}')
       cd  $_Title
       echo -n -e "\033[31m" "分支：" "\033[0m"
       echo `git branch | grep "*" | awk '{print $2}'`
       echo "#######################################"
done < $_Path/projinfo
}

