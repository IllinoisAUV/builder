#!/bin/bash
set -xe


# Make a new workspace that overlays the system install space
source /opt/ros/kinetic/setup.bash
mkdir -p /tmp/catkin_ws
cd /tmp/catkin_ws/src
catkin_init_workspace
cd ..
source /opt/ros/kinetic/setup.bash
catkin_make

# --exclude RPP indicates that packages that are available in the package path should not be redownloaded
rosinstall_generator mavros mavros_extras --rosdistro kinetic --deps --wet-only --tar --exclude RPP > kinetic-mavros-wet.rosinstall
wstool init /tmp/catkin_ws/src kinetic-mavros-wet.rosinstall
wstool update -t src
catkin_make_isolated -j$(nproc) --merge --install --install-space /opt/ros/kinetic -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=/toolchain.cmake -DCATKIN_ENABLE_TESTING=OFF -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -DCMAKE_LIBRARY_PATH=/usr/local/cuda/lib64/stubs -DWITH_CUDA=OFF

cd /
