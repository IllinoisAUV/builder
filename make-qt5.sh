#!/bin/bash

set -xe

# wget https://download.qt.io/archive/qt/5.9/5.9.0/single/qt-everywhere-opensource-src-5.9.0.tar.xz -O /tmp/qt-everywhere-opensource-src-5.9.0.tar.xz
# tar -xf /tmp/qt-everywhere-opensource-src-5.9.0.tar.xz -C /tmp

# ./configure -release -opengl es2 -device linux-rasp-pi2-g++ -device-option CROSS_COMPILE=$TOOLCHAIN/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf- -sysroot $ROOTFS -prefix /usr/local/qt5

cd /tmp/qt-everywhere-opensource-src-5.9.0

# ./configure \
# -device linux-jetson-tx1-g++ \
# -device-option CROSS_COMPILE=aarch64-linux-gnu-
# -sysroot $SYSROOT \
# -nomake examples \
# -nomake tests \
# -nomake demos \
# -shared \
# -strip \
# -prefix / \
# -opensource \
# -extprefix $HOME/tx1/qt5 \
# -hostprefix $HOME/tx1/qt5-host \
# -opengl es2

# ./configure -opensource -release --confirm-license -device linux-jetson-tx1-g++ -device-option CROSS_COMPILE=aarch64-linux-gnu- -sysroot $SYSROOT -nomake examples -nomake tests -prefix /usr/local/qt5 
# -hostprefix /usr -opengl es2 -L /usr/lib/aarch64-linux-gnu -skip webkit -skip webview -skip webkit-examples
# -extprefix //home/<USERNAME>/64_TX2/qt5

./configure -opensource \
-release \
--confirm-license \
-device linux-jetson-tx1-g++ \
-device-option CROSS_COMPILE=aarch64-linux-gnu- \
-sysroot $SYSROOT \
-no-tslib \
-no-sql-sqlite \
-no-d3d12 \
-qt-libpng \
-qt-libjpeg \
-qt-zlib \
-qt-freetype \
-qt-xkbcommon-x11 \
-qt-xcb \
-qt-freetype \
-qt-pcre \
-qt-harfbuzz \
-skip multimedia \
-skip wayland \
-skip winextras \
-skip webchannel \
-skip webengine \
-skip websockets \
-skip webkit \
-skip webview \
-skip webkit-examples \
-skip location \
-skip sensors \
-skip qt3d \
-skip gamepad \
-skip qtconnectivity \
-nomake examples \
-nomake tests \
-nomake tools;

make -j$(nproc)

make install

cd /
rm -rf /tmp/*
