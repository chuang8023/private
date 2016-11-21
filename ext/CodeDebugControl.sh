#!/bin/bash
CodeMember=$1
let "ExpiryDate=$2 * 60"

echo $CodeMember >> /etc/vsftpd.user_allow
sleep $ExpiryDate
sed -i s/$CodeMember//g /etc/vsftpd.user_allow
