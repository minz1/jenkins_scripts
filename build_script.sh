#!/bin/bash

# Simple build script.

# $1 - Build Directory
# $2 - Device
# $3 - ROM Prefix
# $4 - Build flavor
# $5 - Clean type
# $6 - Target package
# $7 - Repo sync?
# $8 - Repo pick topic
# $9 - Update local manifest?
# $10 - Manifest link

LOCAL_MANIFEST_DIR=".repo/local_manifests/"

if [ $# -lt 10 ]; then
    exit
fi

cd /var/lib/jenkins/android/"$1" || exit 0

if [[ "$9" = true ]]; then
    if [ ! -d "$LOCAL_MANIFEST_DIR" ]; then
        mkdir "$LOCAL_MANIFEST_DIR"
    fi

    cd "$LOCAL_MANIFEST_DIR"
    wget "${10}"
    cd ../../
fi

export USE_CCACHE=1

source build/envsetup.sh

if [ "$7" = true ]; then
    repo sync --force-sync -j$(nproc --all)
fi

if [ "$8" != "none" ]; then
    repopick -t "$8"
fi

lunch "$3_$2-$4" -j$(nproc --all)

if [ "$5" == "clean" ]; then
    mka clean
elif [ "$5" == "installclean" ]; then
    mka installclean
fi

if [ "$1" == "twrp" ]; then
    export ALLOW_MISSING_DEPENDENCIES=true
fi

mka "$6"
