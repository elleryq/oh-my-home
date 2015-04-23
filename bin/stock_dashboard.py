#!/usr/bin/env python
# -*- encoding: utf-8 -*-
from __future__ import print_function
from grs import RealtimeTWSE

def main():
    stock = RealtimeTWSE('0050')
    data = stock.data['0050']
    print("{0} {1}".format(
        data['info']['name'].encode('utf-8'),
        data['price']))

if __name__ == "__main__":
    main()
