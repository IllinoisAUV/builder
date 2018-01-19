#!/bin/bash

set -e

wget --quiet https://downloads.sourceforge.net/project/tinyxml/tinyxml/2.6.2/tinyxml_2_6_2.zip -O /tmp/tinyxml_2_6_2.zip
unzip /tmp/tinyxml_2_6_2.zip -d /tmp
cd /tmp/tinyxml

export CC=aarch64-linux-gnu-gcc
export CXX=aarch64-linux-gnu-g++
export LD=aarch64-linux-gnu-g++
export AR='aarch64-linux-gnu-ar rc'
export RANLIB=aarch64-linux-gnu-ranlib

sed -i "s/RELEASE_CFLAGS *:= -Wall -Wno-unknown-pragmas -Wno-format -O3/RELEASE_CFLAGS := -Wall -Wno-unknown-pragmas -Wno-format -O3 -fPIC/g" Makefile

sed -i "s/CC *:= gcc/CC = $CC/g" Makefile
sed -i "s/CXX *:= g++/CXX = $CXX/g" Makefile
sed -i "s/LD *:= g++/LD = $LD/g" Makefile
sed -i "s/AR *:= ar rc/AR = $AR/g" Makefile
sed -i "s/RANLIB *:= ranlib/RANLIB = $RANLIB/g" Makefile
sed -i "s/TINYXML_USE_STL := NO/TINYXML_USE_STL := YES/g" Makefile

patch tinyxml.h /enforce-use-stl.patch

make -j$(nproc)
$CXX -shared -olibtinyxml.so.0.1 -Wl,-soname,libtinyxml.so.0 $(ls *.o | grep -v xmltest)

mv libtinyxml.so.0.1 $SYSROOT/usr/lib
mv tinyxml.h $SYSROOT/usr/include

cd $SYSROOT/usr/lib && ln -s libtinyxml.so.0.1 libtinyxml.so


cd /
rm -rf /tmp/*
