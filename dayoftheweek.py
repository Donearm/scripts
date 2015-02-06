#!/usr/bin/env python

# This script prints the date of the first Monday of each month, given the year as first argument.
# From there, it's easy to calculate every week day
# As seen on:
# http://blogs.fluidinfo.com/terry/2012/11/11/a-simple-way-to-calculate-the-day-of-the-week-for-any-day-of-a-given-year/trackback/
#
# Edited to work with Python >=3.2 by Gianluca Fiore

import datetime
import sys

try:
    year = int(sys.argv[1])
except IndexError:
    year = datetime.datetime.now().year

firstDayToFirstMonday = ['1st', '7th', '6th', '5th', '4th', '3rd', '2nd']
months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
summary = ''

for month in range(12):
    firstOfMonth = datetime.datetime(year, month + 1, 1).weekday()
    firstMonday = firstDayToFirstMonday[firstOfMonth]
    print(months[month], firstMonday)
    summary += firstMonday[0]

print('Summary:', '-'.join(summary[x:x+3] for x in range(0, 12, 3)))
