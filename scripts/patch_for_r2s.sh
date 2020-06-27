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
