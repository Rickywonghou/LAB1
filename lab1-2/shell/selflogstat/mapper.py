#!/usr/bin/env python
# coding: utf-8

import re
import sys

pat = re.compile('(?P<ip>\d+\.\d+\.\d+\.\d+).*?\d{4}:(?P<hour>\d{2}):\d{2}.*? ')
h_start = int(os.environ['param_h0'])
h_end = int(os.environ['param_h1'])

for line in sys.stdin:
    match = pat.search(line)
    if match:
        if (int(match.group('hour')) >= h_start) & (int(match.group('hour')) < h_end):
            print('%s\t%s' % ('[' + match.group('hour') + ':00' + ']', match.group('ip') + '1'))


