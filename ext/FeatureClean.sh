#!/bin/bash

repPath="/home/anyuan/template/featureclean"
projInfoPath="/root/scripts/rundeck/config/projinfo"
logPath="/root/scripts/rundeck/log/featureClean.log"

cd $repPath
git fetch -p
if [[ $? == 0 ]]; then
    branchs=(`git branch -a | grep "remotes/origin" | awk -F"/" '{print $3"/"$4}' | sed "s/\/\$//g"`)
    for deployBranch in `cat /root/scripts/rundeck/config/projinfo | awk -F"|" '{print $1}'`
    do
        isExist=0
        for branch in ${branchs[*]}
        do
            if [[ $branch == $deployBranch ]]; then
                isExist=1
            fi
        done
        if [[ $isExist == 0 ]]; then
            /root/scripts/rundeck/ext/deployBranch_feature.sh delete $deployBranch
            if [[ $? == 0 ]]; then
                echo "date +%Y/%D_%H:%M:%S - $deployBranch has been deleted " >> $logPath
            fi
        fi
    done
fi
    
