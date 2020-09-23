#!/bin/sh
# [K] (C)2020
# built
# mv ../../scripts/one_time_init.sh package/base-files/files/usr/bin && sed -i '/exit/i\/bin/sh /usr/bin/one_time_init.sh &' package/base-files/files/etc/rc.local
# https://github.com/kongfl888/OpenWrt4R2S
# ** 1st: 1 normal, 2 lite; 2nd: 1 19.07.1, 2 lean, 3 19.07.3, 4 snapshot

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
if [ "$profile" != "2" ]; then
sed -i "s#),boardinfo.system#),'ARMv8 / Cortex-A53,64-bit (Rockchip rk3328)'#g" /www/luci-static/resources/view/status/include/10_system.js
else
sed -i '/<%:Architecture%>/d' /usr/lib/lua/luci/view/admin_status/index.htm >/dev/null 2>&1
sed -i '/<%:CPU Info%><\/td>/i\\t\t<tr><td width="33%"><%:Architecture%></td><td>ARMv8 / Cortex-A53,64-bit (Rockchip rk3328)</td></tr>' /usr/lib/lua/luci/view/admin_status/index.htm
fi

#disable some boot items
#DATE=`date +[%Y-%m-%d]%H:%M:%S`
#echo $DATE" One time init Script: disable some boot items" >> /tmp/one_time_init.log
sleep 1s
if [ -e "/etc/init.d/iptvhelper" ]; then
    DATE=`date +[%Y-%m-%d]%H:%M:%S`
    echo $DATE" One time init Script: disable iptvhelper boot" >> /tmp/one_time_init.log
    /etc/init.d/iptvhelper stop
    /etc/init.d/iptvhelper disable
fi

if [ -e "/etc/init.d/mwan3" ]; then
    DATE=`date +[%Y-%m-%d]%H:%M:%S`
    echo $DATE" One time init Script: disable mwan3 boot" >> /tmp/one_time_init.log
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

# set cpuinfo
if [ -e "/usr/bin/cpuinfo" ]; then
    DATE=`date +[%Y-%m-%d]%H:%M:%S`
    echo $DATE" One time init Script: set ethinfo" >> /tmp/one_time_init.log
    chmod +x /usr/bin/cpuinfo
fi

# set ethinfo
if [ -e "/usr/bin/ethinfo" ]; then
    DATE=`date +[%Y-%m-%d]%H:%M:%S`
    echo $DATE" One time init Script: set cpuinfo" >> /tmp/one_time_init.log
    chmod +x /usr/bin/ethinfo
fi

sleep 2s

# remove or disable ddns
if [ -e "/etc/init.d/ddns" ]; then
    if [ "$lite" = "1" ]; then
        #lite2
        DATE=`date +[%Y-%m-%d]%H:%M:%S`
        echo $DATE" One time init Script: remove ddns" >> /tmp/one_time_init.log
        opkg remove *ddns* --force-depends >/dev/null 2>&1
    else
        DATE=`date +[%Y-%m-%d]%H:%M:%S`
        echo $DATE" One time init Script: disable ddns" >> /tmp/one_time_init.log
        /etc/init.d/ddns stop
        /etc/init.d/ddns disable
    fi
fi

# remove autoreboot
if [ -e "/etc/init.d/autoreboot" ]; then
    DATE=`date +[%Y-%m-%d]%H:%M:%S`
    echo $DATE" One time init Script: remove autoreboot" >> /tmp/one_time_init.log
    opkg remove *autoreboot* >/dev/null 2>&1
fi
sleep 2

# set ipaddr
DATE=`date +[%Y-%m-%d]%H:%M:%S`
echo $DATE" One time init Script: set ipaddr" >> /tmp/one_time_init.log
uci set network.lan.ipaddr=192.168.31.3
uci commit network

# close ipv6
if [ "$profile" != "2" -o "$lite" = "1" ]; then
    uci set network.wan.ipv6="0"
    uci delete network.lan.ip6assign 2>/dev/null
    uci commit network
fi

# set address pool
if [ -e "/etc/config/dhcp" ]; then
    DATE=`date +[%Y-%m-%d]%H:%M:%S`
    echo $DATE" One time init Script: set address pool" >> /tmp/one_time_init.log
    uci set dhcp.lan.start="90"
    uci set dhcp.lan.limit="250"
    uci commit dhcp
