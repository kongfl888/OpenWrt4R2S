# [K] (C)2020
# https://github.com/kongfl888/OpenWrt4R2S

mkdir -p ./ipks/

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*adbyby*.ipk" | grep "adbyby" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*adbyby*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack adbyby ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*adguardhome*.ipk" | grep "adguardhome" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*adguardhome*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack luci-app-adguardhome ipk fail" >> ipklost.txt
fi
if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "AdGuardHome*.ipk" | grep "AdGuardHome" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/AdGuardHome*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack AdGuardHome ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*iptvhelper*.ipk" | grep "iptvhelper" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*iptvhelper*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack iptvhelper ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*mwan3*.ipk" | grep "mwan3" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*mwan3*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack mwan3 ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*syncdial*.ipk" | grep "syncdial" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*syncdial*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack syncdial ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/targets/* -name "kmod-macvlan*.ipk" | grep "kmod-macvlan" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/targets/*/generic/packages/kmod-macvlan*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack kmod-macvlan ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*luci-app-r2sflasher*.ipk" | grep "r2sflasher" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*r2sflasher*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack r2sflasher ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*luci-app-autorewan*.ipk" | grep "autorewan" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*autorewan*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack autorewan ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "luci-app-timedreboot*.ipk" | grep "luci-app-timedreboot" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/luci-app-timedreboot*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack luci-app-timedreboot ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*smartdns*.ipk" | grep "smartdns" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*smartdns*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack smartdns ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*koolproxyR*.ipk" | grep "koolproxyR" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*koolproxyR*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack koolproxyR ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*sqm*.ipk" | grep "sqm" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*sqm*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack sqm ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "luci-theme-*.ipk" | grep "luci-theme" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/luci-theme-*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack luci-theme ipk fail" >> ipklost.txt
fi
# ssr-start
if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "shadowsocksr*.ipk" | grep "shadowsocksr" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/shadowsocksr*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack shadowsocksr ipk fail" >> ipklost.txt
fi
if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "srelay*.ipk" | grep "srelay" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/srelay*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack srelay ipk fail" >> ipklost.txt
fi
if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "microsocks*.ipk" | grep "microsocks" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/microsocks*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack microsocks ipk fail" >> ipklost.txt
fi
if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "proxychains-ng*.ipk" | grep "proxychains-ng" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/proxychains-ng*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack proxychains-ng ipk fail" >> ipklost.txt
fi
if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "tcpping*.ipk" | grep "tcpping" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/tcpping*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack tcpping ipk fail" >> ipklost.txt
fi
if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "simple-obfs*.ipk" | grep "simple-obfs" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/simple-obfs*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack simple-obfs ipk fail" >> ipklost.txt
fi
if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "redsocks2*.ipk" | grep "redsocks2" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/redsocks2*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack redsocks2 ipk fail" >> ipklost.txt
fi
if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "kcptun*.ipk" | grep "kcptun" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/kcptun*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack kcptun ipk fail" >> ipklost.txt
fi
if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*ssr*.ipk" | grep "ssr" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*ssr*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack ssr ipk fail" >> ipklost.txt
fi
if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "lua-maxminddb*.ipk" | grep "lua-maxminddb" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/lua-maxminddb*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack lua-maxminddb ipk fail" >> ipklost.txt
fi
# ssr-end
if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*accesscontrol*.ipk" | grep "accesscontrol" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*accesscontrol*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack accesscontrol ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*wifischedule*.ipk" | grep "wifischedule" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*wifischedule*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack wifischedule ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*ttyd*.ipk" | grep "ttyd" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*ttyd*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack ttyd ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*core*.ipk" | grep "core" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*core*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack autocore or coremark ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*passwall*.ipk" | grep "passwall" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*passwall*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack passwall ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*kcpufreq*.ipk" | grep "kcpufreq" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*kcpufreq*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack kcpufreq ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*wrtbwmon*.ipk" | grep "wrtbwmon" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*wrtbwmon*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack wrtbwmon ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*-sfe*.ipk" | grep "sfe" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*-sfe*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack sfe ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*shortcut-fe*.ipk" | grep "shortcut-fe" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*shortcut-fe*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack shortcut-fe ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*v2ray*.ipk" | grep "v2ray" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*v2ray*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack v2ray ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*dns2socks*.ipk" | grep "dns2socks" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*dns2socks*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack dns2socks ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*oaf*.ipk" | grep "oaf" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*oaf*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack openappfilter ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*appfilter*.ipk" | grep "appfilter" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*appfilter*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack appfilter ipk fail" >> ipklost.txt
fi

if [ `find friendlywrt-rk3328/friendlywrt/bin/packages/* -name "*msgkun*.ipk" | grep "msgkun" -c` -gt 0 ]; then
	mv -f friendlywrt-rk3328/friendlywrt/bin/packages/*/*/*msgkun*.ipk ./ipks/ >/dev/null 2>&1 || echo "pack msgkun ipk fail" >> ipklost.txt
fi

if [ `find ./ipks/* -name "*.ipk" | grep ".ipk" -c` -eq 0 ]; then
    echo "1" > ./ipks/noipk
fi

if [ -e ".current_config.mk" ]; then
    cp -f .current_config.mk ./r2srom/
fi
