#! /bin/bash
#
# [K] (c)2020
#

function ls_dir(){
for file in `ls $1`; do
 if [ -d $1"/"$file ]; then
    ls_dir $1"/"$file
 else
    echo $1"/"$file
 fi
done
}

ls_dir $1 || exit 0
