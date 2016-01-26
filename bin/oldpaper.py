#!/usr/bin/env python
from __future__ import print_function, unicode_literals
import json
import requests
import pprint
from datetime import datetime


_escape = dict((q, dict((c, unicode(repr(chr(c)))[1:-1])
                        for c in range(32) + [ord('\\')] +
                        range(128, 161),
                        **{ord(q): u'\\' + q}))
               for q in ["'", '"'])


class MyPrettyPrinter(pprint.PrettyPrinter):
    def format(self, object, context, maxlevels, level):
        if type(object) is unicode:
            q = "'" if "'" not in object or '"' in object \
                else '"'
            return ("u" + q + object.translate(_escape[q]) +
                    q, True, False)
            #return (object.translate(_escape[q]), True, False)
        return pprint.PrettyPrinter.format(
            self, object, context, maxlevels, level)


pp = MyPrettyPrinter()


def main():
    response = requests.get("http://oldpaper.g0v.ronny.tw/index/json")
    result = json.loads(response.content)
    if 'data' in result:
        papers = result['data']
        headlines = papers[0]['headlines']
        dt = datetime.fromtimestamp(papers[0]['time'])
        if datetime.now().date() == dt.date():
            day = "Today"
        else:
            day = "Yesterday"
        print('{day} headlines {paper_date}'.format(
            day=day,
            paper_date=dt.strftime('%Y/%m/%d')))
        for paper, title in headlines:
            print('  {paper} {title}'.format(
                paper=paper, title=title).encode('utf-8'))

#        for paper in papers:
#            pp.pprint(paper)

if __name__ == "__main__":
    main()
