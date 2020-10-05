#!/bin/bash
#
# [K] (c)2020
# * 1 19071, 2 lean, 3 19073, 4 snapshot

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

cd friendlywrt-rk3328
cd kernel/

# cpu overclocking
if [ "$profile" == "4" ]; then
    # enable-1.4/1.5/1.6ghz-opp
    git apply --check ../../patches/rk3328-enable-1.4-1.5-1.6ghz-opp.patch && git apply ../../patches/rk3328-enable-1.4-1.5-1.6ghz-opp.patch
else
    # enable-1512mhz-opp
    wget https://github.com/armbian/build/raw/master/patch/kernel/rockchip64-dev/RK3328-enable-1512mhz-opp.patch
    git apply --check RK3328-enable-1512mhz-opp.patch && git apply RK3328-enable-1512mhz-opp.patch || echo ""
fi

# fix when during system boot,GPIO ocnflict with sdmmc

# patch for defconfig
git apply --check ../../patches/0001-Patch-for-nanopi-r2s_linux_defconfig.patch && git apply ../../patches/0001-Patch-for-nanopi-r2s_linux_defconfig.patch

cd ..

if [ -e "friendlywrt/target/linux/rockchip-rk3328/base-files/etc/init.d/fa-rk3328-misc" ]; then
	sed -i '/scaling_governor/d' friendlywrt/target/linux/rockchip-rk3328/base-files/etc/init.d/fa-rk3328-misc
fi

# fix upx
if [ ! -d "friendlywrt/tools/upx" ]; then
    git apply --check ../patches/0001-tools-include-upx-to-makefile.patch && git apply ../patches/0001-tools-include-upx-to-makefile.patch
    mkdir -p friendlywrt/tools/ucl
    mkdir -p friendlywrt/tools/upx
    rm -f friendlywrt/tools/ucl/Makefile
    rm -f friendlywrt/tools/upx/Makefile
    wget -O friendlywrt/tools/ucl/Makefile https://raw.githubusercontent.com/coolsnowwolf/lede/master/tools/ucl/Makefile
    wget -O friendlywrt/tools/upx/Makefile https://raw.githubusercontent.com/kongfl888/friendlywrt/snapshot/tools/upx/Makefile
fi

# fix uhttpd [temp]
if [ "$profile" == "4" ]; then
    if [ `cat friendlywrt/package/network/services/uhttpd/Makefile | grep -c "2020-09"` -gt 0 ]; then
        rm -f friendlywrt/package/network/services/uhttpd/Makefile
        wget -O friendlywrt/package/network/services/uhttpd/Makefile https://raw.githubusercontent.com/kongfl888/friendlywrt/master-20200906/package/network/services/uhttpd/Makefile
    fi
fi

cd ..
