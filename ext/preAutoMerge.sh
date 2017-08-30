#!/bin/bash

if [[ $1 == "true" ]]; then
    sed -i "s/^autoMergePre=.*/autoMergePre=true/" ../$(cd `dirname $0`;pwd)/hooks.sh
else
    sed -i "s/^autoMergePre=.*/autoMergePre=false/" ../$(cd `dirname $0`;pwd)/hooks.sh
fi
