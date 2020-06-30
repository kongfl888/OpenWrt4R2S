#!/bin/bash

#hd-idle
if [ -e "feeds/luci/applications/luci-app-hd-idle/root/usr/share/luci/menu.d/luci-app-hd-idle.json" ]; then
    sed -i 's/admin\/services\/hd_idle/admin\/nas\/hd_idle/g' feeds/luci/applications/luci-app-hd-idle/root/usr/share/luci/menu.d/luci-app-hd-idle.json
elif [ -e "feeds/luci/applications/luci-app-hd-idle/luasrc/controller/hd_idle.lua" ]; then
    sed -i 's/\"services\",/\"nas\",/g' feeds/luci/applications/luci-app-hd-idle/luasrc/controller/hd_idle.lua
fi

#samba4
if [ -e "feeds/luci/applications/luci-app-samba4/root/usr/share/luci/menu.d/luci-app-samba4.json" ]; then
    sed -i 's/admin\/services\/samba4/admin\/nas\/samba4/g' feeds/luci/applications/luci-app-samba4/root/usr/share/luci/menu.d/luci-app-samba4.json
elif [ -e "feeds/luci/applications/luci-app-samba4/luasrc/controller/samba4.lua" ]; then
    sed -i 's/\"services\",/\"nas\",/g' feeds/luci/applications/luci-app-samba4/luasrc/controller/samba4.lua
fi

#samba
if [ -e "feeds/luci/applications/luci-app-samba/root/usr/share/luci/menu.d/luci-app-samba.json" ]; then
    sed -i 's/admin\/services\/samba/admin\/nas\/samba/g' feeds/luci/applications/luci-app-samba/root/usr/share/luci/menu.d/luci-app-samba.json
elif [ -e "feeds/luci/applications/luci-app-samba/luasrc/controller/samba.lua" ]; then
    sed -i 's/\"services\",/\"nas\",/g' feeds/luci/applications/luci-app-samba/luasrc/controller/samba.lua
fi

#minidlna
if [ -e "feeds/luci/applications/luci-app-minidlna/root/usr/share/luci/menu.d/luci-app-minidlna.json" ]; then
    sed -i 's/admin\/services\/minidlna/admin\/nas\/minidlna/g' feeds/luci/applications/luci-app-minidlna/root/usr/share/luci/menu.d/luci-app-minidlna.json
elif [ -e "feeds/luci/applications/luci-app-minidlna/luasrc/controller/minidlna.lua" ]; then
    sed -i 's/\"services\",/\"nas\",/g' feeds/luci/applications/luci-app-minidlna/luasrc/controller/minidlna.lua
fi

#aria2
if [ -e "feeds/luci/applications/luci-app-aria2/root/usr/share/luci/menu.d/luci-app-aria2.json" ];then
    sed -i 's/admin\/services\/aria2/admin\/nas\/aria2/g' feeds/luci/applications/luci-app-aria2/root/usr/share/luci/menu.d/luci-app-aria2.json
elif [ -e "feeds/luci/applications/luci-app-aria2/luasrc/controller/aria2.lua" ]; then
    sed -i 's/\"services\",/\"nas\",/g' feeds/luci/applications/luci-app-aria2/luasrc/controller/aria2.lua
fi

#qbittorrent
if [ -e "feeds/luci/applications/luci-app-qbittorrent/root/usr/share/luci/menu.d/luci-app-qbittorrent.json" ];then
    sed -i 's/admin\/services\/qbittorrent/admin\/nas\/qbittorrent/g' feeds/luci/applications/luci-app-qbittorrent/root/usr/share/luci/menu.d/luci-app-qbittorrent.json
elif [ -e "feeds/luci/applications/luci-app-qbittorrent/luasrc/controller/qbittorrent.lua" ]; then
    sed -i 's/\"services\",/\"nas\",/g' feeds/luci/applications/luci-app-qbittorrent/luasrc/controller/qbittorrent.lua
fi

