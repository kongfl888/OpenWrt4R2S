## Nanopi r2s openwrt 自用固件

![r2s Lean-openwrt lite2](https://github.com/kongfl888/nanopi-openwrt/workflows/r2s%20Lean-openwrt%20lite2/badge.svg) ![r2s minimal2 Build](https://github.com/kongfl888/nanopi-openwrt/workflows/r2s%20Lean-openwrt%20minimal2/badge.svg) ![r2s-friendlywrt-lean](https://github.com/kongfl888/nanopi-openwrt/workflows/r2s-friendlywrt-lean/badge.svg)  ![r2s official Build](https://github.com/kongfl888/nanopi-openwrt/workflows/r2s%20%E5%AE%98%E7%89%88friendlywrt/badge.svg) 

### 代码说明

本库派生自 [klever1988/nanopi-openwrt](https://github.com/klever1988/nanopi-openwrt) 和 [fanck0605/nanopi-r2s](https://github.com/fanck0605/nanopi-r2s)，并由这两个作者主力维护.

### 固件说明

本固件是friendlywrt和openwrt混编的结果，前者为基后者为主。

minimal版本就是Lean版opwenwrt的最小编译，加入Turbo加速和一两个VPN插件和广告插件跟KMS等（不含多播），是原作者主力维护的版本

r2s-friendlywrt-lean版是基于[fanck0605/friendlywrt-lean](https://github.com/fanck0605/friendlywrt-lean) 编译的版本，friendlywrt-lean由该作者主动维护，它的代码比较整洁。

而minimal2 ——本人日常版本—— 则是在minimal版的基础上加入最基本的NAS应用：网络共享(samba)、下载工具和硬盘休眠，以及家庭网络必备的minidlna。再挂个QOS留用。软路由空间大，没个samba实在是浪费。

多播还是没有，因为我这边好像不支持多播，测试不了所以不想加（好吧，因为iptv所以一起加了）。另，[关于MWAN3掉线的解决方案](https://koolshare.cn/thread-150601-1-1.html)（可以改用114DNS）、[IPTV教程](https://github.com/riverscn/openwrt-iptvhelper/blob/master/README.md)

而lite2则是在minimal2基础上再去掉各种不可说和多拨以及某些策略代理插件（反正就是防火墙应用尽可能少）。minimal2和lite2都带网络自检

对了，docker也没有。

usb-wifi驱动有，就网上常见的芯片，👇

![支持列表](./assets/R2swrt-usbwifi-08.jpg)

建议不要对它抱有太大的期望。👆

### 发布地址

[下载传送门](https://github.com/kongfl888/nanopi-openwrt/releases)

[friendlywrt官版](https://github.com/kongfl888/nanopi-openwrt/actions?query=workflow%3A%22r2s%20%E5%AE%98%E7%89%88friendlywrt%22)（打 ✔ 的）

[网盘分流](https://github.com/kongfl888/nanopi-openwrt/blob/master/README.txt)

（彻底解压出来，img包才是最终固件格式）

### 一些软件包

含MWAN3负载均衡、IPTV助手、adgurdhome、adbuby-plus、syncdial多拨、[r2s刷机助手](https://github.com/kongfl888/luci-app-r2sflasher/releases)、[定时重拨助手](https://github.com/kongfl888/luci-app-autorewan/releases)。

可直接上传到路由器安装：[IPK分流](https://kongfl888.lanzous.com/b04sj203c) （密码:abw4）（仅仅适用于minimal系列，其他未测，但基本能装上就能用）

[其他R2S可用的软件包](https://github.com/kongfl888/r2s-openwrt-packages/blob/master/README.md)

### 刷机

你可以有三种方法

一、打开WEB页面，
	
使用 [R2S刷机](https://github.com/kongfl888/luci-app-r2sflasher/releases)

二、打开SSH，

``cd /tmp && wget https://raw.githubusercontent.com/kongfl888/nanopi-openwrt/master/scripts/flash_rom.sh
flash_rom /tmp/rom.img.gz /dev/mmcblk0 gz``

三、PC端刷卡

1、Ubuntu下（其中/dev/sdX为TF卡的真实路径）

``sudo dd if=out/FriendlyWrt_20xxxx_NanoPi-R1_armhf_sd.img bs=1M of=/dev/sdX``

2、Windows系统

下载 [balenaEtcher](http://www.ksite.xyz/contents/balena-etcher.html)，插卡刷机
    
### 登录

路由器登陆页面： http://friendlywrt/

默认用户名是``root``, 密码是 ``password`` 或 ``空密码``。

### 三外设说明

tf卡直接影响系统启动速度。建议使用C10+卡，卡容量大小至少4GB。开机后连不上，等待5分钟后直接断电重启！

电流不稳或波动大直接影响板子的正常运行

USB可能会导致IO冲突，因为有一个千兆网口就是USB3转过来的

### 更新说明

[Minimal的更新内容](https://github.com/klever1988/nanopi-openwrt/blob/master/CHANGELOG.md) 、[LEAN-LEDE的更新说明](https://github.com/coolsnowwolf/lede/commits/master)

固件菜单预览

Minimal2  -  Lite2

![Minimal2.gif](./assets/mini2.gif) .  -  . ![Lite2.gif](./assets/lite2.gif)

#### 本固件(minimal版本)NAT基准性能测试：

<img src="https://github.com/klever1988/nanopi-openwrt/raw/master/assets/NAT.jpg" width="600" /><img src="https://raw.githubusercontent.com/klever1988/nanopi-openwrt/master/assets/Acc.jpg" width="250" />

### 致谢

- [friendlyarm.com](http://wiki.friendlyarm.com/wiki/index.php/How_to_Build_FriendlyWrt/zh)
- [openwrt/openwrt](https://github.com/openwrt/openwrt)
- [friendlyarm/friendlywrt](https://github.com/friendlyarm/friendlywrt)
- [coolsnowwolf/lede](https://github.com/coolsnowwolf/lede)
- [klever1988/friendlywrt ](https://github.com/klever1988/friendlywrt)
- [fanck0605/friendlywrt-lean](https://github.com/fanck0605/friendlywrt-lean)
- 各位插件大佬
- 等