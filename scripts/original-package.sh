#!/bin/bash
#
# [K] (C)2020
#
# ** 1 fullin, 2 lite, 3 little included; 1 19071, 2 lean, 3 19073, 4 snapshot


fullin=0
lite=0
little=0
profile=0

if [ ! -z "${1}" ];then
    let pf=${1}%10
    case $pf in
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
    let lt=${1}/10
    case $lt in
    1)
        fullin=1
        ;;
    2)
        lite=1
        ;;
    3)
        little=1
        ;;
    *)
        lite=1
        ;;
    esac
fi

sed -i '/feeds update -a/d' friendlywrt-rk3328/scripts/mk-friendlywrt.sh || echo ""
sed -i '/feeds install/d' friendlywrt-rk3328/scripts/mk-friendlywrt.sh || echo ""

cd friendlywrt-rk3328/friendlywrt
# Patch FireWall - fullcone
mkdir package/network/config/firewall/patches
wget -P package/network/config/firewall/patches/ https://github.com/LGA1150/fullconenat-fw3-patch/raw/master/fullconenat.patch
# Patch luci-app-firewall fullcone option
pushd feeds/luci
wget -O- https://github.com/LGA1150/fullconenat-fw3-patch/raw/master/luci.patch | git apply
popd
cd ../../

cp -f ./resources/zh_Hans/base.po friendlywrt-rk3328/friendlywrt/feeds/luci/modules/luci-base/po/zh_Hans/base.po || echo ""

#git clone -b master --single-branch https://github.com/Lienol/openwrt-package.git

# patch feeds、package
cd friendlywrt-rk3328/friendlywrt
#clear unused
rm -rf package/feeds/lienol/*/luci-app-verysync || echo ""
rm -rf feeds/lienol/*/shadowsocksr-libev || echo ""
rm -rf feeds/lienol/package/verysync || echo ""
# luci-lib-jsonc patch
git apply ../../patches/use_json_object_new_int64.patch

# luci-status cpu info
case $profile in
1)
    git apply ../../patches/patch-for-19.07.1-cpu-info.patch
    git apply ../../patches/path-for-19.07.1-ethinfo.patch
    ;;
3)
    git apply ../../patches/patch-for-19.07.3-cpu-info.patch
    git apply ../../patches/path-for-19.07.1-ethinfo.patch
    ;;
4)
    git apply ../../patches/patch-for-snapshot-cpu-info.patch
    git apply ../../patches/path-for-snapshot-ethinfo.patch
    ;;
*)
    git apply ../../patches/patch-feeds-luci-status-overiew.patch
    git apply ../../patches/path-for-19.07.1-ethinfo.patch
    ;;
esac

# add nas menu
if [ -e "feeds/luci/modules/luci-base/root/usr/share/luci/menu.d/luci-base.json" ]; then
    git apply ../../patches/19-07-3-luci-base-json-add-nas-menu-order-44.patch
else
    git apply ../../patches/19-07-1-lua-add-nas-first-menu-order-44.patch
fi
#patch nas sw
sh ../../scripts/patch_for_nas_software.sh
cd ../../

wrtpackage="friendlywrt-rk3328/friendlywrt/package"
leanpack="friendlywrt-rk3328/friendlywrt/package/lean"
lienolpack="friendlywrt-rk3328/friendlywrt/package/lienol"
ctcgfwpack="friendlywrt-rk3328/friendlywrt/package/ctcgfw"

feedsluci="friendlywrt-rk3328/friendlywrt/feeds/luci"
feedspackages="friendlywrt-rk3328/friendlywrt/feeds/packages"
themepack="friendlywrt-rk3328/friendlywrt/feeds/luci/themes"
luciapppack="friendlywrt-rk3328/friendlywrt/feeds/luci/applications"

mkdir -p $leanpack
mkdir -p $themepack

#get theme
#rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/luci-theme-argon/ >/dev/null 2>&1 || echo ""
#cp -rf openwrt/package/ctcgfw/luci-theme-argon $themepack

rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/luci-theme-bootstrap-mod/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lienol/luci-theme-bootstrap-mod $themepack

#get luci-app-accesscontrol
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/luci-app-accesscontrol/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/luci-app-accesscontrol/ $leanpack

