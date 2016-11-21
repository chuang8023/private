#!/bin/bash
CodeMember=$1
let "ExpiryDate=$2 * 60"
cat /etc/vsftpd/ftpuser.txt|grep $CodeMember > /dev/null 2>&1
[ ! $? -eq 0 ] && echo "研发账号不存在！" && exit 1
echo $CodeMember >> /etc/vsftpd.user_allow
sleep $ExpiryDate
sed -i s/$CodeMember//g /etc/vsftpd.user_allow
