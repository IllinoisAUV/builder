#!/bin/bash
set -xe

# Assumes /tmp/packages-all exists

cd /tmp

for var in "$@"
do
    /get-debs.py $1 >> packages-unsorted
done

sort -u packages-unsorted | uniq > packages

cat packages | xargs apt-get download
# Fetch all debs that haven't already been installed
# comm -13 <(sort file1) <(sort file2) returns all of the lines in file2 not in file1
comm -13 <(sort packages-all) <(sort packages) | xargs apt-get download
# Extract debs into the sysroot
ls *.deb | xargs --max-procs $(nproc) -I pkg -n1 dpkg-deb -x pkg $SYSROOT 

rm *.deb
rm packages
