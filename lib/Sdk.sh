function TranSferWar () {
	local ScpIp=$1
	local ScpPort=$2
	local ScpName="war"
	###info
	echo ""
	echo -e  "\033[31m"  "上传的war包名称按下列要求命名。如果不符合命名规范，请点击右上角的'kill job'终止操作,重命名后再操作。切记！！" "\033[0m"
	echo -e  "\033[31m"  "系统对应的war包名称为:${WarName}.war"  "\033[0m"
	sleep 20;

	###ftp上传，前提服务器开通ftp功能
	##paas

	###scp上传，没有ftp的环境下使用，缺点容易暴露服务器的安全性。考虑新建用户，设置nologin
	##创建scp用户，只允许scp，不允许登陆
	##判断服务有没安装rssh
	ls /usr/bin/rssh > /dev/null 2>&1
	[ $? -ne 0 ] && apt-get install -y rssh > /dev/null 2>&1 
	##创建rssh，只允许scp,用户war与密码、创建rsshusers用户
	groupadd rsshusers
	cat /etc/passwd | grep $ScpName | grep /usr/bin/rssh > /dev/null 2>&1
	if [ $? -ne 0 ];then
		useradd $ScpName -g rsshusers -s /usr/bin/rssh
		echo $ScpName:83752661@war|chpasswd
		echo allowscp >> /etc/rssh.conf
	fi
	##scp上传war包
	echo ""
	echo -e "\033[31m" "请使用下面命令，将war包scp到服务器" "\033[0m"
	echo -e "\033[31m" "scp -P$ScpPort ${WarName}.war $ScpName@$ScpIp:$ScpDir" "\033[0m"
	echo -e "\033[31m" "密码:83752661@war" "\033[0m"
}
	
function CheckWar () {
	##判断上传的war包名称是否规范
	cd  $ScpDir
	ScpWarName=`ls -la | grep *.war |awk '{print $9}'|sed 's/ //g'`
	if [ "${WarName}.war" != "$ScpWarName" ];then
		echo "上传war命名规范不符合，请重命名本地war包名称为:${WarName}.war，然后重新上传"
		rm $ScpWarName
		exit 1
	fi
}

function UpdateWar () {
	local _WarIp=$1
	local _WarPort=$2
	local _TomcatDir=$3
	CheckWar
	if [ "${_WarIp}" == "127.0.0.1" ];then
	#war部署在本机服务器
		##备份war包与配置
		if [ ! -d /home/$runuser/sdkback ];then
			mkdir /home/$runuser/sdkback
		fi
		cp ${_TomcatDir}/webapps/${WarName}.war /home/$runuser/sdkback
		cp ${_TomcatDir}/webapps/${WarName}/WEB-INF/classes/config.properties /home/$runuser/sdkback
		cp ${_TomcatDir}/webapps/${WarName}/WEB-INF/classes/sysconfig.properties /home/$runuser/sdkback
		##替换war包
		mv $ScpDir/${WarName}.war ${_TomcatDir}/webapps
		sleep 20
		cp /home/$runuser/sdkback/sysconfig.properties ${_TomcatDir}/webapps/${WarName}/WEB-INF/classes/	
		cp /home/$runuser/sdkback/config.properties ${_TomcatDir}/webapps/${WarName}/WEB-INF/classes/	
	else
	#war部署在其他服务器
		cd $ScpDir
		scp -P${_WarPort} ${WarName}.war $runuser@${_WarIp}:~/
		ssh -p${_WarPort} -l $runuser ${_WarIp} "bash /usr/local/src/UpdateWar.sh ${_TomcatDir} ${WarName}.war"

	fi
	##重启tomcat
	cat ${_TomcatDir} | grep "/var/lib/tomcat7" >/dev/null 2>&1 
	if [ $? -eq 0 ];then
		chown -R tomcat7:tomcat7 ${_TomcatDir}
		service tomcat7 restart
	else
		chown -R $runuser:$runuser ${_TomcatDir}
		cd ${_TomcatDir}
		./bin/shutdown.sh
		./bin/startup.sh
	fi
	echo "war包更新成功!"
}
