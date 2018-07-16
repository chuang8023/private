#!/bin/bash
function DelNode {
NodePath=/var/www/Node-master
NodeName=master
###删除code
if [ -d $NodePath ];then
	echo "代码目录存在，可以删除"
	rm -rf $NodePath
fi


if [ -e /etc/nginx/sites-available/node_${NodeName} ];then 
	echo "nginx配置文件存在，可以删除"
	rm -rf /etc/nginx/sites-available/node_${NodeName}
	rm -rf /etc/nginx/sites-enabled/node_${NodeName}
fi

sed -i '/upstream master/,+2d' /etc/nginx/nginx.conf_bak

}

DelNode

