#!/bin/bash
#
# [K] (C) 2020
# Remove upx commands

rm_upx() {
    makefile_file="$({ find ${1}|grep Makefile |sed "/Makefile./d"; } 2>"/dev/null")"
    for a in ${makefile_file}
    do
        if [ `echo "$a" | grep -c "upx\/Makefile"` -gt 0 ]; then
            continue
        fi
        if [ -n "$(grep "upx" "$a")" ]; then
            echo "remove upx: $a"
            sed -i "/upx/d" "$a"
        fi
    done
}

rm_upx "package"
rm_upx "feeds"

exit 0
