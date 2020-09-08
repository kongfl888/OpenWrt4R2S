
if [ `grep -c "CONFIG_BRIDGE_NETFILTER=y" kernel/arch/arm64/configs/nanopi-r2_linux_defconfig` -eq 0 ]; then
    sed -i '/CONFIG_BRIDGE_NETFILTER/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig >/dev/null 2>&1
    echo "CONFIG_BRIDGE_NETFILTER=m" >> kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
fi
# open patch fullconenat
sed -i '/CONFIG_NF_CONNTRACK_CHAIN_EVENTS/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
echo "CONFIG_NF_CONNTRACK_CHAIN_EVENTS=y" >> kernel/arch/arm64/configs/nanopi-r2_linux_defconfig

# remove drm drivers and display config
sed -i '/CONFIG_DRM=y/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_DRM_/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/_HDMI/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_ROCKCHIP_ANALOGIX_DP/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_ROCKCHIP_CDN_DP/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_ROCKCHIP_DW_HDMI/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_ROCKCHIP_DW_MIPI_DSI/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_ROCKCHIP_INNO_HDMI/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_ROCKCHIP_LVDS/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
echo "# CONFIG_DRM is not set" >> kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
# remove webcam / TV (analog/digital) drivers
sed -i '/CONFIG_USB_GSPCA/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_USB_VIDEO_CLASS/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_USB_M5602/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_USB_STV06XX/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_USB_GL860/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_USB_STKWEBCAM/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/USB_PWC/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/VIDEO_CPIA2/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/USB_ZR364XX/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/USB_STKWEBCAM/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/USB_S2255/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/VIDEO_USBTV/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/VIDEO_EM28XX/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_MEDIA_CAMERA/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/VIDEO_V4L2/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_V4L_/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_VIDEOBUF2/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
# remove bluetooth drivers
sed -i '/CONFIG_BT=/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_BT_/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_INPUT_CM109/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
echo "# CONFIG_BT is not set" >> kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
# remove nfc
sed -i '/CONFIG_NFC=/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_NFC_/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
echo "# CONFIG_NFC is not set" >> kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
# remove pci pci-e
sed -i '/CONFIG_PCI=/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_PCI_/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_PCIEPORTBUS/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_PCIEASPM/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_PCIE_/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_ATH9K_PCI/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_BRCMFMAC_PCIE/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_BLK_DEV_PCIESSD/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/_PCI=/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/_PCIE=/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
echo "# CONFIG_PCI is not set" >> kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
echo "# CONFIG_PCIEPORTBUS is not set" >> kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
echo "# CONFIG_PCIEAER is not set" >> kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
echo "# CONFIG_SSB_PCIHOST_POSSIBLE is not set" >> kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
# remove input keyboard mouse joystick touchscreen remote
sed -i '/CONFIG_INPUT_JOYDEV/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_INPUT_JOYSTICK/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_INPUT_TOUCHSCREEN/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_INPUT_MATRIXKMAP/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_INPUT_MOUSEDEV/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_INPUT_YEALINK/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_INPUT_ATI_REMOTE2/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_INPUT_KEYSPAN_REMOTE/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_MOUSE_/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_KEYBOARD/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_JOYSTICK/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_TOUCHSCREEN/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_GAMEPORT/d' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig

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

cd friendlywrt
git apply --check ../../patches/Patch-for-timezone-and-ip.patch && git apply ../../patches/Patch-for-timezone-and-ip.patch || echo ""
sed -i 's/-Os/-O3/g' include/target.mk
sed -i 's/-O2/-O3/g' ./rules.mk
cd ..
