#!/bin/bash
#-------------------------------------------------------#
#Just only do copy mellanox driver from kernel-source
#to a special target location. By Clover 2014,11,19
#-------------------------------------------------------#
red='\e[0;31m'
nc='\e[0m'
lblue='\e[1;34m'
test ! -d /root/sda1/mlnx-driver-u1404-k3.13 && mkdir -p /root/sda1/mlnx-driver-u1404-k3.13/drivers

test ! -f map && find . -name *.ko |sort > map

target=/root/sda1/mlnx-driver-u1404-k3.13/drivers
source=`pwd`

while read line
do
        path=`dirname $line`
        if [ -d $target/$path ];then
                cp -af $line $target/$path
                if [ $? == "0" ];then
                        echo -e "cp $line ${lblue}finish${nc} !"
                else
                        echo -e "cp $line ${red}Failed${nc} !"
                fi
        else
                mkdir -p $target/$path
                cp -af $line $target/$path
                if [ $? == "0" ];then
                        echo -e "cp $line ${lblue}finish${nc} !"
                else
                        echo -e "cp $line ${red}Failed${nc} !"
                fi

        fi
done < map