fi

# init theme
argon="argon1"
Argon="Argon1"
if [ "$profile" == "2" ]; then
    argon="argon"
    Argon="Argon"
else
    argon="argon1"
    Argon="Argon1"
fi
if [ -e "/etc/uci-defaults/30_luci-theme-$argon" ];then
    DATE=`date +[%Y-%m-%d]%H:%M:%S`
    echo $DATE" One time init Script: init luci-theme-$argon" >> /tmp/one_time_init.log
    chmod +x /etc/uci-defaults/30_luci-theme-$argon
    /etc/uci-defaults/30_luci-theme-$argon && rm -f /etc/uci-defaults/30_luci-theme-$argon || \
    echo $DATE" One time init Script: init luci-theme-$argon failed." >> /tmp/one_time_init.log
fi

# disable ttyd
if [ -e "/etc/config/ttyd" ]; then
    uci set ttyd.@ttyd[0].enable="0"
    uci commit ttyd
fi

# init theme argon-gray
if [ -d "/www/luci-static/argon-gray/" ]; then
    DATE=`date +[%Y-%m-%d]%H:%M:%S`
    echo $DATE" One time init Script: init theme argon-gray" >> /tmp/one_time_init.log
    uci set luci.themes.ArgonGray="/luci-static/argon-gray"
    uci commit luci
fi

# set theme
if [ "$profile" != "2" ]; then
    DATE=`date +[%Y-%m-%d]%H:%M:%S`
    echo $DATE" One time init Script: set theme $argon" >> /tmp/one_time_init.log
    uci set luci.main.lang='zh_cn'
    [ -d "/www/luci-static/$argon/" ] && uci set luci.themes.$Argon="/luci-static/$argon"
    [ -d "/www/luci-static/$argon/" ] && uci set luci.main.mediaurlbase="/luci-static/$argon"
    uci set luci.diag.dns='baidu.com'
    uci set luci.diag.ping='baidu.com'
    uci set luci.diag.route='baidu.com'
    uci commit luci
fi

#uhttpd set p1
if [ "$profile" != "3" ]; then
DATE=`date +[%Y-%m-%d]%H:%M:%S`
echo $DATE" One time init Script: uhttpd don't use https" >> /tmp/one_time_init.log
uci set uhttpd.main.redirect_https="0"
uci commit uhttpd
fi
#uhttpd set p2
DATE=`date +[%Y-%m-%d]%H:%M:%S`
echo $DATE" One time init Script: uhttpd set country" >> /tmp/one_time_init.log
uci set uhttpd.defaults.country="CN"
uci set uhttpd.defaults.location="Beijing"
uci commit uhttpd

# set hostname
DATE=`date +[%Y-%m-%d]%H:%M:%S`
echo $DATE" One time init Script: set hostname" >> /tmp/one_time_init.log
if [ "$profile" == "2" ]; then
    uci set system.@system[0].hostname="LEDE"
    uci commit system
    echo "LEDE" > /proc/sys/kernel/hostname
else
    uci set system.@system[0].hostname="OpenWrt"
    uci commit system
    echo "OpenWrt" > /proc/sys/kernel/hostname
fi

# set ntp time
if [ "$profile" != "2" ]; then
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

# set anon_mount
if [ -e "/etc/config/fstab" ]; then
    DATE=`date +[%Y-%m-%d]%H:%M:%S`
    echo $DATE" One time init Script: set anon_mount" >> /tmp/one_time_init.log
    uci set fstab.@global[0].anon_mount=1
    uci commit fstab
fi

# set 53 dns firewall
if [ -e "/etc/firewall.user" ]; then
    DATE=`date +[%Y-%m-%d]%H:%M:%S`
    echo $DATE" One time init Script: set 53 dns firewall" >> /tmp/one_time_init.log
    sed -i '/REDIRECT --to-ports 53/d' /etc/firewall.user
    echo "iptables -t nat -A PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 53" >> /etc/firewall.user
    echo "iptables -t nat -A PREROUTING -p tcp --dport 53 -j REDIRECT --to-ports 53" >> /etc/firewall.user
fi

