#!/bin/bash
DemoName=$1
Operation=$2
TittleName=$3

  [[ $DemoName = '' || $Operation = '' ]] && echo "Error Parameter !" && exit 1

     case $DemoName in 
	yhpc)
		DemoDir=www.demo.yhpc.aysaas.com
	     case $Operation in 
		  rename)
	          cp /home/anyuan/template/$DemoDir/app.php /home/anyuan/DemoData/$DemoDir/config/development/app.php	  
		  cp /home/anyuan/template/$DemoDir/layout.js /home/anyuan/DemoData/$DemoDir/public/layout/layout.js

		  sed -i "s/项目名/$TittleName/" /home/anyuan/DemoData/$DemoDir/config/development/app.php
		  sed -i "s/项目名/$TittleName/" /home/anyuan/DemoData/$DemoDir/public/layout/layout.js
		  echo "Project's name update successfully！"
		  ;;
		  rebjpic)
                 scp anyuan@192.168.0.215:/home/anyuan/sa_dir/demodata/$DemoDir/bj.png  /home/anyuan/DemoData/$DemoDir/public/home/themes/nmgyh/images/bj3.png
                  echo "Project's background picture update successfully！"
		  ;;
		  redzpic)
                 scp anyuan@192.168.0.215:/home/anyuan/sa_dir/demodata/$DemoDir/dz.png  /home/anyuan/DemoData/$DemoDir/public/home/themes/nmgyh/images/dizi.png
                  echo "Project's bottom picture update successfully！"
		  ;;
		   *)
		  echo "Error Parameter !";exit 1
	     esac
		 ;;
		 ajap)
		DemoDir=www.demo.ajap.aysaas.com
		   case $Operation in 
		       rename)
                             cp /home/anyuan/template/$DemoDir/app.php /home/anyuan/DemoData/$DemoDir/config/development/app.php
                             sed -i "s/项目名/$TittleName/" /home/anyuan/DemoData/$DemoDir/config/development/app.php
		             echo "Project's name update successfully！"
                             ;;
			    *)
			     echo "Error Parameter !";exit 1
		  esac
		   ;;
		 zyrj)
                DemoDir=www.demo.zyrj.aysaas.com
                   case $Operation in
                       rename)
                             cp /home/anyuan/template/$DemoDir/app.php /home/anyuan/DemoData/$DemoDir/config/development/app.php
                             sed -i "s/项目名/$TittleName/" /home/anyuan/DemoData/$DemoDir/config/development/app.php
		             echo "Project's name update successfully！"
                             ;;
                            *)
                             echo "Error Parameter !";exit 1
                  esac
                   ;;
		  *)
		echo "Error Parameter !";exit 1
     esac
