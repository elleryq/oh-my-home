#!/bin/bash

install() {
    sudo -v && wget -nv -O- https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py | sudo python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()"
}

CALIBRE_INSTALLED=$(which calibre)
if [ -z "$CALIBRE_INSTALLED" ]; then
    install
else
    LATEST_VERSION_STRING=$(curl -s http://code.calibre-ebook.com/latest)
    IFS='.' read -a array <<< "$LATEST_VERSION_STRING"
    LATEST_VERSION="${array[0]}.${array[1]}"

    CURRENT_VERSION=$(calibre --version|tr -d '[a-z]() ')
    echo "Latest version is $LATEST_VERSION"
    echo "Current version is $CURRENT_VERSION"
    if [ "$LATEST_VERSION" != "$CURRENT_VERSION" ]; then
        install
    else
        echo "Equal, skip upgrading."
    fi
fi
