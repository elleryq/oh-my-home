#!/usr/bin/env python
from __future__ import print_function
import sys
import os
import re
from subprocess import check_output


IMAGE_PATTERN = re.compile(
    'linux-image-(?P<version>[0-9\.]+)-(?P<rev>[0-9]{2})-generic')
HEADER_PATTERN = re.compile(
    'linux-headers-(?P<version>[0-9\.]+)-(?P<rev>[0-9]{2})-generic')


def get_all_packages():
    for line in check_output(['dpkg', '-l']).split('\n'):
        if line.startswith('ii'):
            # print(line.split(' '))
            yield line.split()[1]


def find_group(pattern, text):
    matched = pattern.match(text)
    if matched:
        return '{version}-{rev}'.format(
            version=matched.group('version'),
            rev=matched.group('rev'))
    return None


def main():
    packages = list(get_all_packages())
    header_pkgs = filter(lambda x: HEADER_PATTERN.match(x), packages)
    image_pkgs = filter(lambda x: IMAGE_PATTERN.match(x), packages)
    header_versions = map(lambda x: find_group(HEADER_PATTERN, x), header_pkgs)
    image_versions = map(lambda x: find_group(IMAGE_PATTERN, x), image_pkgs)
    print(header_pkgs)
    print(image_pkgs)

    print(header_versions)
    print(image_versions)


if __name__ == "__main__":
    main()
