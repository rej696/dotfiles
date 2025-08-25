#!/bin/bash

WORKDIR=$1
if [ "$#" -eq 0 ]; then
    WORKDIR=~/work
fi

for file in $(fd -t d -HI -g ".git" $WORKDIR | perl -pe 's|$ENV{HOME}/(.*)/\.git/|\1|');
do
    status=$(git -C ~/$file status --short);
    if [[ -n $status ]]; then
        echo "~/$file";
        git -C ~/$file status --short;
        echo -e "";
    fi
done

