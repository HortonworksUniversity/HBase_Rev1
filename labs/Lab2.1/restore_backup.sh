#!/bin/bash
echo "Disablin timeline table"
#####
# disable Timeline table
#####
echo "disable 'timeline'" | hbase shell
######
# restore snapshot
######
echo "restore_snapshot 'timeline_back'" | hbase shell
######
# Create table with needed column family "a" and 10 versions per cell
######
echo "enable 'timeline'" | hbase shell
