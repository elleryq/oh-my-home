#!/usr/bin/env python
from __future__ import print_function
import random
import os.path
import subprocess
import urllib2
import xml.dom.minidom
#from xml.dom.minidom import Node


#wget -O /tmp/bingimages.xml http://feeds.feedburner.com/bingimages
#http://api.flickr.com/services/feeds/photos_public.gne?id=92762118@N00&lang=zh-hk&format=rss_200
def get_xml(uri):
    response = urllib2.urlopen(uri)
    content = response.read()
    return content


def parse_bing_images():
    xml_content = get_xml('http://feeds.feedburner.com/bingimages')
    doc = xml.dom.minidom.parseString(xml_content)

    urls = []
    for node in doc.getElementsByTagName("enclosure"):
        urls.append(node.getAttribute("url"))
    return urls


def parse_flickr_images(flickr_id):
    xml_content = get_xml(
        'http://api.flickr.com/services/feeds/photos_public.gne'
        '?id={0}&lang=zh-hk&format=rss_200'.format(flickr_id))
    doc = xml.dom.minidom.parseString(xml_content)

    urls = []
    for node in doc.getElementsByTagName("media:content"):
        urls.append(node.getAttribute("url"))
    return urls


def parse_and_get_first_image_uri():
    urls = []
    urls.extend(parse_bing_images())
    urls.extend(parse_flickr_images("92762118@N00"))
    urls.extend(parse_flickr_images("67682317@N00"))

    if len(urls) > 0:
        count = random.randint(0, len(urls)-1)
        index = 0
        for i in range(count):
            index = random.randint(0, len(urls)-1)
        return urls[index]
    else:
        return ""


def get_uri(uri, output):
    result = True
    try:
        response = urllib2.urlopen(uri)
        with open(output, "w") as image_file:
            image_file.write(response.read())
    except Exception, ex:
        print(ex, uri)
        result = False
    return result


def set_wallpaper(filename):
    args = []
    args.append('gconftool-2')
    args.append('/desktop/gnome/background/picture_filename')
    args.append('--set')
    args.append(filename)
    args.append('--type=string')
    subprocess.call(args)
#print "gconftool-2 /desktop/gnome/background/picture_filename --set ~/Firefox_wallpaper.png --type=string"


def set_wallpaper_2(filename):
    args = []
    args.append('gsettings')
    args.append('set')
    args.append('org.gnome.desktop.background')
    args.append('picture-uri')
    args.append('file://' + filename)
    print(args)
    subprocess.call(args)


if __name__ == "__main__":
    uri = parse_and_get_first_image_uri()
    tmp_dir = os.path.join(os.path.expanduser("~"), "tmp")
    if uri != "":
        if not os.path.exists(tmp_dir):
            os.mkdir(tmp_dir)
        filename, extname = os.path.splitext(os.path.basename(uri))
        image_filename = os.path.join(tmp_dir, "bing" + extname)
        if get_uri(uri, image_filename):
            #set_wallpaper(image_filename)
            #set_wallpaper_2(image_filename)
            pass
        else:
            print("Fail to get image.")
    else:
        print("get nothing.")
