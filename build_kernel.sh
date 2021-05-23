#!/bin/bash

mkdir out

BUILD_CROSS_COMPILE=/home/devries/Workspace/Kernel/Toolchain/aarch64-linux-android-4.9/bin/aarch64-linux-android-
CLANG_PATH=/home/devries/Workspace/Kernel/Toolchain/clang/clang-r383902/bin
CLANG_TRIPLE=aarch64-linux-gnu-
KERNEL_MAKE_ENV="DTC_EXT=$(pwd)/tools/dtc CONFIG_BUILD_ARM64_DT_OVERLAY=y"

export ARCH=arm64
export PATH=${CLANG_PATH}:${PATH}

make -j64 -C $(pwd) O=$(pwd)/out $KERNEL_MAKE_ENV CROSS_COMPILE=$BUILD_CROSS_COMPILE CLANG_TRIPLE=$CLANG_TRIPLE \
    CC=clang LD=ld.lld \
    vendor/devries_defconfig

make -j64 -C $(pwd) O=$(pwd)/out $KERNEL_MAKE_ENV CROSS_COMPILE=$BUILD_CROSS_COMPILE CLANG_TRIPLE=$CLANG_TRIPLE \
    CC=clang LD=ld.lld \
    2>&1 | tee build.txt

cp out/arch/arm64/boot/Image $(pwd)/arch/arm64/boot/Image
