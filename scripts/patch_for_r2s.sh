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

mkdir -p friendlywrt/staging_dir/host/bin/
if [ ! -e "friendlywrt/staging_dir/host/bin/upx" ];then
    ln -s /usr/bin/upx-ucl friendlywrt/staging_dir/host/bin/upx
fi

if [ -e "friendlywrt/target/linux/rockchip-rk3328/base-files/etc/init.d/fa-rk3328-misc" ]; then
	sed -i '/scaling_governor/d' friendlywrt/target/linux/rockchip-rk3328/base-files/etc/init.d/fa-rk3328-misc
fi