# set samba
if [ -e "/etc/init.d/samba" ];then
    DATE=`date +[%Y-%m-%d]%H:%M:%S`
    echo $DATE" One time init Script: set samba" >> /tmp/one_time_init.log
    uci set samba.@samba[0].name='OPENWRT'
    uci set samba.@samba[0].workgroup='WORKGROUP'
    uci set samba.@samba[0].description='Samba on OpenWrt'
    uci set samba.@samba[0].homes='1'
    uci commit samba
fi

# set samba4
if [ -e "/etc/init.d/samba4" ];then
    DATE=`date +[%Y-%m-%d]%H:%M:%S`
    echo $DATE" One time init Script: set samba4" >> /tmp/one_time_init.log
    uci set samba4.@samba[0].name='OPENWRT'
    uci set samba4.@samba[0].workgroup='WORKGROUP'
    uci set samba4.@samba[0].description='Samba on OpenWrt'
    uci set samba4.@samba[0].macos='1'
    uci set samba4.@samba[0].interface='lan'
    uci set samba4.@samba[0].charset='UTF-8'
    uci set samba4.@samba[0].allow_legacy_protocols='1'
    uci add samba4 sambashare
    uci set samba4.@sambashare[-1].name="sdcard"
    uci set samba4.@sambashare[-1].browseable="yes"
    uci set samba4.@sambashare[-1].path="/mnt/mmcblk0p2/"
    uci set samba4.@sambashare[-1].read_only="no"
    uci set samba4.@sambashare[-1].guest_ok="yes"
    uci set samba4.@sambashare[-1].create_mask="0666"
    uci set samba4.@sambashare[-1].dir_mask="0777"
    uci set samba4.@sambashare[-1].force_root="1"
    uci commit samba4
fi

# set rps for r2s
DATE=`date +[%Y-%m-%d]%H:%M:%S`
echo $DATE" One time init Script: set rps for r2s" >> /tmp/one_time_init.log
sysctl -w net.core.rps_sock_flow_entries=32768
for fileRps in $(ls /sys/class/net/eth*/queues/rx-*/rps_cpus)
do
    echo ff > $fileRps
done

for fileRfc in $(ls /sys/class/net/eth*/queues/rx-*/rps_flow_cnt)
do
    echo 32768 > $fileRfc
done

if [ -e "/etc/init.d/koptimalize" ]; then
    chmod +x /etc/init.d/koptimalize
    /etc/init.d/koptimalize enable
    /etc/init.d/koptimalize start
fi

# open eth features
ethx=$(ip address | grep ^[0-9] | awk -F: '{print $2}' | sed "s/ //g" | grep '^[e]' | grep -v "@" | grep -v "\.")
ethc=$(echo "$ethx" | wc -l)
for i in $(seq 1 $ethc)
do
    x=$(echo "$ethx" | sed -n ${i}p)
    ethtool -K $x rx-checksum on >/dev/null 2>&1
    ethtool -K $x tx-checksum-ip-generic on >/dev/null 2>&1 || (
    ethtool -K $x tx-checksum-ipv4 on >/dev/null 2>&1
    ethtool -K $x tx-checksum-ipv6 on >/dev/null 2>&1)
    ethtool -K $x tx-scatter-gather on >/dev/null 2>&1
    ethtool -K $x gso on >/dev/null 2>&1
    ethtool -K $x tso on >/dev/null 2>&1
    ethtool -K $x ufo on >/dev/null 2>&1
done

# check bbr
bbrcount=`sysctl net.ipv4.tcp_congestion_control | grep "bbr" -c`
if [ $bbrcount -eq 0 ]; then
DATE=`date +[%Y-%m-%d]%H:%M:%S`
echo $DATE" One time init Script: enable bbr" >> /tmp/one_time_init.log
echo 'net.core.default_qdisc=fq' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_congestion_control=bbr' >> /etc/sysctl.conf
sysctl -p
fi

# set opkg feeds
if [ -e "/etc/opkg/distfeeds.conf" ];then
DATE=`date +[%Y-%m-%d]%H:%M:%S`
echo $DATE" One time init Script: set opkg feeds" >> /tmp/one_time_init.log
sed -i '/openwrt_packages/d' /etc/opkg/distfeeds.conf
case $profile in
1)
    sed -i 's/releases\/.*\/package/releases\/19.07.1\/package/g' /etc/opkg/distfeeds.conf
    sed -i 's/snapshots\/package/releases\/19.07.1\/package/g' /etc/opkg/distfeeds.conf
    echo "src/gz openwrt_packages https://downloads.openwrt.org/releases/19.07.1/packages/aarch64_cortex-a53/packages" >> /etc/opkg/distfeeds.conf
    ;;
