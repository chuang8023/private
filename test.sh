#!/bin/bash

Param3=$2
NodeConfPath=/root/scripts/rundeck/template/feature/node/production.js
NodeNginx=/root/scripts/rundeck/template/feature/node/node


function PullNode () {
echo ""
echo "$NodeBN pulling the new node code ..."
cd $NodePath
git pull  --rebase origin $NodeBN 1>/dev/null 2>/tmp/rundeck_code_errinfo
if [[ $? == 0 ]];then
	find . -user root -exec chown $runuser:$runuser {} \;
	echo ""
	echo "$NodeBN pull the new node code is OK !"
	cd - 1>/dev/null 2>&1
else
	echo ""
	echo "$NodeBN pull the new node code is Fail !"
	echo "---------------------------------------------"
	echo "请联系运维解决！！"  
	exit 1
	
fi
}

function BuildNode () {
echo ""
echo "$NodeBN build the  node code ..."
cd $NodePath
#if [[ $SHELL == "/bin/zsh" ]];then
#  cat ~/.zshrc|grep NODE_ENV
#  if [[ $? -ne 0 ]] ;then
#  echo 'export NODE_ENV="production"' >> ~/.zshrc
#  source ~/.zshrc
#  fi
#fi
#if [[ $SHELL == "/bin/bash" ]];then
#  cat ~/.bashrc|grep NODE_ENV
#  if [[ $? -ne 0 ]] ;then
#  echo 'export NODE_ENV="production"' >> ~/.bashrc
#  source ~/.bashrc
#  fi
#fi
NODE_ENV="production" npm run static 1>/dev/null 2>/tmp/rundeck_code_errinfo
if [[ $? == 0 ]]; then
find . -user root -exec chown $runuser:$runuser {} \;
echo ""
echo "$NodeBN build  node code is OK !"
else
    echo ""
    echo "$NodeBN build node code is Fail !"
    echo "---------------------------------------------"
    cat /tmp/rundeck_code_errinfo | grep "ERR"
    if [ $? -eq 0 ];then
    	npm config set registry https://registry.npm.taobao.org
        which cnpm > /dev/null 2>&1
        [ $? -eq 1 ] && echo "install cnpm" && npm install -g cnpm --registry=https://registry.npm.taobao.org
        echo "update node modules...."
        NODE_ENV="development" cnpm i
	[ $? -eq 0 ] && npm run static 1>/dev/null 2>/tmp/rundeck_code_errinfo
	echo "$NodeBN build  node code is OK !"
	find . -user root -exec chown $runuser:$runuser {} \;
    else
        echo ""
        echo "请联系运维解决！！"  
        exit 1
    fi

fi
pm2 start app.js --name node_${NodeName}
}
 
function RestartPm2 () {
echo ""
echo "Restart pm2 ..."
cd $NodePath
pm2 restart node_${NodeName} 1>/dev/null 2>/tmp/rundeck_code_errinfo
if [[ $? == 0 ]]; then
    echo ""
    echo " restart pm2  is OK !"
    cd - 1>/dev/null 2>&1
else
    echo ""
    echo "restart pm2 is Fail !"
    echo "---------------------------------------------"
    cat /tmp/rundeck_code_errinfo
    exit 1
fi
}


function NginxPort() {
i=6000
Port=0
cat /etc/nginx/nginx.conf | grep 127.0.0.1 | awk -F":" '{print $2}' |awk -F";" '{print $1}' | grep -v "LISTEN" >/tmp/port.log
num=`cat /tmp/port.log | wc -l`
while (($i <=8000))
do
        ss -tln | grep $i >> /dev/null
        if [ $? -eq 1 ];then
                for j in `cat /tmp/port.log`
                do
                        if [ $i == $j ];then
                                flag=1
                                break
                        else
                                flag=0
                        fi
                done
        if [ $flag == 0 ];then
                Port=$i
                echo $Port
                break
        fi
        fi
        i=$(($i+10))
done
return $Port
}




####### NODE部署&&配置
####### @author:346619752@qq.com
####### @date: 2017-11-16
function DeployNode {

NodeBN=`echo $Param3 | awk 'gsub(/^ *| *$/,"")'`
echo $NodeBN
NodeBranch=`echo $NodeBN | awk -F"/" '{print $1}'`
NodeName=`echo $NodeBN | awk -F"/" '{print $2}'`
if [ ! $NodeName ];then
        NodeName=$NodeBranch
fi
echo "node分支为："$NodeBranch
echo "node分支名为："$NodeName

##拉取代码、配置文件
cd /var/www/
git clone git@e.coding.net:Safirst/Node-SaaS.git  Node-${NodeName}
if [ -d /var/www/Node-${NodeName} ];then
	echo "该目录已存在，请联系运维处理！！"
	exit 1	
fi
NodePath=/var/www/Node-${NodeName}
cp $NodeConfPath /var/www/Node-${NodeName}/config
cp $NodeNginx /etc/nginx/sites-available
[ $? -eq 0 ] && mv /etc/nginx/sites-available/node /etc/nginx/sites-available/node_${NodeName}

######修改node-production.js
NodePort=`NginxPort`
echo "node端口:"$NodePort
sed -i "s/port:.*/port: $NodePort,/" /var/www/Node-${NodeName}/config/production.js
sed -i "s/api.*/api: 'http:\/\/www.$Branch.$sBranchName.aysaas.com:5566',/" /var/www/Node-$NodeName/config/production.js
sed -i "s/static.*/static: 'http:\/\/nodestatic.$Branch.$sBranchName.aysaas.com:5566',/" /var/www/Node-$NodeName/config/production.js
sed -i "s/fileio.*/fileio: 'http:\/\/fileio.$Branch.$sBranchName.aysaas.com:5566',/" /var/www/Node-$NodeName/config/production.js

##修改node-nginx
sed -i "s/Node-SaaS/Node-$NodeName/" /etc/nginx/sites-available/node_${NodeName}
sed -i "s/node/node-$NodeName/" /etc/nginx/sites-available/node_${NodeName}
sed -i "s/nodetest/node_${NodeName}/g" /etc/nginx/sites-available/www.$Branch.$sBranchName.aysaas.com
nginx -t
[ $? -eq 0 ] && ln -s /etc/nginx/sites-available/node_${NodeName} /etc/nginx/sites-enabled/
nginx -s reload

##修改node-nginx.conf
sed -i "/^http.*/a\upstream $NodeName {\n    server 127.0.0.1:$NodePort;\n}" /etc/nginx/nginx.conf

PullNode
BuildNode
RestartPm2
}

########删除node
function DelNode {
Param1=$1
if [ -d /var/www/Node-$Param1 ];then
        echo "代码目录存在，可以删除"
        #rm -rf $NodePath
fi


if [ -e /etc/nginx/sites-available/node_$Param1 ];then
        echo "nginx配置文件存在，可以删除"
        #rm -rf /etc/nginx/sites-available/node_${NodeName}
        #rm -rf /etc/nginx/sites-enabled/node_${NodeName}
fi

sed -i '/upstream master/,+2d' /etc/nginx/nginx.conf
nginx -t
nginx -s reload

}



case $1 in
"deploy")
    DeployNode
    ;;
"del")
    DelNode $2
esac

