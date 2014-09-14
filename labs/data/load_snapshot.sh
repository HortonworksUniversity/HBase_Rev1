#!/bin/bash

tar -C /tmp -zxf snapshot.tgz
echo "Loading HBase snapshot for 'timeline' table"
su -l hbase -c "hadoop fs -put -f /tmp/snapshot/.hbase-snapshot/ /apps/hbase/data"
su -l hbase -c "hadoop fs -mkdir -p /apps/hbase/data/archive/data/default"
su -l hbase -c "hadoop fs -put -f /tmp/snapshot/timeline /apps/hbase/data/archive/data/default"
echo "Done!"
