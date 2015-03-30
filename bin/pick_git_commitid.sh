#!/bin/bash
ar=()
git log --format=format:"%H \"%s\"" > /tmp/result
while read n s; do
    ar+=("$n" "${s//'"'/}")
done < /tmp/result
echo "${ar[@]}"
dialog --menu "Git log" 24 72 22 "${ar[@]}"