2)
    sed -i 's/releases\/.*\/package/releases\/18.06.8\/package/g' /etc/opkg/distfeeds.conf
    sed -i 's/snapshots\/package/releases\/18.06.8\/package/g' /etc/opkg/distfeeds.conf
    echo "src/gz openwrt_packages https://downloads.openwrt.org/releases/18.06.8/packages/aarch64_cortex-a53/packages" >> /etc/opkg/distfeeds.conf
    ;;
3)
    sed -i 's/releases\/.*\/package/releases\/19.07.3\/package/g' /etc/opkg/distfeeds.conf
    sed -i 's/snapshots\/package/releases\/19.07.3\/package/g' /etc/opkg/distfeeds.conf
    echo "src/gz openwrt_packages https://downloads.openwrt.org/releases/19.07.3/packages/aarch64_cortex-a53/packages" >> /etc/opkg/distfeeds.conf
    ;;
4)
    sed -i 's/releases\/.*\/package/snapshots\/package/g' /etc/opkg/distfeeds.conf
    echo "src/gz openwrt_packages https://downloads.openwrt.org/snapshots/packages/aarch64_cortex-a53/packages" >> /etc/opkg/distfeeds.conf
    ;;
*)
    ;;
esac
sed -i 's/http:/https:/g' /etc/opkg/distfeeds.conf
#sed - 's/downloads.openwrt.org/openwrt.proxy.ustclug.org/g' /etc/opkg/distfeeds.conf
fi

# set coremark
if [ -e "/etc/coremark.sh" ];then
    DATE=`date +[%Y-%m-%d]%H:%M:%S`
    echo $DATE" One time init Script: set coremark" >> /tmp/one_time_init.log
    chmod +x /etc/coremark.sh
    if [ -e "/bin/coremark" ];then
        chmod +x /bin/coremark
        /etc/coremark.sh &
    fi
fi

# clear smp_affinity
DATE=`date +[%Y-%m-%d]%H:%M:%S`
echo $DATE" One time init Script: clear smp_affinity" >> /tmp/one_time_init.log
[ -e "/etc/init.d/koptimalize" -a -e "/etc/init.d/fa-rk3328-misc" ] && sed -i '/proc\/irq\/28\/smp_affinity/d' /etc/init.d/fa-rk3328-misc

[ -e "/etc/init.d/fa-rk3328-misc" ] && sed -i '/start()/a\echo "fa-rk3328-misc"' /etc/init.d/fa-rk3328-misc

# set cpufreq
testsgovernor=`cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors | grep -c "schedutil"`
if [ $testsgovernor -gt 0 ]; then
    DATE=`date +[%Y-%m-%d]%H:%M:%S`
    echo $DATE" One time init Script: set cpufreq to schedutil" >> /tmp/one_time_init.log
    [ -e "/etc/init.d/fa-rk3328-misc" ] && sed -i '/scaling_governor/d' /etc/init.d/fa-rk3328-misc
    echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
fi
available1296=`cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies | grep -c "1296"`
if [ $available1296 -gt 0 ]; then
    DATE=`date +[%Y-%m-%d]%H:%M:%S`
    echo $DATE" One time init Script: set max_freq to 1296000" >> /tmp/one_time_init.log
    echo -n 1296000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
fi
available600=`cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies | grep -c "600000"`
if [ $available600 -gt 0 ]; then
    DATE=`date +[%Y-%m-%d]%H:%M:%S`
    echo $DATE" One time init Script: set min_freq to 600000" >> /tmp/one_time_init.log
    echo -n 600000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
fi

# set kcupfreq
if [ -e "/etc/config/kcpufreq" ]; then
    if [ -d "/sys/devices/system/cpu/cpufreq/policy0" ]; then
        cmin=`cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq`
        cmax=`cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq`
        [ ! -z "$cmin" ] && uci set kcpufreq.@settings[-1].minifreq="$cmin"
        [ ! -z "$cmax" ] && uci set kcpufreq.@settings[-1].maxfreq="$cmax"

        DATE=`date +[%Y-%m-%d]%H:%M:%S`
        echo $DATE" One time init Script: set kcupfreq" >> /tmp/one_time_init.log
        uci commit kcpufreq
    fi
