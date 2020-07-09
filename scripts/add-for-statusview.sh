#!/bin/bash
#
# [K] (c)2020
# http://github.com/kongfl888


mv ../../resources/cpuinfo package/base-files/files/usr/bin/cpuinfo && \
chmod +x package/base-files/files/usr/bin/cpuinfo

mv ../../resources/ethinfo package/base-files/files/usr/bin/ethinfo && \
chmod +x package/base-files/files/usr/bin/ethinfo

mv ../../resources/21_ethinfo.js package/base-files/files/www/luci-static/resources/view/status/include/21_ethinfo.js && \
chmod +x package/base-files/files/www/luci-static/resources/view/status/include/21_ethinfo.js

