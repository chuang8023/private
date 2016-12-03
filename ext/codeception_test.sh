#!/bin/bash
function AutoTest () {

env=$Param3

testPath=$Param4

#拉取 tests代码

cd /var/www/www.$Branch.$sBranchName.aysaas.com

./script/tests init

./script/tests unpackaging

#

#执行接口测试
#log 地址 写入到 80端口可访问的地址，列表展现所有报表列表
#feature:
#http://192.168.0.223/testingresult/
#http://192.168.0.223/swagger/
# 
[[ $env == "" ]] && env=intergration

[[ $testPath == "" ]] && testPath=api

ResultStatus=OK

outPath=/var/www/www.codeautotesting.com/testingresult/$Branch_$sBranchName_test_$testPath_report.html

outStatusPath=/var/www/www.codeautotesting.com/testingresult/$Branch_$sBranchName_test_$testPath_report_$ResultStatus.html

cleanPath=/var/www/www.codeautotesting.com/testingresult/$Branch_$sBranchName*.html

hostIP=`ip add show|grep -w 'global eth0'|awk '{print $2}'|awk -F "/" '{print $1}'`

reportUrl="http://$hostIP/testingresult/$Branch_$sBranchName_test_$testPath_report_$ResultStatus.html"

#  group = step1

rm -rf $cleanPath

./bin/codecept.phar run $testPath --env $env --html=$outPath

[ ! $? -eq 0 ] && ResultStatus=NO  

mv $outPath $outStatusPath

echo $reportUrl
}
