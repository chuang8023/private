#!/bin/bash

projInfoPath="/root/scripts/rundeck/config/projinfo"

for projPath in `cat $projInfoPath | awk -F"|" '{print $3}'`
do
    if [[ ! -d $projPath ]]; then
        rowNumber=`grep -n "$projPath" $projInfoPath | awk -F":" '{print $1}'`
        sed -i ${rowNumber}d $projInfoPath
        echo "$projPath 不存在代码目录，已清除..."
    fi
done
