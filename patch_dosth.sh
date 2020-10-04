#!/bin/bash
#
# [K] (c)2020

profile=0
#1 19071, 2 lean, 3 last-stable, 4 snapshot
if [ -f "friendlywrt/package/lean/default-settings/files/zzz-default-settings" ]; then
    [ `cat "friendlywrt/package/lean/default-settings/files/zzz-default-settings" | grep -c "DISTRIB_REVISION"` -gt 0 ] && profile=2
elif [ -f "friendlywrt/include/version.mk" ]; then
    opver=`cat friendlywrt/include/version.mk | grep -Eo "VERSION_NUMBER.*([0-9]|SNAPSHOT|snapshot)+" | grep -Eo "([0-9\.]+[0-9])|SNAPSHOT|snapshot"`
    case ${opver} in
    19.07.1)
        profile=1
        ;;
    19.07.2 | 19.07.3 | 19.07.4)
        profile=3
        ;;
    "SNAPSHOT" |"snapshot")
        profile=4
        ;;
    *)
        profile=0
        ;;
    esac
else
    profile=0
fi


if [ `grep -c "CONFIG_BRIDGE_NETFILTER=y" kernel/arch/arm64/configs/nanopi-r2_linux_defconfig` -eq 0 ]; then
    sed -i '/CONFIG_BRIDGE_NETFILTER/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig >/dev/null 2>&1
    echo "CONFIG_BRIDGE_NETFILTER=m" >> kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
fi
# open patch fullconenat
sed -i '/CONFIG_NF_CONNTRACK_CHAIN_EVENTS/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
echo "CONFIG_NF_CONNTRACK_CHAIN_EVENTS=y" >> kernel/arch/arm64/configs/nanopi-r2_linux_defconfig

zh_cntw=0

if [ -e "configs/config_rk3328" ]; then
    [ `grep -c "LUCI_LANG_zh-cn" configs/config_rk3328` -ne 0 ] && zh_cntw=1 || zh_cntw=0
    sed -i '/CONFIG_DISPLAY_SUPPOR/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_ar3k-firmware/d' configs/config_rk3328
    sed -i '/adblock/d' configs/config_rk3328
    sed -i '/samba/d' configs/config_rk3328
    sed -i '/ddns/d' configs/config_rk3328
    sed -i '/mwan3/d' configs/config_rk3328
    sed -i '/watchcat/d' configs/config_rk3328
    sed -i '/CONFIG_TARGET_ROOTFS_PARTSIZE/d' configs/config_rk3328
    sed -i '/CONFIG_VERSION_REPO/d' configs/config_rk3328
    sed -i '/CONFIG_LUCI_LANG_/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_luci-i18n-.*-bg=/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_luci-i18n-.*-ca=/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_luci-i18n-.*-cs=/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_luci-i18n-.*-de=/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_luci-i18n-.*-el=/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_luci-i18n-.*-es=/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_luci-i18n-.*-fr=/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_luci-i18n-.*-he=/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_luci-i18n-.*-hi=/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_luci-i18n-.*-hu=/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_luci-i18n-.*-it=/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_luci-i18n-.*-ja=/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_luci-i18n-.*-ko=/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_luci-i18n-.*-ms=/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_luci-i18n-.*-mr=/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_luci-i18n-.*-no=/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_luci-i18n-.*-pl=/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_luci-i18n-.*-pt=/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_luci-i18n-.*-br=/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_luci-i18n-.*-ro=/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_luci-i18n-.*-ru=/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_luci-i18n-.*-sk=/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_luci-i18n-.*-sv=/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_luci-i18n-.*-tr=/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_luci-i18n-.*-uk=/d' configs/config_rk3328
    sed -i '/CONFIG_PACKAGE_luci-i18n-.*-vi=/d' configs/config_rk3328
    sed -i '/CONFIG_KERNEL_BUILD_DOMAIN/d' configs/config_rk3328
    sed -i '/CONFIG_KERNEL_BUILD_USER/d' configs/config_rk3328
echo '
CONFIG_KERNEL_BUILD_DOMAIN="https://github.com/kongfl888"
CONFIG_KERNEL_BUILD_USER="kongfl888"
CONFIG_LUCI_LANG_en=y
CONFIG_TARGET_ROOTFS_PARTSIZE=960
' >> configs/config_rk3328

    if [ $zh_cntw -ne 0 ]; then
        echo -e "\nCONFIG_LUCI_LANG_zh-cn=y" >>configs/config_rk3328
    else
        echo -e "\nCONFIG_LUCI_LANG_zh_Hans=y" >>configs/config_rk3328
    fi
fi

sh ../scripts/distfeeds.sh "$profile" "device/friendlyelec/rk3328/common-files/etc/opkg/distfeeds.conf"

cd friendlywrt
git apply --check ../../patches/Patch-for-timezone-and-ip.patch && git apply ../../patches/Patch-for-timezone-and-ip.patch || echo ""
sed -i 's/192.168.2.1/192.168.31.3/g' package/base-files/files/root/setup.sh || echo ""
sed -i 's/addr_offset=2/addr_offset=31/g' package/base-files/files/bin/config_generate || echo ""
sed -i 's/ipad=${ipaddr:-"192.168.$((addr_offset++)).1"}/ipad=${ipaddr:-"192.168.$((addr_offset++)).3"}/g' package/base-files/files/bin/config_generate || echo ""
sed -i 's/ipaddr:-"192.168.1.1"/ipaddr:-"192.168.31.3"/g' package/base-files/files/bin/config_generate || echo ""
sed -i 's/ipaddr:-"192.168.2.1"/ipaddr:-"192.168.31.3"/g' package/base-files/files/bin/config_generate || echo ""
sed -i 's/-Os/-O3/g' include/target.mk
sed -i 's/-O2/-O3/g' ./rules.mk
cd ..
