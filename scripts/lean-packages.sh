#!/bin/sh
# [K] (C)2020
# * 1 fullin, 2 lite

fullin=0

if [ "${1}" == "1" ]; then
    fullin=1
fi

# kernel open sfe
echo "CONFIG_SHORTCUT_FE=y" >> friendlywrt-rk3328/kernel/arch/arm64/configs/nanopi-r2_linux_defconfig


wrtpackage="friendlywrt-rk3328/friendlywrt/package"
leanpack="friendlywrt-rk3328/friendlywrt/package/lean"

# add adguardhome
git clone -b master --single-branch https://github.com/kongfl888/luci-app-adguardhome.git
mv luci-app-adguardhome $wrtpackage
mkdir -p $wrtpackage/adguardhome
wget -P $wrtpackage/adguardhome https://raw.githubusercontent.com/Lienol/openwrt/dev-19.07/package/diy/adguardhome/Makefile
rm -rf $leanpack/adguardhome || echo ""
rm -rf $leanpack/luci-app-adguardhome || echo ""

# add luci-app-koolproxyR
git clone -b master --single-branch https://github.com/project-openwrt/luci-app-koolproxyR
cd luci-app-koolproxyR
git apply ../patches/make-koolproxyR-default-to-arm.patch
cd ..
mv luci-app-koolproxyR $wrtpackage

# add Luci-app-autorewan
git clone -b master --single-branch https://github.com/kongfl888/luci-app-autorewan.git
mv luci-app-autorewan $wrtpackage

# add Luci-app-kcpufreq
git clone -b master --single-branch https://github.com/kongfl888/luci-app-kcpufreq.git
mv luci-app-kcpufreq $wrtpackage

# add Luci-app-timedreboot
git clone -b master --single-branch https://github.com/kongfl888/luci-app-timedreboot.git
mv luci-app-timedreboot $wrtpackage

# add Luci-i18n-sqm-zh-cn
git clone -b master --single-branch https://github.com/kongfl888/luci-i18n-sqm-zh-cn.git
mv luci-i18n-sqm-zh-cn $wrtpackage

# add check-network
git clone -b master --single-branch https://github.com/kongfl888/check-network.git
mv check-network $wrtpackage

#koptimalize
git clone -b master https://github.com/kongfl888/koptimalize.git $wrtpackage/koptimalize

# add smartdns
git clone -b master --single-branch https://github.com/pymumu/openwrt-smartdns.git
git clone -b lede --single-branch https://github.com/pymumu/luci-app-smartdns.git
mv luci-app-smartdns $wrtpackage
mkdir -p $wrtpackage/net/smartdns
mv openwrt-smartdns/* $wrtpackage/net/smartdns
sed -i 's/\"services\"/\"network\"/g' $wrtpackage/luci-app-smartdns/luasrc/controller/smartdns.lua
sed -i 's/admin\/services\/smartdns/admin\/network\/smartdns/g' $wrtpackage/luci-app-smartdns/luasrc/model/cbi/smartdns/smartdns.lua
sed -i 's/admin\/services\/smartdns/admin\/network\/smartdns/g' $wrtpackage/luci-app-smartdns/luasrc/model/cbi/smartdns/upstream.lua
sed -i 's/\"services\"/\"network\"/g' $wrtpackage/luci-app-smartdns/luasrc/view/smartdns/smartdns_status.htm
rm -rf $leanpack/smartdns || echo ""
rm -rf $leanpack/luci-app-smartdns || echo ""

# add Luci-app-r2sflasher
git clone -b master --single-branch https://github.com/kongfl888/luci-app-r2sflasher.git
mv luci-app-r2sflasher $wrtpackage

if [ "$fullin" == "1" ]; then
# add IPTV Helper
git clone -b master --single-branch https://github.com/riverscn/openwrt-iptvhelper.git
mv openwrt-iptvhelper/iptvhelper $wrtpackage
mv openwrt-iptvhelper/luci-app-iptvhelper $wrtpackage
sed -i 's/+luci-compat //' $wrtpackage/luci-app-iptvhelper/Makefile
sed -i 's/+luci-compat//g' $wrtpackage/luci-app-iptvhelper/Makefile

# add OpenClash
git clone -b master https://github.com/vernesong/OpenClash.git
cd OpenClash/luci-app-openclash/files
sed -i 's/\"services\"/\"vpn\"/g' ./usr/lib/lua/luci/controller/openclash.lua
grep -rnl '\"services\",' ./usr/lib/lua/luci/model/cbi/openclash |xargs sed -i 's/\"services\",/\"vpn\",/g'  || echo ""
grep -rnl 'admin\/services\/' ./usr/lib/lua/luci/model/cbi/openclash |xargs sed -i 's/admin\/services\//admin\/vpn\//g'  || echo ""
grep -rnl '\"services\",' ./usr/lib/lua/luci/view/openclash |xargs sed -i 's/\"services\",/\"vpn\",/g'  || echo ""
grep -rnl 'admin\/services\/' ./usr/lib/lua/luci/view/openclash |xargs sed -i 's/admin\/services\//admin\/vpn\//g' || echo ""
cd ../../../
cp -rf OpenClash/luci-app-openclash $wrtpackage
cd friendlywrt-rk3328/friendlywrt/package/base-files/files
mkdir -p etc/openclash/core
cd etc/openclash/core
curl -L https://github.com/vernesong/OpenClash/releases/download/Clash/clash-linux-armv8.tar.gz | tar zxf -
chmod +x clash
cd ../../../../../../../../
# fullin - end
fi

# patch adbyby
wget -q https://raw.githubusercontent.com/kongfl888/ad-rules/master/scripts/patch-adbyby.sh
sh ./patch-adbyby.sh $leanpack/luci-app-adbyby-plus/root/usr/share/adbyby
wget -q https://raw.githubusercontent.com/kongfl888/ad-rules/master/video.txt
mv -f video.txt $leanpack/adbyby/files/data/ || echo ""
wget -q https://raw.githubusercontent.com/kongfl888/ad-rules/master/lazy.txt
mv -f lazy.txt $leanpack/adbyby/files/data/ || echo ""

# patch luci-app-flowoffload
sed -i 's/@LINUX_5_4//' $leanpack/luci-app-flowoffload/Makefile

# get wrtbwmon
rm -rf $leanpack/wrtbwmon
rm -rf $leanpack/luci-app-wrtbwmon
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/wrtbwmon/ >/dev/null 2>&1 || echo ""
rm -rf friendlywrt-rk3328/friendlywrt/feeds/*/*/luci-app-wrtbwmon/ >/dev/null 2>&1 || echo ""
git clone -b master https://github.com/brvphoenix/wrtbwmon.git
cp -rf wrtbwmon/wrtbwmon $leanpack
git clone -b master-18.06 https://github.com/kongfl888/luci-app-wrtbwmon.git
cp -rf luci-app-wrtbwmon/luci-app-wrtbwmon $leanpack
