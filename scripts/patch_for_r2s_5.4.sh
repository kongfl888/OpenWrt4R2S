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

rm -rf /tmp/linuxgeneric || echo ""
mkdir -p /tmp/linuxgeneric
cp -arf target/linux/generic/* /tmp/linuxgeneric
rm -f /tmp/linuxgeneric/*/*leds*.patch
rm -f /tmp/linuxgeneric/*/*mips*.patch
rm -f /tmp/linuxgeneric/*/*MIPS*.patch
rm -f /tmp/linuxgeneric/*/*x86*.patch
cp -a /tmp/linuxgeneric/files/* ../kernel/
./scripts/patch-kernel.sh ../kernel /tmp/linuxgeneric/backport-5.4
./scripts/patch-kernel.sh ../kernel /tmp/linuxgeneric/pending-5.4
./scripts/patch-kernel.sh ../kernel /tmp/linuxgeneric/hack-5.4
cd ../

if [ "$snapshot" != "1" ]; then
    rm -rf openwrt || echo ""
fi
