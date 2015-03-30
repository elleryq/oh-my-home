import codecs
import sys

encoding = sys.argv[1]
filename = sys.argv[2]

with codecs.open(filename, mode='rt', encoding=encoding) as f:
    for line in f:
        print(line.strip().encode('utf-8'))
