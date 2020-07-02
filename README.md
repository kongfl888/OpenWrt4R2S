# Nanopi r2s+原生openwrt 自用固件的说明


### 固件说明

适用于 NanoPi R2S 的OpenWrt固件 ![smile](./assets/smile.png)

Original版的意思就是使用原生的OpenWrt。发行版本是stable 19.07.1和19.07.3，以后可能会有snapshots，但如果只是需要稳定使用的那推荐你用stable的。

*一般用户原生LITE版推荐。*

所有的版本都带了NAS四件套: 网络共享(samba)、下载工具和硬盘休眠，以及家庭网络必备的minidlna。再挂个QOS留用。 去广告都有，含adbyby、adguardhome和koolproxyR。

至于其他的包括不可说应用，只有不带lite版的多带了些（下边预览图）

而Lean版就是使用Lean大的opnwrt/lede做的固件。

### USB WIFI

usb-wifi驱动都有，网上常见的芯片，👇

![支持列表](./assets/R2swrt-usbwifi-08.jpg)

建议不要对它抱有太大的期望。👆

就算是5G的无线网卡但只有65M的速度也不要太惊讶。

### 发布地址

[下载传送门](https://github.com/kongfl888/OpenWrt4R2S/releases)

[网盘分流](https://github.com/kongfl888/OpenWrt4R2S/blob/r2s/README.txt)

因为编译的时候使用的是优化性能，所以文件有些大(压缩后大概相差个10M那样)。在文件大小和系统性能上的取舍，我选择了后者。

*（注意：IMG才是最终的固件格式）*

### 一些软件包

含MWAN3负载均衡、IPTV助手、adgurdhome、adbuby-plus、syncdial多拨、[r2s刷机助手](https://github.com/kongfl888/luci-app-r2sflasher/releases)、[定时重拨助手](https://github.com/kongfl888/luci-app-autorewan/releases)。

可直接上传到路由器安装：[IPK分流](https://kongfl888.lanzous.com/b04sj203c) （密码:abw4）（仅仅适用于minimal系列，其他未测，但基本能装上就能用）

[其他R2S可用的软件包](https://github.com/kongfl888/r2s-openwrt-packages)

### 刷机

你可以有三种方法

> 一、打开WEB页面

使用 [R2S刷机](https://github.com/kongfl888/luci-app-r2sflasher/releases)

> 二、打开SSH

``cd /tmp && wget https://raw.githubusercontent.com/kongfl888/OpenWrt4R2S/r2s/scripts/flash_rom.sh
flash_rom /tmp/rom.img.gz /dev/mmcblk0 gz``

> 三、PC端刷卡

1、Ubuntu下（其中/dev/sdX为TF卡的真实路径）

``sudo dd if=out/FriendlyWrt_20xxxx_NanoPi-R1_armhf_sd.img bs=1M of=/dev/sdX``

2、Windows系统

下载 [balenaEtcher](http://www.ksite.xyz/contents/balena-etcher.html)，插卡刷机

刷机后初始化时间可能比较长，请耐心等待，期间就算是出现几次网络断开那也是正常的。

### 登录

路由器登陆页面： http://openwrt/ 或 http://friendlywrt/，http://IP地址(自己找)。

默认用户名是``root``, 密码是 ``空密码`` 或 ``password`` 。

### 网络重启姿势

定时重拨--点击 ``马上执行`` 按钮--等待15-20s

### 三外设说明

+ tf卡直接影响系统启动速度。建议使用C10+卡，卡容量大小至少4GB，推荐8G以上。

+ 电流不稳或波动大直接影响板子的正常运行

+ USB可能会导致IO冲突，因为有一个千兆网口就是USB3转过来的

### 菜单预览

**Original**  ----- **LITE**

![original.gif](./assets/1907-n.gif) .  -  . ![Lite.gif](./assets/lite2.gif)

### 致谢

- [openwrt/openwrt](https://github.com/openwrt/openwrt)
- [friendlyarm/friendlywrt](https://github.com/friendlyarm/friendlywrt)
- [coolsnowwolf/lede](https://github.com/coolsnowwolf/lede)
- [friendlyarm.com](http://wiki.friendlyarm.com/wiki/index.php/How_to_Build_FriendlyWrt/zh)
- [klever1988 ](https://github.com/klever1988/)
- [fanck0605](https://github.com/fanck0605)
- [jerrykuku/theme-argon](https://github.com/jerrykuku/luci-theme-argon)
- 各位插件大佬
- 等
