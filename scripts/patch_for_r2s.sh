#!/bin/bash

cd friendlywrt-rk3328
cd kernel/
# enable-1512mhz-opp
wget https://github.com/armbian/build/raw/master/patch/kernel/rockchip64-dev/RK3328-enable-1512mhz-opp.patch
git apply --check RK3328-enable-1512mhz-opp.patch && git apply RK3328-enable-1512mhz-opp.patch || echo ""
# fix when during system boot,GPIO ocnflict with sdmmc

# patch for defconfig
git apply --check ../../patches/0001-Patch-for-nanopi-r2s_linux_defconfig.patch && git apply ../../patches/0001-Patch-for-nanopi-r2s_linux_defconfig.patch

cd ..

if [ -e "friendlywrt/target/linux/rockchip-rk3328/base-files/etc/init.d/fa-rk3328-misc" ]; then
	sed -i '/scaling_governor/d' friendlywrt/target/linux/rockchip-rk3328/base-files/etc/init.d/fa-rk3328-misc
fi

# fix upx
mkdir -p friendlywrt/tools/ucl
mkdir -p friendlywrt/tools/upx
rm -f friendlywrt/tools/ucl/Makefile
rm -f friendlywrt/tools/upx/Makefile
wget -O friendlywrt/tools/ucl/Makefile https://raw.githubusercontent.com/coolsnowwolf/lede/master/tools/ucl/Makefile
wget -O friendlywrt/tools/upx/Makefile https://raw.githubusercontent.com/kongfl888/lede/16d20af428d0a9ebf354af6f47d1a6b4dd820a71/tools/upx/Makefile

cd ..
