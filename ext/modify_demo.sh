#!/bin/bash
DemoName=$1
Operation=$2
TittleName=$3

  [[ $DemoName = '' || $Operation = '' ]] && echo "输入参数错误" && exit 1

     case $DemoName in 
	yhpc)
		DemoDir=www.demo.yhpc.aysaas.com
	     case $Operation in 
		  rename)
	          cp /home/anyuan/template/$DemoDir/app.php /home/anyuan/DemoData/$DemoDir/config/development/app.php	  
		  cp /home/anyuan/template/$DemoDir/layout.js /home/anyuan/DemoData/$DemoDir/public/layout/layout.js

		  sed -i "s/项目名/$TittleName/" /home/anyuan/DemoData/$DemoDir/config/development/app.php
		  sed -i "s/项目名/$TittleName/" /home/anyuan/DemoData/$DemoDir/public/layout/layout.js
		  echo "项目名更新成功！"
		  ;;
		  rebjpic)
                 scp anyuan@192.168.0.215:/home/anyuan/sa_dir/demodata/$DemoDir/bj.png  /home/anyuan/DemoData/$DemoDir/public/home/themes/nmgyh/images/bj3.png
                  echo "背景图片更新成功！"
		  ;;
		  redzpic)
                 scp anyuan@192.168.0.215:/home/anyuan/sa_dir/demodata/$DemoDir/dz.png  /home/anyuan/DemoData/$DemoDir/public/home/themes/nmgyh/images/dizi.png
                  echo "底部技术支持图片更新成功！"
		  ;;
		   *)
		  echo "参数输入错误";exit 1
	     esac
		 ;;
		 ajap)
		DemoDir=www.demo.ajap.aysaas.com
		   case $Operation in 
		       rename)
                             cp /home/anyuan/template/$DemoDir/app.php /home/anyuan/DemoData/$DemoDir/config/development/app.php
                             sed -i "s/项目名/$TittleName/" /home/anyuan/DemoData/$DemoDir/config/development/app.php
		             echo "项目名更新成功！"
                             ;;
			    *)
			     echo "参数输入错误";exit 1
		  esac
		   ;;
		 zyrj)
                DemoDir=www.demo.zyrj.aysaas.com
                   case $Operation in
                       rename)
                             cp /home/anyuan/template/$DemoDir/app.php /home/anyuan/DemoData/$DemoDir/config/development/app.php
                             sed -i "s/项目名/$TittleName/" /home/anyuan/DemoData/$DemoDir/config/development/app.php
		             echo "项目名更新成功！"
                             ;;
                            *)
                             echo "参数输入错误";exit 1
                  esac
                   ;;
		  *)
		echo "参数输入错误";exit 1
     esac
