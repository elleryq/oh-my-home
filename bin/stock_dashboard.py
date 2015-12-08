#!/usr/bin/env python
# -*- encoding: utf-8 -*-
from __future__ import print_function
import os
from urllib3.exceptions import HostChangedError
from grs import RealtimeTWSE, RealtimeOTC, Stock
from grs import RealtimeWeight


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
        return (stock_no, data['info']['name'], data['price'])
    except Exception, ex:
        print("Fail to get realtime information of '{}'".format(
            stock_no))
        print("> " + ex.message)
        return None


def main():
    try:
        realtime_weight = RealtimeWeight()
        for index, value in realtime_weight.data.items():
            print("{0} {1}".format(
                value['info']['name'].encode('utf-8'),
                value['price']))
    except KeyError, ex:
        print("Fail to get realtime weight, skip.")
        print("> " + ex.message)
    except HostChangedError, ex:
        print("Fail to get realtime weight, skip.")
        print("> " + ex.message)

    stocks = getStocksFromConfig()
    results = [getRealtimeStock(stock_no) for stock_no in stocks]
    for result in results:
        if not result:
            continue
        print("{0} {1} {2}".format(
            result[0],
            result[1].encode('utf-8'),
            result[2]))

if __name__ == "__main__":
    main()
