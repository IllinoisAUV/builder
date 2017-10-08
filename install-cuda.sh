#!/bin/bash

set -xe

apt-get update

dpkg --add-architecture arm64

# wget -O /tmp/cuda-repo-ubuntu1404_7.0-28_amd64.deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/cuda-repo-ubuntu1404_7.0-28_amd64.deb
# dpkg -i /tmp/cuda-repo-ubuntu1404_7.0-28_amd64.deb

wget -O /tmp/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
dpkg -i /tmp/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb


set +e
apt-get update
set -e


# apt install -y cuda-minimal-build-7-0:amd64 cuda-cublas-cross-aarch64-7-0:arm64 cuda-cudart-cross-aarch64-7-0:arm64 cuda-cufft-cross-aarch64-7-0:arm64 cuda-curand-cross-aarch64-7-0:arm64 cuda-cusolver-cross-aarch64-7-0:arm64 cuda-cusparse-cross-aarch64-7-0:arm64 cuda-driver-cross-aarch64-7-0:arm64 cuda-misc-headers-cross-aarch64-7-0:arm64 cuda-npp-cross-aarch64-7-0:arm64 cuda-nvrtc-cross-aarch64-7-0:arm64



# Install cuda 8
apt install -y cuda-cross-aarch64-8-0 # cuda-minimal-build-8-0:amd64 cuda-cublas-cross-aarch64-8-0:arm64 cuda-cudart-cross-aarch64-8-0:arm64 cuda-cufft-cross-aarch64-8-0:arm64 cuda-curand-cross-aarch64-8-0:arm64 cuda-cusolver-cross-aarch64-8-0:arm64 cuda-cusparse-cross-aarch64-8-0:arm64 cuda-driver-cross-aarch64-8-0:arm64 cuda-misc-headers-cross-aarch64-8-0:arm64 cuda-npp-cross-aarch64-8-0:arm64 cuda-nvrtc-cross-aarch64-8-0:arm64


cd /usr/local; ln -s ./cuda-8.0 ./cuda
rm /usr/local/cuda-8.0/lib64 /usr/local/cuda-8.0/include
ln -s /usr/local/cuda-8.0/targets/aarch64-linux/lib /usr/local/cuda-8.0/lib64
ln -s /usr/local/cuda-8.0/targets/aarch64-linux/include /usr/local/cuda-8.0/include
echo 'export PATH=/usr/local/cuda/bin:$PATH' >> /root/.bashrc
# echo 'export LD_LIBRARY_PATH=/usr/arm-linux-gnueabihf/lib' >> /root/.bashrc

cd /
rm -rf /tmp/*
