#!/bin/bash

sudo -u anyuan crontab -r

cd /var/www
for featureDir in `ls -la | grep "www.feature" | awk '{print $9}'`
do
    echo "正在重新生成 $featureDir 的crontab"
    cd $featureDir
    sudo -u anyuan /usr/bin/env TERM=xterm ./deploy/crontab
    cd - 1>/dev/null 2>&1
done
