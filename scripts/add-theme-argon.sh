#!/bin/bash
#
# [K] (c)2020
# http://github.com/kongfl888

rm -rf friendlywrt-rk3328/friendlywrt/*/*/luci-theme-argon || echo ""

if [ "${1}" == "1" ]; then
    git clone -b master --single-branch https://github.com/kongfl888/luci-theme-argon1.git
else
    git clone -b luci-20.029 --single-branch https://github.com/kongfl888/luci-theme-argon1.git
fi

mkdir -p friendlywrt-rk3328/friendlywrt/package/base-files/files/www
mkdir -p friendlywrt-rk3328/friendlywrt/package/base-files/files/usr/lib/lua/luci
mkdir -p friendlywrt-rk3328/friendlywrt/package/base-files/files/etc/uci-defaults

/bin/cp -rf luci-theme-argon1/htdocs/* friendlywrt-rk3328/friendlywrt/package/base-files/files/www/
/bin/cp -rf luci-theme-argon1/luasrc/* friendlywrt-rk3328/friendlywrt/package/base-files/files/usr/lib/lua/luci/
/bin/cp -rf luci-theme-argon1/root/* friendlywrt-rk3328/friendlywrt/package/base-files/files/

# add gray fork
if [ "${1}" == "1" ]; then
    git clone -b master --single-branch https://github.com/kongfl888/luci-theme-argon-gray.git
else
    git clone -b luci-20.029 --single-branch https://github.com/kongfl888/luci-theme-argon-gray.git
fi

/bin/cp -rf luci-theme-argon-gray/htdocs/* friendlywrt-rk3328/friendlywrt/package/base-files/files/www/
/bin/cp -rf luci-theme-argon-gray/luasrc/* friendlywrt-rk3328/friendlywrt/package/base-files/files/usr/lib/lua/luci/
/bin/cp -rf luci-theme-argon-gray/root/* friendlywrt-rk3328/friendlywrt/package/base-files/files/
