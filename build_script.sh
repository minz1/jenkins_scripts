#!/bin/bash

# Simple build script.

# $1 - Build Directory
# $2 - Device
# $3 - ROM Prefix
# $4 - Build flavor
# $5 - Make clean?
# $6 - Target package
# $7 - Repo sync?

if [ $# -lt 7 ]; then
    exit
fi

cd /var/lib/jenkins/android/"$1" || exit 0

export USE_CCACHE=1

source build/envsetup.sh

if [ "$7" = true ]; then
    repo sync --force-sync -j$(nproc --all)
fi

lunch "$3_$2-$4" -j$(nproc --all)

if [ "$5" = true ]; then
    mka clean
fi

if [ "$1" == "twrp" ]; then
    export ALLOW_MISSING_DEPENDENCIES=true
fi

mka "$6"
