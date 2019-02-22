#!/bin/sh
# sudo dpkg --purge `dpkg -l | awk '/^rc/{print $2;}' `
dpkg -l | awk '/^rc/{print $2;}' | xargs -r sudo dpkg --purge
