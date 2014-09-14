#!/bin/bash

tar -zxvf orders.tgz
echo "Creating database 'orders'"
echo "drop database if exists orders; create database orders;" | mysql -h hiveserver -u root
echo "Loading tables and data into database 'orders'"
mysql -h hiveserver -u root orders < orders.sql
echo "Done!"
