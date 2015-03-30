#!/bin/bash
if [ -z $1 ]; then
    ar=()
    git log --format=format:"%H \"%s\"" > /tmp/result
    while read n s; do
        ar+=("$n" "${s//'"'/}")
    done < /tmp/result
    #echo "${ar[@]}"
    result=$(dialog --stdout --menu "Git log" 24 72 22 "${ar[@]}")
    rm -f /tmp/result
else
    result=$1
fi
if [ -z $result ]; then
    echo "failure."
    exit -1
fi

#git diff-tree --no-commit-id --name-only -r $result
git show $result

