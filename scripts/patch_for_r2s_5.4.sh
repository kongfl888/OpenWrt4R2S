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
    rm -rf openwrt || echo ""
fi
