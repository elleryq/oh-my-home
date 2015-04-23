#!/usr/bin/env python
# -*- encoding: utf-8 -*-
from __future__ import print_function
from grs import RealtimeTWSE

def getRealtimeStock(stock_no):
    stock = RealtimeTWSE(stock_no)
    data = stock.data[stock_no]
    return (data['info']['name'], data['price'])


def main():
    stocks = ['0050', '0051']
    results = [getRealtimeStock(stock_no) for stock_no in stocks]
    for result in results:
        print("{0} {1}".format(
            result[0].encode('utf-8'),
            result[1]))

if __name__ == "__main__":
    main()
