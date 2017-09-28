#!/bin/bash

set -e
SYSROOT=${SYSROOT:=/opt/install/aarch64-linux-gnu/sysroot}

LINKS=$(find $SYSROOT -type l)

for LINK in $LINKS; do
    # If path is absolute
    TARGET=$(readlink $LINK)
    if [[ "$TARGET" = /* ]]; then
        rm $LINK
        echo "$LINK -> $(readlink $SYSROOT/$TARGET)"
        ln -s $(readlink "$SYSROOT/$TARGET") $LINK
    fi
done
