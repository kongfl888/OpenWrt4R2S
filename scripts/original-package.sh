#!/bin/bash

fullin=0

if [ "${1}" == "1" ];then
fullin=1
fi

git clone -b master --single-branch https://github.com/Lienol/openwrt-package.git

# luci-lib-jsonc patch
cd friendlywrt-rk3328
git apply ../patches/use_json_object_new_int64.patch
cd ..

leanpack="friendlywrt-rk3328/friendlywrt/package/lean"
lienolpack="friendlywrt-rk3328/friendlywrt/package/lienol"
ctcgfwpack="friendlywrt-rk3328/friendlywrt/package/ctcgfw"
themepack="friendlywrt-rk3328/friendlywrt/feeds/luci/themes"

mkdir -p $leanpack
mkdir -p $themepack

#get theme
#rm -rf friendlywrt-rk3328/feeds/*/*/luci-theme-argon/ >/dev/null 2>&1 || echo ""
#cp -rf openwrt/package/ctcgfw/luci-theme-argon $themepack

rm -rf friendlywrt-rk3328/feeds/*/*/luci-theme-bootstrap-mod/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lienol/luci-theme-bootstrap-mod $themepack

#get luci-app-accesscontrol
rm -rf friendlywrt-rk3328/feeds/*/*/luci-app-accesscontrol/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/luci-app-accesscontrol/ $leanpack

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
cp -rf openwrt/package/lean/vlmcsd/ $leanpack
cp -rf openwrt/package/lean/luci-app-vlmcsd/ $leanpack

#get luci-lib-fs
rm -rf friendlywrt-rk3328/feeds/*/*/luci-lib-fs/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/luci-lib-fs/ $leanpack

#get luci-app-filetransfer
rm -rf friendlywrt-rk3328/feeds/*/*/luci-app-filetransfer/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/luci-app-filetransfer/ $leanpack

#get luci-app-zerotier
rm -rf friendlywrt-rk3328/feeds/*/*/luci-app-zerotier/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/luci-app-zerotier/ $leanpack

#get luci-app-syncdial
rm -rf friendlywrt-rk3328/feeds/*/*/luci-app-syncdial/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/luci-app-syncdial/ $leanpack

#get ddns-scripts_aliyun/dnspod
rm -rf friendlywrt-rk3328/feeds/*/*/ddns-scripts_aliyun/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/ddns-scripts_aliyun/ $leanpack
rm -rf friendlywrt-rk3328/feeds/*/*/ddns-scripts_dnspod/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/ddns-scripts_dnspod/ $leanpack

#get luci-app-mwan3helper
rm -rf friendlywrt-rk3328/feeds/*/*/luci-app-mwan3helper/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/luci-app-mwan3helper/ $leanpack

# big
if [ "$fullin" = "1" ]; then
# get luci-app-flowoffload
rm -rf friendlywrt-rk3328/feeds/*/*/luci-app-flowoffload/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/luci-app-flowoffload/ $leanpack

# get qbittorrent
rm -rf friendlywrt-rk3328/feeds/*/*/qbittorrent/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/qbittorrent/ $leanpack
rm -rf friendlywrt-rk3328/feeds/*/*/rblibtorrent/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/rblibtorrent/ $leanpack
rm -rf friendlywrt-rk3328/feeds/*/*/luci-app-qbittorrent/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/luci-app-qbittorrent/ $leanpack
# big
fi

#autocore
cd openwrt
git apply ../patches/enable_autocore_1907.patch
cd ..
cp -rf openwrt/package/lean/autocore/ $leanpack
cp -rf openwrt/package/lean/coremark $leanpack 
sed -i 's,-DMULTIT,-Ofast -DMULTIT,g' $leanpack/coremark/Makefile
