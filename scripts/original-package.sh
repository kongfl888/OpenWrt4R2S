#!/bin/bash

leanpack="friendlywrt-rk3328/friendlywrt/package/lean"

mkdir -p $leanpack

# get adbyby
rm -rf friendlywrt-rk3328/feeds/package/*/adbyby/ >/dev/null 2>&1 || echo ""
rm -rf friendlywrt-rk3328/feeds/*/*/luci-app-adbyby-plus/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/adbyby/ $leanpack
cp -rf openwrt/package/lean/luci-app-adbyby-plus/ $leanpack

#get luci-app-arpbind
rm -rf friendlywrt-rk3328/feeds/*/*/luci-app-arpbind/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/luci-app-arpbind/ $leanpack

#get luci-app-ramfree
rm -rf friendlywrt-rk3328/feeds/*/*/luci-app-ramfree/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/luci-app-ramfree/ $leanpack

#get luci-app-vlmcsd
rm -rf friendlywrt-rk3328/feeds/*/*/luci-app-vlmcsd/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/luci-app-vlmcsd/ $leanpack

#get luci-app-filetransfer
rm -rf friendlywrt-rk3328/feeds/*/*/luci-app-filetransfer/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/luci-app-filetransfer/ $leanpack

#get luci-app-zerotier
rm -rf friendlywrt-rk3328/feeds/*/*/luci-app-zerotier/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/luci-app-zerotier/ $leanpack

#autocore
cd openwrt
git apply ../patches/enable_autocore_1907.patch
cd ..
cp -rf openwrt/package/lean/autocore/ $leanpack
cp -rf openwrt/package/lean/coremark $leanpack 
sed -i 's,-DMULTIT,-Ofast -DMULTIT,g' $leanpack/coremark/Makefile
