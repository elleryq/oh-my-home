#!/bin/bash
find . -name '*.JPG' -exec bash -c 'mv "$1" "${1/%.JPG/.jpg}"' -- {} \;
#exiftool “-DateTimeOriginal+=0:1:2 3:4:5″ .
exiv2 -r'%Y-%m-%d_%H.%M.%S' rename *.jpg
