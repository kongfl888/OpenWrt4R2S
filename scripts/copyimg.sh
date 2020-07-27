#! /bin/bash
#
# [K] (c)2020
#

mkdir -p ./imgs/

for i in `find friendlywrt-rk3328/friendlywrt/bin/targets/ -maxdepth 5 -name '*.img'`; do
    cp -f $i ./imgs/
done

gzip ./imgs/*.img || echo ""

cd ./imgs/
sha256sum *img* > imgs.sha256 || echo "blank" > noimg.txt
cd ..
