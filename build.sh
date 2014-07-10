#!/bin/bash

. /root/dockerfiles/start_scripts/build.sh $@ && (echo "Parent build.sh failed"; exit 1)

apt-get install curl

# Build hwxu/hdp_zookeeper_node
echo -e "\n*** Building hwux/hdp_zookeeper_node ***\n"
cd /root/dockerfiles/hdp_zookeeper_node
docker build -t hwxu/hdp_zookeeper_node .
echo -e "\n*** Build of hwxu/hdp_zookeeper_node complete! ***\n"

# Build hwxu/hdp_hbase_node
echo -e "\n*** Building hwux/hdp_hbase_node ***\n"
cd /root/$REPO_DIR/dockerfiles/hdp_hbase_node
docker build -t hwxu/hdp_hbase_node .
echo -e "\n*** Build of hwxu/hdp_hbase_node complete! ***\n"

remove_untagged_images.sh

echo -e "\n*** The lab environment has successfully been built for this classroom VM ***\n"