# get adbyby
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/adbyby/ >/dev/null 2>&1 || echo ""
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/luci-app-adbyby-plus/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/adbyby/ $leanpack
cp -rf openwrt/package/lean/luci-app-adbyby-plus/ $leanpack
# patch adbyby
wget -q https://raw.githubusercontent.com/kongfl888/ad-rules/master/scripts/patch-adbyby.sh
sh ./patch-adbyby.sh $leanpack/luci-app-adbyby-plus/root/usr/share/adbyby
wget -q https://raw.githubusercontent.com/kongfl888/ad-rules/master/video.txt
mv -f video.txt $leanpack/adbyby/files/data/ || echo ""
wget -q https://raw.githubusercontent.com/kongfl888/ad-rules/master/lazy.txt
mv -f lazy.txt $leanpack/adbyby/files/data/ || echo ""

# get smartdns
if [ "$profile" != "4" ]; then
    rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/smartdns/ >/dev/null 2>&1 || echo ""
    git clone -b master --single-branch https://github.com/pymumu/openwrt-smartdns.git
    mkdir -p $wrtpackage/net/smartdns
    rm -rf $wrtpackage/net/smartdns/*
    mv -f openwrt-smartdns/* $wrtpackage/net/smartdns
fi
if [ "$profile" == "4" ];then
    rm -rf $feedsluci/*/luci-app-smartdns/po
    sed -i 's/admin\/services/admin\/network/g' $feedsluci/*/luci-app-smartdns/root/usr/share/luci/menu.d/luci-app-smartdns.json || echo ""
else
    rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/luci-app-smartdns/ >/dev/null 2>&1 || echo ""
    git clone -b lede --single-branch https://github.com/pymumu/luci-app-smartdns.git
    rm -rf luci-app-smartdns/po
    sed -i 's/\"services\"/\"network\"/g' luci-app-smartdns/luasrc/controller/smartdns.lua
    sed -i 's/admin\/services\/smartdns/admin\/network\/smartdns/g' luci-app-smartdns/luasrc/model/cbi/smartdns/smartdns.lua
    sed -i 's/admin\/services\/smartdns/admin\/network\/smartdns/g' luci-app-smartdns/luasrc/model/cbi/smartdns/upstream.lua
    sed -i 's/\"services\"/\"network\"/g' luci-app-smartdns/luasrc/view/smartdns/smartdns_status.htm
    cp -rf luci-app-smartdns $wrtpackage/
fi
git clone -b master https://github.com/kongfl888/luci-i18n-smartdns-zh-cn.git $wrtpackage/luci-i18n-smartdns-zh-cn

#get luci-app-arpbind
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/luci-app-arpbind/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/luci-app-arpbind/ $leanpack

#get luci-app-ramfree
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/luci-app-ramfree/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/luci-app-ramfree/ $leanpack

#get luci-app-vlmcsd
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/luci-app-vlmcsd/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/vlmcsd/ $leanpack
cp -rf openwrt/package/lean/luci-app-vlmcsd/ $leanpack

#get luci-lib-fs
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/luci-lib-fs/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/luci-lib-fs/ $leanpack

#get luci-app-filetransfer
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/luci-app-filetransfer/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/luci-app-filetransfer/ $leanpack

#get luci-app-zerotier
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/luci-app-zerotier/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/luci-app-zerotier/ $leanpack

#get kcptun
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/kcptun/ >/dev/null 2>&1 || echo ""
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/*/kcptun/ >/dev/null 2>&1 || echo ""
#sed -i '/bin\/upx/d' openwrt/package/lean/kcptun/Makefile
rm -f openwrt/package/lean/kcptun/Makefile
wget -O openwrt/package/lean/kcptun/Makefile https://raw.githubusercontent.com/coolsnowwolf/lede/master/package/lean/kcptun/Makefile
cp -rf openwrt/package/lean/kcptun/ $leanpack

#get ssr depends p1
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/shadowsocksr-libev/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/shadowsocksr-libev/ $leanpack
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/tcpping/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/tcpping/ $leanpack

#get wrtbwmon
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/wrtbwmon/ >/dev/null 2>&1 || echo ""
git clone -b master https://github.com/brvphoenix/wrtbwmon.git
cp -rf wrtbwmon/wrtbwmon $wrtpackage
git clone -b master-k https://github.com/kongfl888/luci-app-wrtbwmon.git
if [ "$profile" != "4" ]; then
    mkdir -p luci-app-wrtbwmon/luci-app-wrtbwmon/luasrc/controller
    rm -f luci-app-wrtbwmon/luci-app-wrtbwmon/luasrc/controller/wrtbwmon.lua || echo ""
    wget -O luci-app-wrtbwmon/luci-app-wrtbwmon/luasrc/controller/wrtbwmon.lua https://raw.githubusercontent.com/kongfl888/luci-app-wrtbwmon/6fe8e08076afcbe9631880807203ca48c97c6ac5/luci-app-wrtbwmon/luasrc/controller/wrtbwmon.lua
    rm -rf luci-app-wrtbwmon/luci-app-wrtbwmon/root/usr/share/luci/menu.d || echo ""
