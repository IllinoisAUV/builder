#!/bin/bash

set -xe


cd /ros_catkin_ws
rosinstall_generator opencv3 --rosdistro kinetic --deps --wet-only --tar > kinetic-opencv3-wet.rosinstall
wstool merge -t src kinetic-opencv3-wet.rosinstall
./src/catkin/bin/catkin_make_isolated -j$(nproc) --merge --install --install-space /opt/ros/kinetic -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=/toolchain.cmake -DCATKIN_ENABLE_TESTING=OFF -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
