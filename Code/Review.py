##### review.json -> review.csv

# -*- coding: utf-8 -*-

import csv, json, os
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

# Set working directory
os.chdir('/Users/mpang/Desktop')

# Initialize count variable to increment within for loop
count = 0

# Create empty list to store elements of dictionaries from json file
data = []

# Write each json "line" to a list of dictionaries (key-value pairs)
# I do this since the last line of the file is not well formatted (multiple 
# values for a single key). As such, I cannot use the json.load() method.
with open('review.json') as f:
    for line in f:
        #print line
        data.append(json.loads(line))
        count += 1
    
print "Done reading in json file"
print "Number of lines read in:", count

# Store the keys from the list of dictionaries (i.e. 'review_id', 'user_id')
keys = data[0].keys()

# Open a .csv, write header with key values, write contents of values from list
# of dictionaries to rows based on key values.

with open('review.csv', 'wb') as output_file:
    dict_writer = csv.DictWriter(output_file, keys)
    dict_writer.writeheader()
    dict_writer.writerows(data)
