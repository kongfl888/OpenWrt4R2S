#!/bin/sh
# [K] (c) 2020

wget https://raw.githubusercontent.com/kongfl888/OpenWrt4R2S/master/JUNK/banner
mv -f banner package/base-files/files/etc
echo "" >> package/base-files/files/etc/banner
echo " Build on $(date)" >> package/base-files/files/etc/banner
echo "-----------------------------------------------------" >> package/base-files/files/etc/banner
echo -e "\n" >> package/base-files/files/etc/banner
