#!/usr/bin/env python
# coding: utf-8

import sys
from operator import itemgetter

dict_hour_count = {}
for line in sys.stdin:
    dict_ip_count = {}
    line = line.strip()
    hour, ip = line.split('\t')
    num = ip[-1]
    num = int(num)
    ip = ip[:-1]
    hour = int(hour[1:3])
    if hour not in dict_hour_count.keys():
        dict_ip_count[ip] = num
        dict_hour_count[hour] = dict_ip_count
    else:
        dict_ip_count = dict_hour_count[hour]
        dict_ip_count[ip] = dict_ip_count.get(ip, 0) + num
        dict_hour_count[hour] = dict_ip_count

for i in range(24):
    try:
        sorted_ip_count = sorted((dict_hour_count[i].items()), key=itemgetter(1))[::-1][0:3]
        for ip, count in sorted_ip_count:
            print('%s\t%s' % ('[' + "%02d" % i + ':00' + ']'+ip, count))
    except:
        pass