fi
cp -rf luci-app-wrtbwmon/luci-app-wrtbwmon $wrtpackage

#get fullconenat
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/openwrt-fullconenat/ >/dev/null 2>&1 || echo ""
rm -rf $leanpack/openwrt-fullconenat || echo ""
git clone https://github.com/kongfl888/openwrt-fullconenat.git  $wrtpackage/fullconenat

##### big ####
if [ "$fullin" = "1" ]; then

#get luci-app-syncdial
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/luci-app-syncdial/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/luci-app-syncdial/ $leanpack

#get ddns-scripts_aliyun/dnspod
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/ddns-scripts_aliyun/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/ddns-scripts_aliyun/ $leanpack
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/ddns-scripts_dnspod/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/ddns-scripts_dnspod/ $leanpack

#get luci-app-mwan3helper
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/luci-app-mwan3helper/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/luci-app-mwan3helper/ $leanpack

# get qbittorrent
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/qbittorrent*/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/qBittorrent-Enhanced-Edition/ $leanpack
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/libtorrent-rasterbar/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/libtorrent-rasterbar/ $leanpack
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/luci-app-qbittorrent/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/luci-app-qbittorrent/ $leanpack

# get qt5
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/qt5/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/qt5/ $leanpack

# get unblockmusic
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/luci-app-unblockmusic/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/luci-app-unblockmusic/ $leanpack
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/UnblockNeteaseMusic-Go/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/UnblockNeteaseMusic-Go/ $leanpack
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/UnblockNeteaseMusic/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/UnblockNeteaseMusic/ $leanpack

# get luci-app-flowoffload
#rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/luci-app-flowoffload/ >/dev/null 2>&1 || echo ""
#cp -rf openwrt/package/lean/luci-app-flowoffload/ $leanpack
# patch luci-app-flowoffload
#sed -i 's/@LINUX_5_4//' $leanpack/luci-app-flowoffload/Makefile

# get luci-app-ssrserver-python
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/luci-app-ssrserver-python/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/luci-app-ssrserver-python/ $leanpack

#get ssr depends p2
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/srelay/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/srelay/ $leanpack
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/microsocks/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/microsocks/ $leanpack
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/proxychains-ng/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/proxychains-ng/ $leanpack
git clone -b master --single-branch https://github.com/aa65535/openwrt-simple-obfs  $leanpack/simple-obfs
git clone -b master --single-branch https://github.com/kongfl888/redsocks2.git $leanpack/redsocks2

# big
fi

#### little or big ####
if [ "$little" = "1" -o "$fullin" = "1" ]; then

#get luci-app-vssr
git clone -b master --single-branch https://github.com/jerrykuku/lua-maxminddb.git  $leanpack/lua-maxminddb
git clone -b master --single-branch https://github.com/jerrykuku/luci-app-vssr.git  $leanpack/luci-app-vssr

# little or big
fi

#coremark
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/coremark/ >/dev/null 2>&1 || echo ""
cp -rf openwrt/package/lean/coremark $leanpack
rm -f $leanpack/coremark/Makefile && wget -O $leanpack/coremark/Makefile https://raw.githubusercontent.com/kongfl888/lede/test/files/core-Makefile
sed -i 's,-DMULTIT,-Ofast -DMULTIT,g' $leanpack/coremark/Makefile
sed -i 's,\/etc\/coremark.sh\",\/etc\/coremark.sh \&\",g' $leanpack/coremark/Makefile

if [ "$profile" == "4" ]; then
    #luci-k-permission
    git clone -b master --single-branch https://github.com/kongfl888/luci-k-permission.git $wrtpackage/luci-k-permission
fi

#kcpufreq
git clone -b master --single-branch https://github.com/kongfl888/luci-app-kcpufreq.git $wrtpackage/luci-app-kcpufreq

#koptimalize
git clone -b master https://github.com/kongfl888/koptimalize.git $wrtpackage/koptimalize

#add upx
cp -f ./resources/upx  $wrtpackage/base-files/files/bin/

# remove upx cmd of Makefile
cp -f ./scripts/remove_upx.sh friendlywrt-rk3328/friendlywrt/
cd friendlywrt-rk3328/friendlywrt
/bin/bash ./remove_upx.sh
cd ../../
