#!/bin/bash

set +o pipefail
#if [ -z "${1}" ]; then
#    echo "Which version?"
#    exit -1
#fi
# version=$1

DOWNLOAD_DIR="${HOME}/Downloads"
if [ ! -e "${DOWNLOAD_DIR}" ]; then
    mkdir -p "{DOWNLOAD_DIR}"
fi

# Get current installed version
current_version=$(dpkg-query -W polar-bookshelf | awk '{print $2}')
echo "Current version=${current_version}"

# Get latest version
GITHUB_RELEASES_JSON=$(mktemp -p "${TMPDIR}" gh_XXXXX)
curl -s https://api.github.com/repos/burtonator/polar-bookshelf/releases/latest -o ${GITHUB_RELEASES_JSON}
version=$(jq -r '.name' ${GITHUB_RELEASES_JSON})
latest_deb_download_url=$(jq -r '.assets | .[] | select(.name | contains(".deb")) | .browser_download_url' ${GITHUB_RELEASES_JSON})
rm -f "${GITHUB_RELEASES_JSON}"

if [ "${current_version}" == "${version}" ]; then
    echo "Already latest version: ${version}"
    exit -1
fi

url=${latest_deb_download_url}

# extract the path (if any)
path="$(echo "${url}" | grep / | cut -d/ -f2-)"
filename="${DOWNLOAD_DIR}/$(basename "${path}")"

# download
wget -O "${filename}" "${url}"

# Install/Upgrade
sudo dpkg -i "${filename}"

exit 0
