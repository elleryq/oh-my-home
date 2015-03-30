#!/bin/bash

# Install required helper application
sudo apt-get install -y apt-file

# Get a list of modified or missing files
dpkg-query -W -f='${Conffiles}\n' '*' | grep /etc/init/ |\
    awk '{print $1}' > /tmp/upstart.dat
#dpkg-query -W -f='${Conffiles}\n' '*' | grep /etc/init/ |\
#    awk 'OFS=" "{print $2,$1}' | md5sum -c 2>/dev/null |\
#    awk -F': ' '$2 !~ /OK/{print $1}' > /tmp/upstart.dat
cat /tmp/upstart.dat | while read file
do
    pkg=$(apt-file search -x "^${file}$" | cut -d: -f1)
    [ -n "$pkg" ] && echo "$pkg"
    [ -n "$pkg" ] && echo "$pkg" >> /tmp/packages.dat
done

# Remove any duplicates
sort -u /tmp/packages.dat > /tmp/packages.sorted

# Re-install
sudo apt-get -o Dpkg::Options::="--force-confmiss" install \
    --reinstall $(cat /tmp/packages.sorted)
