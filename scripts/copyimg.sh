#! /bin/bash
#
# [K] (c)2020
#

mkdir -p ./imgs/

for i in `find friendlywrt/bin/targets/ -name '*.img'`; do
    cp -f $i ./imgs/
done

gzip ./imgs/*.img

cd ./imgs/
sha256sum *.img > imgs.sha256 || echo "blank" > noimg.txt
cd ..
