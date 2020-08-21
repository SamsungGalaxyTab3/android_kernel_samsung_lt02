#!/bin/bash

echo "#################################"
echo "Kernel Builder Script by GG2501YT"
echo "#################################"
sleep 2

# Props
TARGET_DEVICE="lt02"
KERNEL_CONFIG="pxa986_lt02_defconfig"
OUT_DIR="out"
ARCH="arm"
CROSS_COMPILE="arm-eabi-"
THREADS="4"
LOCAL_DIR=`pwd`

echo ""
echo "– Preparing..."
echo ""
# Download Toolchain
if [ "$(which git)" = "/usr/bin/git" ]; then
    git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-eabi-4.8 -b android-7.1.2_r36 prebuilts/gcc/linux-x86/arm/arm-eabi-4.8
else
    echo "Git not found! Please install!" && exit 255
fi

# Create OUT_DIR
mkdir $OUT_DIR

# Export Toolchain Path
export PATH=$PATH:$LOCAL_DIR/prebuilts/gcc/linux-x86/arm/arm-eabi-4.8/bin

# Export other Stuff
export ARCH=$ARCH
export CROSS_COMPILE=$CROSS_COMPILE

echo ""
echo "– Cleaning..."
echo ""
make O=$OUT_DIR -j$THREADS clean
rm -rf $OUT_DIR/*
rm -rf $OUT_DIR/.*

echo ""
echo "– Building $KERNEL_CONFIG..."
echo ""
make O=$OUT_DIR -j$THREADS $KERNEL_CONFIG

echo ""
echo "– Building Kernel for $TARGET_DEVICE..."
echo ""
make O=$OUT_DIR -j$THREADS

echo ""
echo "Your Kernel is in $OUT_DIR/arch/$ARCH/boot/"
echo ""
ls $OUT_DIR/arch/$ARCH/boot/
