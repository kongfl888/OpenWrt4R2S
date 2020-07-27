#! /bin/bash
#
# [K] (c)2020
#
# * * folder maxdepth

c=0
sdepth=0
depth=0
maxdepth=0
con=0
dir0=${1}

if [ ${2} -gt 0 ] 2>/dev/null; then
    maxdepth=${2}
else
    maxdepth=12
fi

if [ -d ${1} ]; then
    dir0=`echo "${1}" | sed -e 's/[\/]*$//g'`
    p=`echo "$dir0" | sed -e 's/^[\/]*//g'`
    sdepth=`echo "$p" | awk -F"/" '{print NF-1}'`
else
    echo ${1}
    exit 0
fi

echo "sdepth: $sdepth - maxdepth: $maxdepth" && sleep 2

function ls_dir(){
for file in `ls $1`; do
    echo $1"/"$file
    if [ -d $1"/"$file ]; then
        p=`echo $1"/"$file | sed -e 's/^[\/]*//g' | sed -e 's/[\/]*$//g'`
        depth=`echo "$p" | awk -F"/" '{print NF-1}'`
        depth=$(($depth - $sdepth))
        [ $depth -ge $maxdepth ] || ls_dir $1"/"$file
    fi
done
}

ls_dir $dir0 || exit 0
