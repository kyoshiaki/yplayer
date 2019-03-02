#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
import time
import getopt

# DataTime

class DataTime:
    def __init__(self, path):
        self.path = path

    def time(self):
        gtime = os.path.getmtime(self.path)
        stime = time.localtime(gtime)
        ltime = (stime.tm_year, stime.tm_mon, stime.tm_mday, stime.tm_hour, stime.tm_min, stime.tm_sec)
        return (gtime, ltime)

# DirLs

class DirLs:
    def __init__(self, path):
        self.path = path

        self.files = []
        self.dir = []
    
        for item in os.listdir(self.path):
            if item == '.DS_Store':
                continue
            fullpath = os.path.join(self.path, item)
            cdata = DataTime(fullpath)
            info_time = cdata.time()
            info_size = os.path.getsize(fullpath)
            flag = os.path.isdir(fullpath)
            if flag == False:
                self.files.append((item, fullpath, info_time[0], info_time[1], info_size))
            else:
                self.dir.append((item, fullpath, info_time[0], info_time[1]))
    
        self.files = sorted(self.files, key=lambda tup: tup[2], reverse=True)
    
    def delete_files(self, max):
        if len(self.files) > max:
            return self.files[max:]
        else:
            return []

def print_ls(item):
    print "%(size)14d %(year)4d/%(month)02d/%(day)02d %(hh)02d:%(mm)02d:%(ss)02d %(file)-26s " % {"file": item[0], "size": item[4], "year":item[3][0], "month":item[3][1], "day":item[3][2], "hh":item[3][3], "mm":item[3][4], "ss":item[3][5]}

# walk
def walk(path):
    print "{0}:".format(path)
    ds = DirLs(path)
    for item in ds.files:
        print_ls(item)
    for ditem in ds.dir:
        walk(ditem[1])

# delete_walk

def delete_walk(path, max, del_flag):
    print "{0}:".format(path)
    ds = DirLs(path)
    for item in ds.delete_files(max):
        print_ls(item)
        if del_flag == True:
            os.remove(item[1])
    for ditem in ds.dir:
        delete_walk(ditem[1], max, del_flag)

# main

optlist, args = getopt.getopt(sys.argv[1:], "yad:")

delete_flag = False
all_flag = False
dirname = ""
max = -1

for i in optlist:
    if i[0] == '-y':
        delete_flag = True
    elif i[0] == '-d':
        dirname = i[1]
    elif i[0] == '-a':
        all_flag = True

if len(args) == 1:
    max = int(args[0])

if (all_flag == True and dirname == "") or (all_flag == False and (dirname == "" or max == -1)):
    print "USAGE: delete.py [options] -d directory max"
    print "OPTIONS:"
    print "-a         print all files"
    print "-y         execute delete command"
    print "-d <value> root search directory "
    print "max        maximum of remaining files"
    exit()

flag = os.path.isdir(dirname)
if flag == False:
    print "Not exist directory:{0}".format(dirname)
    exit()

if all_flag == True:
    walk(dirname)
elif delete_flag == True:
    print "delete files"
    delete_walk(dirname, max, True)
else:
    delete_walk(dirname, max, False)
