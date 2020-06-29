# [K] (C)2020
# https://github.com/kongfl888/OpenWrt4R2S

mkdir -p ./r2srom/ipk/

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*adbyby*.ipk" | grep "adbyby" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*adbyby*.ipk ./r2srom/ipk/ >/dev/null 2>&1 || echo "pack adbyby ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*adguardhome*.ipk" | grep "adguardhome" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*adguardhome*.ipk ./r2srom/ipk/ >/dev/null 2>&1 || echo "pack adguardhome ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*iptvhelper*.ipk" | grep "iptvhelper" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*iptvhelper*.ipk ./r2srom/ipk/ >/dev/null 2>&1 || echo "pack iptvhelper ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*mwan3*.ipk" | grep "mwan3" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*mwan3*.ipk ./r2srom/ipk/ >/dev/null 2>&1 || echo "pack mwan3 ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*syncdial*.ipk" | grep "syncdial" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*syncdial*.ipk ./r2srom/ipk/ >/dev/null 2>&1 || echo "pack syncdial ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/targets/* -name "kmod-macvlan*.ipk" | grep "kmod-macvlan" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/targets/*/generic/packages/kmod-macvlan*.ipk ./r2srom/ipk/ >/dev/null 2>&1 || echo "pack kmod-macvlan ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*luci-app-r2sflasher*.ipk" | grep "r2sflasher" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*r2sflasher*.ipk ./r2srom/ipk/ >/dev/null 2>&1 || echo "pack r2sflasher ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*luci-app-autorewan*.ipk" | grep "autorewan" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*autorewan*.ipk ./r2srom/ipk/ >/dev/null 2>&1 || echo "pack autorewan ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "luci-app-timedreboot*.ipk" | grep "luci-app-timedreboot" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/luci-app-timedreboot*.ipk ./r2srom/ipk/ >/dev/null 2>&1 || echo "pack luci-app-timedreboot ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*smartdns*.ipk" | grep "smartdns" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*smartdns*.ipk ./r2srom/ipk/ >/dev/null 2>&1 || echo "pack smartdns ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*koolproxyR*.ipk" | grep "koolproxyR" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*koolproxyR*.ipk ./r2srom/ipk/ >/dev/null 2>&1 || echo "pack koolproxyR ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*sqm*.ipk" | grep "koolproxyR" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*sqm*.ipk ./r2srom/ipk/ >/dev/null 2>&1 || echo "pack koolproxyR ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "luci-theme-*.ipk" | grep "luci-theme" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/luci-theme-*.ipk ./r2srom/ipk/ >/dev/null 2>&1 || echo "pack luci-theme ipk fail" >> ipklost.txt
fi

if [ `find ./r2srom/ipk/* -name "*.ipk" | grep ".ipk" -c` -eq 0 ]; then
    echo "1" > ./r2srom/ipk/noipk
fi

if [ -e ".current_config.mk" ]; then
    cp -f .current_config.mk ./r2srom/
fi
