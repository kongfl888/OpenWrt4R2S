cd friendlywrt-rk3328
git clone https://github.com/openwrt/openwrt && cd openwrt/
rm -f target/linux/generic/*/*led*.patch
rm -f target/linux/generic/*/*mips*.patch
rm -f target/linux/generic/*/*MIPS*.patch
rm -f target/linux/generic/*/*x86*.patch
cp -a ./target/linux/generic/files/* ../kernel/
./scripts/patch-kernel.sh ../kernel target/linux/generic/backport-5.4
./scripts/patch-kernel.sh ../kernel target/linux/generic/pending-5.4
./scripts/patch-kernel.sh ../kernel target/linux/generic/hack-5.4
cd ../
