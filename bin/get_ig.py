#!/usr/bin/env python
import os
import sys
import requests
from urlparse import urlparse
from pyquery import PyQuery


def get_ig(url):
    resp = requests.get(url)
    # print(req.content)
    pq = PyQuery(resp.content)

    img = pq('meta[property="og:image"]')
    img_url = img.attr("content")
    if not img_url:
        print("og:image not found.")
        return

    pr = urlparse(img_url)
    filename = os.path.basename(pr.path)
    with open(filename, "wb") as fout:
        resp = requests.get(img_url, stream=True)

        if not resp.ok:
            print("Download fail.")
            return

        for block in resp.iter_content(1024):
            fout.write(block)


def main():
    for url in sys.argv[1:]:
        get_ig(url)

if __name__ == "__main__":
    main()
