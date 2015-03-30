#!/bin/sh
sudo dpkg --purge `dpkg -l | awk '/^rc/{print $2;}' `
