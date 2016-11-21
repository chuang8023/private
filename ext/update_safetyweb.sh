#!/bin/bash
cd /var/www/www.safetyweb.com.cn
sudo -uanyuan git pull origin master
find . -user root -exec chown anyuan:anyuan {} \;

