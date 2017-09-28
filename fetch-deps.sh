#!/bin/sh

SCRIPT_DIR=$(dirname $0)

DEPS="http://developer2.download.nvidia.com/embedded/L4T/r28_Release_v1.0/BSP/gcc-4.8.5-aarch64.tgz \
    http://ftp.us.debian.org/debian/pool/main/p/python2.7/libpython2.7_2.7.13-4_arm64.deb \
    http://ftp.us.debian.org/debian/pool/main/p/python2.7/libpython2.7-dev_2.7.13-2_arm64.deb \
    https://github.com/ros/console_bridge/archive/0.3.2.tar.gz \
    http://ftp.us.debian.org/debian/pool/main/b/bzip2/libbz2-1.0_1.0.6-8.1_arm64.deb \
    http://ftp.us.debian.org/debian/pool/main/b/bzip2/libbz2-1.0_1.0.6-8.1_arm64.deb \
    http://ftp.us.debian.org/debian/pool/main/b/bzip2/libbz2-dev_1.0.6-8.1_arm64.deb \
    http://ftp.us.debian.org/debian/pool/main/b/bzip2/libbz2-dev_1.0.6-8.1_arm64.deb \
    http://sourceforge.net/projects/boost/files/boost/1.58.0/boost_1_58_0.tar.bz2 \
    http://ftp.us.debian.org/debian/pool/main/t/tinyxml/libtinyxml2.6.2v5_2.6.2-4_arm64.deb \
    http://ftp.us.debian.org/debian/pool/main/t/tinyxml/libtinyxml-dev_2.6.2-4_arm64.deb \
    http://ftp.us.debian.org/debian/pool/main/z/zlib/zlib1g_1.2.8.dfsg-2+b1_arm64.deb \
    http://ftp.us.debian.org/debian/pool/main/z/zlib/zlib1g-dev_1.2.8.dfsg-5_arm64.deb \
    http://ftp.us.debian.org/debian/pool/main/l/lz4/liblz4-1_0.0~r131-2+b1_arm64.deb \
    http://ftp.us.debian.org/debian/pool/main/l/lz4/liblz4-dev_0.0~r131-2+b1_arm64.deb \
    https://github.com/google/googletest/archive/release-1.8.0.tar.gz \
    https://downloads.sourceforge.net/project/tinyxml/tinyxml/2.6.2/tinyxml_2_6_2.zip \
    https://github.com/lz4/lz4/archive/v1.8.0.tar.gz \
    https://zlib.net/zlib-1.2.11.tar.gz \
    https://github.com/libexpat/libexpat/archive/R_2_2_4.tar.gz \
    https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz \
    https://openssl.org/source/openssl-1.1.0f.tar.gz \
    https://www.sqlite.org/2017/sqlite-autoconf-3200100.tar.gz"


for DEP in $DEPS; do
    echo Fetching $DEP
    if [ ! -f ${SCRIPT_DIR}/deps/$(basename $DEP) ]; then
        wget -P ${SCRIPT_DIR}/deps/ $DEP
    fi
done
# Fetch the latest boost release
# wget https://dl.bintray.com/boostorg/release/1.64.0/source/boost_1_64_0.tar.bz2
# tar -xf boost_1_64_0.tar.bz2

# Get boost to build for aarch64
# ./b2 toolset=gcc-arm -j4 architecture=arm abi=aapcs address-model=64
# ./bjam install --prefix=/usr/aarch64-linux-gnu toolset=gcc-arm -j4