fi
[ -e "/etc/init.d/kcpufreq" ] && chmod +x /etc/init.d/kcpufreq

# set wrtbwmon
if [ -e "/etc/config/wrtbwmon" ]; then
    if [ "$profile" == "1" ]; then
        DATE=`date +[%Y-%m-%d]%H:%M:%S`
        echo $DATE" One time init Script: set wrtbwmon" >> /tmp/one_time_init.log
        uci set wrtbwmon.general.enabled='0'
        uci commit wrtbwmon
        /etc/init.d/wrtbwmon stop 2>/dev/null
    fi
fi

# stop check-network before reboot
#if [ -e "/etc/init.d/check-network" ];then
#    DATE=`date +[%Y-%m-%d]%H:%M:%S`
#    echo $DATE" One time init Script: stop check-network" >> /tmp/one_time_init.log
#     /etc/init.d/check-network stop 2>/dev/null
#fi

# fix ssh rsa key
if [ -e "/etc/dropbear/dropbear_rsa_host_key" ]; then
    DATE=`date +[%Y-%m-%d]%H:%M:%S`
    echo $DATE" One time init Script: fix ssh rsa key file permission" >> /tmp/one_time_init.log
    chown root:root /etc/dropbear/dropbear_rsa_host_key
    chmod 640 /etc/dropbear/dropbear_rsa_host_key
fi

# creat /usr/share/mywdog/
DATE=`date +[%Y-%m-%d]%H:%M:%S`
echo $DATE" One time init Script: creat /usr/share/mywdog/" >> /tmp/one_time_init.log
mkdir -p /usr/share/mywdog/
chmod 755 /usr/share/mywdog/

# clean luci cache
DATE=`date +[%Y-%m-%d]%H:%M:%S`
echo $DATE" One time init Script: clean luci cache" >> /tmp/one_time_init.log
rm -rf /tmp/luci-modulecache/* >/dev/null 2>&1 || echo ""
rm -f /tmp/luci-indexcache* >/dev/null 2>&1 || echo ""

sleep 3
# restart rpcd
DATE=`date +[%Y-%m-%d]%H:%M:%S`
echo $DATE" One time init Script: rpcd restarting." >> /tmp/one_time_init.log
/etc/init.d/rpcd restart >/dev/null 2>&1

sleep 2
# restart uhttpd
DATE=`date +[%Y-%m-%d]%H:%M:%S`
echo $DATE" One time init Script: uhttpd restarting." >> /tmp/one_time_init.log
rm -rf /tmp/luci-modulecache/ >/dev/null 2>&1 || echo ""
rm -f /tmp/luci-indexcache* >/dev/null 2>&1 || echo ""
/etc/init.d/uhttpd restart >/dev/null 2>&1

sleep 2
# restart dnsmasq
DATE=`date +[%Y-%m-%d]%H:%M:%S`
echo $DATE" One time init Script: dnsmasq restarting." >> /tmp/one_time_init.log
/etc/init.d/dnsmasq restart >/dev/null 2>&1

sleep 5
# reload firewall
DATE=`date +[%Y-%m-%d]%H:%M:%S`
echo $DATE" One time init Script: firewall reloading." >> /tmp/one_time_init.log
/etc/init.d/firewall reload >/dev/null 2>&1 &

sleep 10
# restart network
DATE=`date +[%Y-%m-%d]%H:%M:%S`
echo $DATE" One time init Script: network restarting." >> /tmp/one_time_init.log
/etc/init.d/network restart >/dev/null 2>&1

sleep 10
# fix upx
if [ -e "/bin/upx" ]; then
    DATE=`date +[%Y-%m-%d]%H:%M:%S`
    echo $DATE" One time init Script: fix upx permission" >> /tmp/one_time_init.log
    chmod +x /bin/upx
fi

sleep 3
DATE=`date +[%Y-%m-%d]%H:%M:%S`
echo $DATE" One time init Script: -- Init finish --" >> /tmp/one_time_init.log
if [ -e "/usr/bin/one_time_init.sh" ]; then
    rm -f /usr/bin/one_time_init.sh
fi

exit 0
