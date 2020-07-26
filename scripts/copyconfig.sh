#! /bin/bash
#
# [K] (c)2020
#

mkdir -p ./r2sconfig/

cp friendlywrt-rk3328/friendlywrt/.config ./r2sconfig/wrt.config
friendlywrt-rk3328/friendlywrt/scripts/diffconfig.sh > ./r2sconfig/wrt-user.config || echo ""
cd friendlywrt-rk3328/kernel
export PATH=/opt/FriendlyARM/toolchain/6.4-aarch64/bin/:$PATH
export CROSS_COMPILE='aarch64-linux-gnu-'
export ARCH=arm64
make savedefconfig || echo ""
cd ../../
cp friendlywrt-rk3328/kernel/.config ./r2sconfig/defconfig.config || echo ""
cp friendlywrt-rk3328/kernel/defconfig ./r2sconfig/defconfig-user.config || echo ""
