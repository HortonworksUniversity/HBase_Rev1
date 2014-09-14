#!/bin/bash
echo "creating timeline table"
######
# disable and drop timeline if it exists
########
echo "disable 'timeline'" | hbase shell
echo "drop 'timeline'" | hbase shell
####
# Create table with needed column family "a" and 10 versions per cell
####
echo "create 'timeline', {NAME => 'a', VERSIONS => 10}" | hbase shell