cd friendlywrt-rk3328
cd kernel/
git apply ../../add_fullconenat.diff
wget https://github.com/armbian/build/raw/master/patch/kernel/rockchip64-dev/RK3328-enable-1512mhz-opp.patch
git apply RK3328-enable-1512mhz-opp.patch
cd ../
git clone https://github.com/openwrt/openwrt && cd openwrt/
#git checkout 68d9cb82143b864d70e4fb3d7cbb7068f82216a1 #5.4.50
rm -f target/linux/generic/*/*leds-*.patch
rm -f target/linux/generic/*/*mips*.patch
rm -f target/linux/generic/*/*MIPS*.patch
rm -f target/linux/generic/*/*x86*.patch
rm -f target/linux/generic/*/*sfp-*.patch
rm -f target/linux/generic/*/*sfp_*.patch
rm -f target/linux/generic/*/*SFP-*.patch
rm -f target/linux/generic/*/*GPON-*.patch
rm -f target/linux/generic/*/*gpon-*.patch
rm -f target/linux/generic/*/*BCM84881*.patch
cp -a ./target/linux/generic/files/* ../kernel/
sed -i '/exit 1/d' ./scripts/patch-kernel.sh
./scripts/patch-kernel.sh ../kernel target/linux/generic/backport-5.4
./scripts/patch-kernel.sh ../kernel target/linux/generic/pending-5.4
./scripts/patch-kernel.sh ../kernel target/linux/generic/hack-5.4
cd ../
wget https://github.com/torvalds/linux/raw/master/scripts/kconfig/merge_config.sh && chmod +x merge_config.sh
grep -i '_NETFILTER_\|FLOW' ../.config.override > .config.override
./merge_config.sh -m .config.override kernel/arch/arm64/configs/nanopi-r2_linux_defconfig && mv .config kernel/arch/arm64/configs/nanopi-r2_linux_defconfig

sed -i -r 's/# (CONFIG_.*_ERRATUM_.*?) is.*/\1=y/g' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig

mkdir -p friendlywrt/staging_dir/host/bin/
if [ ! -e "friendlywrt/staging_dir/host/bin/upx" ];then
    ln -s /usr/bin/upx-ucl friendlywrt/staging_dir/host/bin/upx
fi
