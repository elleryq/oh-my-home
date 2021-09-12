#!/bin/bash

set +o pipefail
if [ -z "${1}" ]; then
    echo "Which version?"
    exit -1
fi
version=$1

DOWNLOAD_DIR="${HOME}/Downloads"
if [ ! -e "${DOWNLOAD_DIR}" ]; then
    mkdir -p "{DOWNLOAD_DIR}"
fi

# Get current installed version
#current_version=$(dpkg-query -W vagrant | awk -F: '{print $2}')
#version=$(curl -s https://www.vagrantup.com/downloads.html | grep "CHANGELOG" | grep -o 'v[0-9]\.[0-9]\.[0-9]' | head -n 1| cut -c2-)

if [ "${current_version}" == "${version}" ]; then
    echo "Already latest version: ${version}"
    exit -1
fi

arch=$(uname -m)
url=https://releases.hashicorp.com/vagrant/${version}/vagrant_${version}_${arch}.deb

# extract the path (if any)
path="$(echo "${url}" | grep / | cut -d/ -f2-)"
filename="${DOWNLOAD_DIR}/$(basename "${path}")"

# download
wget -O "${filename}" "${url}"

# Install/Upgrade
sudo dpkg -i "${filename}"

exit 0
