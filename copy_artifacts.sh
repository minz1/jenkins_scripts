#!/bin/bash

# $1 - Build number
# $2 - Workspace Directory
# $3 - Device
# $4 - Build Directory
# $5 - Target package

cd /var/lib/jenkins/android/"$4"/out/target/product/"$3" || exit 0

rm -rf $2/*

if [ "$5" == "bacon" ]; then
    for z in *.zip; do
        if [[ "${z}" != *"ota"* ]]; then
            cp -v "$z" "$2/${z%.zip}-$1.zip"
        fi
    done
elif [ "$5" == "bootimage" ]; then
    cp boot.img "$2/boot-$1.img"
elif [ "$5" == "recoveryimage" ]; then
    cp recovery.img "$2/recovery-$1.img"
    cp recovery.tar "$2/recovery-$1.tar" || exit 0
fi
