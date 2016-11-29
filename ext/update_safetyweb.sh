#!/bin/bash
cd /var/www/www.safetyweb.com.cn
git pull origin master
find . -user root -exec chown anyuan:anyuan {} \;

