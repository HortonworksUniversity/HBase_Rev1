#!/bin/bash

. /root/dockerfiles/start_scripts/build.sh $@ || (echo "Parent build.sh failed"; exit 1)

apt-get update
apt-get install -y curl
apt-get install -y hbase sqoop libmysql-java
apt-get install -y mysql-client

# Build hwxu/hdp_zookeeper_node
echo -e "\n*** Building hwux/hdp_zookeeper_node ***\n"
cd /root/dockerfiles/hdp_zookeeper_node
docker build -t hwxu/hdp_zookeeper_node .
echo -e "\n*** Build of hwxu/hdp_zookeeper_node complete! ***\n"

# Build hwxu/hdp_hbase_node
echo -e "\n*** Building hwux/hdp_hbase_node ***\n"
cd /root/dockerfiles/hdp_hbase_node
docker build -t hwxu/hdp_hbase_node .
echo -e "\n*** Build of hwxu/hdp_hbase_node complete! ***\n"

# Build hwxu/hdp_hive_hbase_node
echo -e "\n*** Building hwux/hdp_hive_hbase_node ***\n"
cd /root/dockerfiles/hdp_hive_hbase_node
docker build -t hwxu/hdp_hive_hbase_node .
echo -e "\n*** Build of hwxu/hdp_hive_hbase_node complete! ***\n"

cp /root/$REPO_DIR/conf/hbase-site.xml /etc/hbase/conf/hbase-site.xml
echo "alias mysql='mysql -h hiveserver'" >> /etc/profile

#Fix bug in /etc/hosts (JIRA TRNG-715)
cat /etc/hosts | grep ubuntu | grep 127
if [[ $? > 0 ]];
then
  echo "127.0.0.1       localhost     ubuntu" >> /etc/hosts
fi

remove_untagged_images.sh

echo -e "\n*** The lab environment has successfully been built for this classroom VM ***\n"
