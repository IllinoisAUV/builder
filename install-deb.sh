#!/bin/sh

set -e

SCRIPT_DIR=$(dirname $0)

DIR=$(mktemp -d)

# echo $DIR

SYSROOT=${SYSROOT:=/opt/install/aarch64-linux-gnu/sysroot}

# dpkg --root=${SYSROOT} -i --ignore-depends= $1

dpkg-deb -R $1 ${DIR}
rsync -ah --exclude 'DEBIAN' ${DIR}/ ${SYSROOT}/
# if [ -d "${DIR}/contents/usr" ]; then
# 	echo "${DIR}/contents/usr -> ${SYSROOT}"
# 	rsync -ah ${DIR}/contents/usr/ "${SYSROOT}"
# fi

# for path in $DIR/contents/*; do
#     case $path in
#         DEBIAN) 
#             ;;
#         */usr) 
#             ;;
#         *) 
#             echo "${path} -> /$(basename $path)"
#             rsync -ah "${path}/" "/$(basename $path)"
#             ;;
#     esac
# done
