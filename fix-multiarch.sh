#!/bin/bash

set -e


# mv $SYSROOT/usr/lib/aarch64-linux-gnu $SYSROOT/usr/lib/aarch64-linux-gnu
# mv $SYSROOT/lib/aarch64-linux-gnu $SYSROOT/lib/aarch64-linux-gnu
# mv $SYSROOT/usr/include/aarch64-linux-gnu $SYSROOT/usr/include/aarch64-linux-gnu


ARCH_PATHS=$(find $SYSROOT -name aarch64-linux-gnu -type d)
for ARCH_PATH in $ARCH_PATHS; do
    # cd $(dirname $ARCH_PATH)
    # echo "$ARCH_PATH -> $(dirname $ARCH_PATH)/aarch64-linux-gnu"
    # ls $ARCH_PATH
    # mv $ARCH_PATH $(dirname $ARCH_PATH)/aarch64-linux-gnu
    # ln -s $ARCH_PATH $(dirname $ARCH_PATH)/aarch64-linux-gnu
    LINK=$(dirname $ARCH_PATH)/aarch64-linux-gnu
    ln -s $(realpath $ARCH_PATH) $LINK
    # ls -l $(dirname $ARCH_PATH)/aarch64-linux-gnu
    # ln -s $(basename $ARCH_PATH) ..
done
