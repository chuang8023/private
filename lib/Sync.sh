function ConversionA2a () {
str=`echo $1 | tr '[A-Z]' '[a-z]'`
echo $str
}

function Sync () {

_Param1=$1
_Param2=$2
_Param3=$3
_Param4=$4

ENVType="development"
###获取paas的分支信息，用于同步更新paas的访问地址域名
PaasBranchName=`echo $_Param1 | awk 'gsub(/^ *| *$/,"")'`

PaasSysType=`echo "$PaasBranchName"|awk -F "/" '{print $1}'`
IsNormalPaasBranch=`echo "$PaasBranchName" | grep "/"`
[[ $IsNormalPaasBranch == "" ]] && PaasSysType=test
PaasSysName=`echo "$PaasBranchName"|awk -F "/" '{print $2}'`
[[ $PaasSysName == "" ]] && PaasSysName=$PaasSysType

PaasSysType=`ConversionA2a "$PaasSysType"`
PaasSysName=`ConversionA2a "$PaasSysName"`

###获取safety|iot的分支信息，用于同步更新paas的访问地址域名
MixBranchName=`echo $_Param2 | awk 'gsub(/^ *| *$/,"")'`

MixSysType=`echo "$MixBranchName"|awk -F "/" '{print $1}'`
IsNormalMixBranch=`echo "$MixBranchName" | grep "/"`
[[ $IsNormalMixBranch == "" ]] && MixSysType=test
MixSysName=`echo "$MixBranchName"|awk -F "/" '{print $2}'`
[[ $MixSysName == "" ]] && MixSysName=$MixSysType

MixSysType=`ConversionA2a "$MixSysType"`
MixSysName=`ConversionA2a "$MixSysName"`

sed -i "s/$PaasSysType/$MixSysType/" /var/www/www.$PaasSysType.$PaasSysName.aysaas.com/config/$ENVType/services.yml
sed -i "s/$PaasSysName/$MixSysName/" /var/www/www.$PaasSysType.$PaasSysName.aysaas.com/config/$ENVType/services.yml
sed -i "s/*.${PaasSysType}.${PaasSysName}.aysaas.com:${_Param4}/*.${MixSysType}.${MixSysName}.aysaas.com:${_Param3}/g" /var/www/node_$PaasSysName/config/deploy.js 
sed -i "s/*.${PaasSysType}.${PaasSysName}.aysaas.com:7008/*.${MixSysType}.${MixSysName}.aysaas.com:${_Param3}/g" /var/www/node_$PaasSysName/config/deploy.js 
#sed -i "s/$_Param4/$_Param3/g" /var/www/node_$PaasSysName/config/deploy.js 
#sed -i "s/7008/$_Param3/g" /var/www/node_$PaasSysName/config/deploy.js 
sed -i "s/${PaasSysType}.${PaasSysName}.aysaas.com;/${MixSysType}.${MixSysName}.aysaas.com;/g" /etc/nginx/sites-available/www.$PaasSysType.$PaasSysName.aysaas.com
sed -i "s/www.${PaasSysType}.${PaasSysName}.aysaas.com;/www.${MixSysType}.${MixSysName}.aysaas.com;/" /etc/nginx/sites-available/node_$PaasSysName
sed -i "s/$_Param4/$_Param3/" /etc/nginx/sites-available/node_$PaasSysName
unset _Param1
unset _Param2
unset _Param3
unset _Param4
nginx -t
nginx -s reload
echo "项目访问地址为:www.$PaasSysType.$PaasSysName.aysaas.com:23113"
}
