#!/bin/bash
#
# [K] (c)2020
#

snapshot=0

if [ "${1}" == "1" ]; then
    snapshot=1
fi

cd friendlywrt-rk3328

if [ "$snapshot" == "1" ]; then
    cd friendlywrt
else
    git clone https://github.com/openwrt/openwrt && cd openwrt/
fi

rm -f target/linux/generic/*/*led*.patch
rm -f target/linux/generic/*/*mips*.patch
rm -f target/linux/generic/*/*MIPS*.patch
rm -f target/linux/generic/*/*x86*.patch
cp -a ./target/linux/generic/files/* ../kernel/
./scripts/patch-kernel.sh ../kernel target/linux/generic/backport-5.4
./scripts/patch-kernel.sh ../kernel target/linux/generic/pending-5.4
./scripts/patch-kernel.sh ../kernel target/linux/generic/hack-5.4
cd ../

if [ "$snapshot" != "1" ]; then
    rm -rf openwrt || echo ""
fi
