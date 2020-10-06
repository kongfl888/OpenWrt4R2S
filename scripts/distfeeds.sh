#!/bin/sh
# [K] (C)2020
# built
# https://github.com/kongfl888/OpenWrt4R2S
# /etc/opkg/distfeeds.conf
# ** 1st: 1 19.07.1, 2 lean, 3 last-stable, 4 snapshot 2nd distfeeds path

profile=0

if [ ! -z "${1}" ];then
    case ${1} in
    1)
        profile=1
        ;;
    2)
        profile=2
        ;;
    3)
        profile=3
        ;;
    4)
        profile=4
        ;;
    *)
        profile=1
        ;;
    esac
fi

filepath="${2}"

[ $profile -eq 0 ] && exit 0
[ -z "$filepath" ] && exit 0

# set opkg feeds
if [ -f "$filepath" ];then
sed -i '/openwrt_core/d' $filepath
sed -i '/openwrt_freifunk/d' $filepath
sed -i '/openwrt_helloworld/d' $filepath
sed -i '/openwrt_packages/d' $filepath
echo "" >> $filepath
case $profile in
1)
    sed -i 's/releases\/.*\/package/releases\/19.07.1\/package/g' $filepath
    sed -i 's/snapshots\/package/releases\/19.07.1\/package/g' $filepath
    echo "src/gz openwrt_packages https://downloads.openwrt.org/releases/19.07.1/packages/aarch64_cortex-a53/packages" >> $filepath
    ;;
2)
    sed -i 's/releases\/.*\/package/releases\/18.06.8\/package/g' $filepath
    sed -i 's/snapshots\/package/releases\/18.06.8\/package/g' $filepath
    echo "src/gz openwrt_packages https://downloads.openwrt.org/releases/18.06.8/packages/aarch64_cortex-a53/packages" >> $filepath
    ;;
3)
    sed -i 's/releases\/.*\/package/releases\/19.07.4\/package/g' $filepath
    sed -i 's/snapshots\/package/releases\/19.07.4\/package/g' $filepath
    echo "src/gz openwrt_packages https://downloads.openwrt.org/releases/19.07.4/packages/aarch64_cortex-a53/packages" >> $filepath
    ;;
4)
    sed -i 's/releases\/.*\/package/snapshots\/package/g' $filepath
    echo "src/gz openwrt_packages https://downloads.openwrt.org/snapshots/packages/aarch64_cortex-a53/packages" >> $filepath
    ;;
*)
    sed -i 's/releases\/.*\/package/snapshots\/package/g' $filepath
    echo "src/gz openwrt_core https://downloads.openwrt.org/snapshots/targets/rockchip/armv8/packages" >> $filepath
    echo "src/gz openwrt_packages https://downloads.openwrt.org/snapshots/packages/aarch64_cortex-a53/packages" >> $filepath
    ;;
esac
sed -i 's/http:/https:/g' $filepath
#sed - 's/downloads.openwrt.org/openwrt.proxy.ustclug.org/g' $filepath
sed -i -r '/^$/d' $filepath
fi
