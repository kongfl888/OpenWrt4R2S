#!/bin/bash

cd friendlywrt-rk3328
cd kernel/
# enable-1512mhz-opp
wget https://github.com/armbian/build/raw/master/patch/kernel/rockchip64-dev/RK3328-enable-1512mhz-opp.patch
git apply --check RK3328-enable-1512mhz-opp.patch && git apply RK3328-enable-1512mhz-opp.patch || echo ""
# fix when during system boot,GPIO ocnflict with sdmmc
wget https://github.com/armbian/build/raw/master/patch/kernel/rockchip64-dev/add-board-nanopi-r2s.patch
git apply --check add-board-nanopi-r2s.patch && git apply add-board-nanopi-r2s.patch || echo ""

wget https://github.com/armbian/build/raw/master/patch/kernel/rockchip64-dev/add-rk3328-usb3-phy-driver.patch
git apply --check add-rk3328-usb3-phy-driver.patch && git apply add-rk3328-usb3-phy-driver.patch || echo ""

# patch for defconfig
git apply --check ../../patches/0001-Patch-for-nanopi-r2s_linux_defconfig.patch && git apply ../../patches/0001-Patch-for-nanopi-r2s_linux_defconfig.patch

cd ..
#cd friendlywrt
##Patch FireWall 以增添fullcone功能 
#mkdir package/network/config/firewall/patches
#wget -P package/network/config/firewall/patches/ https://github.com/LGA1150/fullconenat-fw3-patch/raw/master/fullconenat.patch
# Patch LuCI 以增添fullcone开关
#pushd feeds/luci
#wget -O- https://github.com/LGA1150/fullconenat-fw3-patch/raw/master/luci.patch | git apply
#popd
## Patch Kernel 以解决fullcone冲突
#pushd target/linux/generic/hack-5.4
#wget https://raw.githubusercontent.com/project-openwrt/openwrt/18.06-kernel5.4/target/linux/generic/hack-5.4/952-net-conntrack-events-support-multiple-registrant.patch
#popd

mkdir -p friendlywrt/staging_dir/host/bin/
if [ ! -e "friendlywrt/staging_dir/host/bin/upx" ];then
    ln -s /usr/bin/upx-ucl friendlywrt/staging_dir/host/bin/upx
fi
