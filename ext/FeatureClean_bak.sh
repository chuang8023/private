#!/bin/bash
Feature_Count=`ls /var/www|grep feature|awk -F"." {'print $3'}|wc -l`
DBPass=saas
DBUser=root

cd /home/anyuan/template/featureclean
git fetch -p
git branch -a|grep feature|awk -F "/" '{print tolower($4)}' > /tmp/coding_feature.txt
for ((i=1;i<=${Feature_Count};i++))
	do
          Feature_Name1=`ls /etc/nginx/sites-enabled|grep feature|awk -F"." {'print tolower($3)'}|sed -n "${i}p"`
          Feature_Name2=`ls /etc/nginx/sites-enabled|grep feature|awk -F"." {'print $3'}|sed -n "${i}p"`
          [[ $Feature_Name1 == "templaterelease" ]]  && continue
          [[ $Feature_Name1 == "templateRelease" ]]  && continue
          [[ $Feature_Name1 == "" ]]  && continue
          grep -w $Feature_Name1 /tmp/coding_feature.txt > /dev/null 2>&1
          if [ $? -ne 0 ];then
          echo $Feature_Name2
	   sleep 5
#删除代码
       [ -e /var/www/www.feature.$Feature_Name1.aysaas.com ] && rm -rf /var/www/www.feature.$Feature_Name1.aysaas.com
       [ -e /var/www/www.feature.$Feature_Name2.aysaas.com ] && rm -rf /var/www/www.feature.$Feature_Name2.aysaas.com
#删除配置
       [ -e /etc/nginx/sites-enabled/www.feature.$Feature_Name1.aysaas.com ] &&  rm -rf /etc/nginx/sites-enabled/www.feature.$Feature_Name1.aysaas.com
       [ -e /etc/nginx/sites-enabled/www.feature.$Feature_Name2.aysaas.com ] &&  rm -rf /etc/nginx/sites-enabled/www.feature.$Feature_Name2.aysaas.com
       [ -e /etc/nginx/sites-available/www.feature.$Feature_Name1.aysaas.com ]  &&   rm -rf /etc/nginx/sites-available/www.feature.$Feature_Name1.aysaas.com  
       [ -e /etc/nginx/sites-available/www.feature.$Feature_Name2.aysaas.com ]  &&   rm -rf /etc/nginx/sites-available/www.feature.$Feature_Name2.aysaas.com  
#删除数据库
          docker ps -a|grep -w "Mysql_feature_$Feature_Name1" > /dev/null 2>&1
          if [ $? -eq 0 ];then
           docker rm -f Mysql_feature_$Feature_Name1
	  fi
          docker ps -a|grep -w "Mysql_feature_$Feature_Name2" > /dev/null 2>&1
          if [ $? -eq 0 ];then
           docker rm -f Mysql_feature_$Feature_Name2
	  fi
	   echo ""
	   echo "Delete DockerMysql is ok !"
           
          docker ps -a|grep -w "Mongo_feature_$Feature_Name1" > /dev/null 2>&1
          if [ $? -eq 0 ];then
           docker rm -f Mongo_feature_$Feature_Name1
	  fi
          docker ps -a|grep -w "Mongo_feature_$Feature_Name2" > /dev/null 2>&1
          if [ $? -eq 0 ];then
           docker rm -f Mongo_feature_$Feature_Name2
	  fi
	   echo ""
	   echo "Delete DockerMongo is ok !"
#           mysql -u$DBUser -p$DBPass -e "show databases"| grep "feature_${Feature_Name1}" > /dev/null 2>&1
#           [ $? -eq 0 ] &&  mysql -u$DBUser -p$DBPass -e "drop database feature_${Feature_Name1}" >> /tmp/feature_clean.log
#           mysql -u$DBUser -p$DBPass -e "show databases"| grep "feature_${Feature_Name2}" > /dev/null 2>&1
#           [ $? -eq 0 ] &&  mysql -u$DBUser -p$DBPass -e "drop database feature_${Feature_Name2}" >> /tmp/feature_clean.log
#删除计划任务
	   sed -i '/^.*'$Feature_Name1'.*$/d' /var/spool/cron/crontabs/anyuan
           echo "feature/$Feature_Name1 has been removed" >> /tmp/feature_clean.log
           sleep 3
           let Feature_Count=Feature_Count-1
           fi 
      done
sudo service nginx reload
