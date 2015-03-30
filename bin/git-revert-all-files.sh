#!/bin/bash
git status | awk '/modified/{print $3;}' | xargs git checkout --
git status | awk '/deleted/{print $3;}' | xargs git checkout --
