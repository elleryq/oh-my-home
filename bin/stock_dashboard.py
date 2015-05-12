#!/usr/bin/env python
# -*- encoding: utf-8 -*-
from __future__ import print_function
import os
from grs import RealtimeTWSE, RealtimeOTC, Stock


def getStocksFromConfig():
    from ConfigParser import SafeConfigParser

    configFile = os.path.join(
        os.path.expanduser("~/.config"),
        "stock_dashboard.ini")
    if not os.path.exists(configFile):
        return ['0050', '0051']

    parser = SafeConfigParser()
    parser.read(configFile)
    if not parser.has_option('main', 'stocks'):
        return ['0050', '0051']

    stocks = parser.get('main', 'stocks')
    return stocks.split(',')

def getRealtimeStock(stock_no):
    realtime = {True: RealtimeTWSE, False: RealtimeOTC}
    try:
        stock = Stock(stock_no)
        info = realtime[stock._twse](stock_no)
        data = info.data[stock_no]
        return (data['info']['name'], data['price'])
    except Exception, ex:
        #print(ex)
        return None


def main():
    #stocks = ['0050', '0051', '2347']
    stocks = getStocksFromConfig()
    results = [getRealtimeStock(stock_no) for stock_no in stocks]
    for result in results:
        if not result:
            continue
        print("{0} {1}".format(
            result[0].encode('utf-8'),
            result[1]))

if __name__ == "__main__":
    main()
