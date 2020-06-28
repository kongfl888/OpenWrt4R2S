#!/bin/sh
# [K] (C)2020
# built
# mv ../../scripts/one_time_init.sh package/base-files/files/usr/bin && sed -i '/exit/i\/bin/sh /usr/bin/one_time_init.sh &' package/base-files/files/etc/rc.local
# https://github.com/kongfl888/nanopi-openwrt
# ** 1st: 1 normal, 2 lite; 2nd: 1 original, 2 lite2

lite=0
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
    *)
        profile=0
        ;;
    esac
    let lt=${1}/10
    case $lt in
    1)
        lite=0
        ;;
    2)
        lite=1
        ;;
    *)
        lite=0
        ;;
    esac
fi

sleep 15s

DATE=`date +[%Y-%m-%d]%H:%M:%S`
echo $DATE" One time init Script: Init starting." > /tmp/one_time_init.log

# del from rc.local
sed -i '/one_time_init.sh/d' /etc/rc.local >/dev/null 2>&1
sleep 3s
sed -i '/one_time_init.sh/d' /etc/rc.local >/dev/null 2>&1

# set arch
DATE=`date +[%Y-%m-%d]%H:%M:%S`
echo $DATE" One time init Script: set arch." >> /tmp/one_time_init.log
if [ "$profile" = "1" ]; then
sed -i "s#),boardinfo.system#),'ARMv8 / Cortex-A53,64-bit (Rockchip rk3328)'#g" /www/luci-static/resources/view/status/include/10_system.js
fi
sed -i '/<%:Architecture%>/d' /usr/lib/lua/luci/view/admin_status/index.htm >/dev/null 2>&1
sed -i '/<%:CPU Info%><\/td>/i\\t\t<tr><td width="33%"><%:Architecture%></td><td>ARMv8 / Cortex-A53,64-bit (Rockchip rk3328)</td></tr>' /usr/lib/lua/luci/view/admin_status/index.htm

#disable some boot items
DATE=`date +[%Y-%m-%d]%H:%M:%S`
echo $DATE" One time init Script: disable some boot items" >> /tmp/one_time_init.log
sleep 1s

if [ -e "/etc/init.d/iptvhelper" ]; then
    /etc/init.d/iptvhelper stop
    /etc/init.d/iptvhelper disable
fi

if [ -e "/etc/init.d/mwan3" ]; then
    /etc/init.d/mwan3helper stop
    /etc/init.d/mwan3 stop
    /etc/init.d/mwan3 disable
    /etc/init.d/mwan3helper disable
fi

# fix autorewan
if [ -e "/etc/init.d/autorewan" ]; then
    DATE=`date +[%Y-%m-%d]%H:%M:%S`
    echo $DATE" One time init Script: fix autorewan" >> /tmp/one_time_init.log
    /etc/init.d/autorewan enable
    chmod +x /etc/init.d/autorewan
    [ -e "/usr/bin/dorewan" ] && chmod +x /usr/bin/dorewan
    /etc/init.d/autorewan restart >/dev/null 2>&1
fi

sleep 2s

# remove ddns
if [ "$lite" = "1" ]; then
    #lite2
    DATE=`date +[%Y-%m-%d]%H:%M:%S`
    echo $DATE" One time init Script: remove ddns" >> /tmp/one_time_init.log
    opkg remove *ddns* --force-depends >/dev/null 2>&1
fi

# remove autoreboot
DATE=`date +[%Y-%m-%d]%H:%M:%S`
echo $DATE" One time init Script: remove ddns" >> /tmp/one_time_init.log
opkg remove *autoreboot* >/dev/null 2>&1

sleep 2

# set ipaddr
DATE=`date +[%Y-%m-%d]%H:%M:%S`
echo $DATE" One time init Script: set ipaddr" >> /tmp/one_time_init.log
uci set network.lan.ipaddr=192.168.31.3
uci commit network

# close ipv6
if [ "$profile" = "1" -o "$lite" = "1" ]; then
uci set network.wan.ipv6="0"
uci delete network.lan.ip6assign
uci commit network
fi

# set theme
if [ "$profile" = "1" ]; then
DATE=`date +[%Y-%m-%d]%H:%M:%S`
echo $DATE" One time init Script: set theme" >> /tmp/one_time_init.log
uci set luci.main.lang='zh_cn'
#uci set luci.main.mediaurlbase ='/luci-static/argon'
uci set luci.diag.dns='baidu.com'
uci set luci.diag.ping='baidu.com'
uci set luci.diag.route='baidu.com'
uci commit luci
fi

#uhttpd don't use https
uci set uhttpd.main.redirect_https="0"
uci set uhttpd.defaults.country="CN"
uci set uhttpd.defaults.location="Beijing"
uci commit uhttpd

# set ntp time
if [ "$profile" = "1" ]; then
DATE=`date +[%Y-%m-%d]%H:%M:%S`
echo $DATE" One time init Script: set ntp time" >> /tmp/one_time_init.log
sed -i 's/0.openwrt.pool.ntp.org/ntp1.aliyun.com/g' /etc/config/system
sed -i 's/1.openwrt.pool.ntp.org/ntp2.aliyun.com/g' /etc/config/system
sed -i 's/2.openwrt.pool.ntp.org/0.openwrt.pool.ntp.org/g' /etc/config/system
sed -i 's/3.openwrt.pool.ntp.org/1.openwrt.pool.ntp.org/g' /etc/config/system
uci set system.@system[0].timezone="CST-8"
uci set system.@system[0].zonename="Asia/Shanghai"
uci commit system
fi

sleep 3
# restart network
DATE=`date +[%Y-%m-%d]%H:%M:%S`
echo $DATE" One time init Script: network restarting." >> /tmp/one_time_init.log
/etc/init.d/network restart >/dev/null 2>&1

sleep 5
DATE=`date +[%Y-%m-%d]%H:%M:%S`
echo $DATE" One time init Script: -- Init finish --" >> /tmp/one_time_init.log
if [ -e "/usr/bin/one_time_init.sh" ]; then
    rm -f /usr/bin/one_time_init.sh
fi

exit 0
