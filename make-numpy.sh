#!/bin/bash

set -xe


# cd /tmp

apt-get -y install python-numpy

# apt-get source python-numpy
# cd python-numpy*

# CC="$TRIPLET-gcc" CFLAGS="-Wp,-v -I$SYSROOT/usr/include/python2.7" LDSHARED="$TRIPLET-gcc -shared" ./setup.py build
# CC="$TRIPLET-gcc" CFLAGS="-Wp,-v -I$SYSROOT/usr/include/python2.7" LDSHARED="$TRIPLET-gcc -shared" ./setup.py install --prefix=$SYSROOT/usr

# cd /
# rm -rf /tmp/*
