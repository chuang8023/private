#!/bin/bash
function AutoTest () {

env=$Param3

testPath=$Param4

#执行接口测试
#log 地址 写入到 80端口可访问的地址，列表展现所有报表列表
#feature:
#http://192.168.0.223/testingresult/
#http://192.168.0.223/swagger/
# 
[[ $env == "" ]] && env=intergration

[[ $testPath == "" ]] && testPath=api

ResultStatus=OK


outPath=/var/www/www.codeautotesting.com/testingresult/${Branch}_${sBranchName}_test_${testPath}_report.html


cleanPath=/var/www/www.codeautotesting.com/testingresult/${Branch}_${sBranchName}*.html

hostIP=`ip add show|grep -w 'global eth0'|awk '{print $2}'|awk -F "/" '{print $1}'`


#  group = step1

rm -rf $cleanPath

cd /var/www/www.$Branch.$sBranchName.aysaas.com

echo "./bin/codecept.phar run $testPath --env $env --html=$outPath"
./bin/codecept.phar run $testPath --env $env --html=$outPath

[ ! $? -eq 0 ] && ResultStatus=NO  


CurrentTime=`date +%Y_%m_%d_%H_%M`

outStatusPath=/var/www/www.codeautotesting.com/testingresult/${Branch}_${sBranchName}_test_${testPath}_report_${ResultStatus}_${CurrentTime}.html

reportUrl="http://${hostIP}/testingresult/${Branch}_${sBranchName}_test_${testPath}_report_${ResultStatus}_${CurrentTime}.html"

mv $outPath $outStatusPath

echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

echo $reportUrl

echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

[[ $ResultStatus == "NO" ]] && exit 1

}
