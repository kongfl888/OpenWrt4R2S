#!/bin/sh
# [K] (c)2020

echo "Check of SHA256"
echo " "
sha256sum -c sha256sum.txt
echo "-----"
echo "Press any key to continue!"
read -n 1
