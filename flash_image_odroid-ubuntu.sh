#!/bin/bash
flashDriveBootfs=/media/$USER/boot
flashDriveRootfs=/media/$USER/rootfs
if [ ! -d  "$flashDriveBootfs" ]; then
    echo "boot partition '$flashDriveBootfs' not found!"
    exit
fi
if [ ! -d  "$flashDriveRootfs" ]; then
    echo "rootfs partition '$flashDriveRootfs' not found!"
    exit
fi

datenow=$(date +'%Y%m%d_%H%M%S')

echo "Copying image"

if [ -f  "$flashDriveBootfs/zImage" ]; then
    cp "$flashDriveBootfs/zImage" "$flashDriveBootfs/zImage.$datenow"
fi
if [ -f  "$flashDriveBootfs/exynos5422-odroidxu3.dtb" ]; then
    cp "$flashDriveBootfs/exynos5422-odroidxu3.dtb" "$flashDriveBootfs/exynos5422-odroidxu3.dtb.$datenow"
fi

cp arch/arm/boot/zImage $flashDriveBootfs
cp arch/arm/boot/dts/exynos5422-odroidxu3.dtb $flashDriveBootfs

echo "Instaling modules"
sudo INSTALL_MOD_PATH=$flashDriveRootfs make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- modules_install

sync
