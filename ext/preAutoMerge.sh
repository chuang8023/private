#!/bin/bash

if [[ $1 == "true" ]]; then
    sed -i "s/^autoMergePre=.*/autoMergePre=true/" $(cd `dirname $0`;cd ..;pwd)/hooks.sh
    if [[ $? == 0 ]]; then
        echo ""
        echo "已开启 - release合并到pre/qycloud的自动合并机制"
    fi
else
    sed -i "s/^autoMergePre=.*/autoMergePre=false/" $(cd `dirname $0`;cd ..;pwd)/hooks.sh
    if [[ $? == 0 ]]; then
        echo "已关闭 - release合并到pre/qycloud的自动合并机制"
    fi
fi
