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
    kernelver=`cat ./include/kernel-version.mk | grep "LINUX_VERSION-5.4" | cut -d"." -f3`
    if [ $kernelver -lt 67 ]; then
        git remote add upkernel https://github.com/graysky2/openwrt.git && git fetch upkernel updatedkernel
        git cherry-pick 4ce0bd6d83554497643ca51f9d85a6e656b898e0
    fi
else
    git clone -b snapshot --single-branch --depth=1 https://github.com/kongfl888/friendlywrt.git fwrt && cd fwrt/
fi

rm -rf /tmp/linuxgeneric || echo ""
mkdir -p /tmp/linuxgeneric
cp -arf target/linux/generic/* /tmp/linuxgeneric
cp -f ./scripts/patch-kernel.sh /tmp/patchkernel.sh && chmod +x /tmp/patchkernel.sh
rm -f /tmp/linuxgeneric/*/*leds*.patch
rm -f /tmp/linuxgeneric/*/*mips*.patch
rm -f /tmp/linuxgeneric/*/*MIPS*.patch
rm -f /tmp/linuxgeneric/*/*x86*.patch
rm -f /tmp/linuxgeneric/*/*sfp-*.patch
rm -f /tmp/linuxgeneric/*/*sfp_*.patch
rm -f /tmp/linuxgeneric/*/*SFP-*.patch
rm -f /tmp/linuxgeneric/*/*GPON-*.patch
rm -f /tmp/linuxgeneric/*/*gpon-*.patch
rm -f /tmp/linuxgeneric/*/*BCM84881*.patch

cp -a /tmp/linuxgeneric/files/* ../kernel/
sed -i '/exit 1/d' /tmp/patchkernel.sh
/tmp/patchkernel.sh ../kernel /tmp/linuxgeneric/backport-5.4
/tmp/patchkernel.sh ../kernel /tmp/linuxgeneric/pending-5.4
/tmp/patchkernel.sh ../kernel /tmp/linuxgeneric/hack-5.4
cd ../

if [ "$snapshot" != "1" ]; then
    rm -rf fwrt/ || echo ""
fi
