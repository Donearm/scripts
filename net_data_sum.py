#!/usr/bin/env python
# -*- coding: utf-8 -*-
###############################################################################
"""
Rewrite a file with network download/uploads statistics for the day to sum the
values basing on whether they are of the same date or not
"""
###############################################################################



__author__ = "Gianluca Fiore"
__license__ = "GPL"
__version__ = "1.0"
__mantainer__ = "Gianluca Fiore"
__date__ = "03/10/2008"
__email__ = "forod.g@gmail.com"
__status__ = "stable"

import re

date = re.compile('^(?P<date>\d+):') # matches the date
up = re.compile("Up.(?P<up>\d+).+") # matches the up total
down = re.compile("Down.(?P<down>\d+).+") # matches the down total

net_data = open("/mnt/documents/Stuff/net_data_statistics.txt", "r")

lines = net_data.readlines() # read each file's line

# Create one list containing the whole lines from the file
whole_lines = []
# and another containing the new, edited, lines
newLines = []

for line in lines:
    line_strip = line.strip()
    whole_lines.append(line_strip)
    if len(whole_lines) < 2:
        # if there aren't at least 2 lines in the list
        # there is no point in making a comparition
        newLines.append(whole_lines[-1])
    else:
        # save the two lines
        line1 = whole_lines[-1] 
        line2 = whole_lines[-2]
        lastDate = date.match(line1) # get the last date
        penultimateDate = date.match(line2) # get the penultimate date
        if lastDate.group(1) == penultimateDate.group(1):
            # sum the down and up totals
            line1Up = up.search(line1)
            line2Up = up.search(line2)
            line1Down = down.search(line1)
            line2Down = down.search(line2)
            newUpTot = int(line1Up.group(1)) + int(line2Up.group(1))
            newDownTot = int(line2Down.group(1)) + int(line2Down.group(1))
            # finally make the final string to be written back to the file
            newLine = "%s: Up[%s kB] Down[%s kB]" % \
                    (lastDate.group(1), newUpTot, newDownTot)
            
            # lastly, append the modified line to the final list and remove the
            # two latest lines   
            newLines.pop()
            newLines.append(newLine)
        else:
            # no duplicate dates then, just keep going on but before add the
            # penultimate line to a list
            newLines.append(whole_lines[-1])

# At this point, the file should have been corrected, write back to it
with open("/mnt/documents/Stuff/net_data_statistics.txt", "w") as net_data:
    for elements in newLines:
        net_data.write(elements + "\n")
