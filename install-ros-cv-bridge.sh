#!/bin/bash

set -xe

mkdir /ros_catkin_ws2
cd /ros_catkin_ws2
rosinstall_generator opencv3 cv_bridge image_transport image_transport_plugins pluginlib classloader --rosdistro kinetic --deps --wet-only --tar > kinetic-ros_comm-wet.rosinstall
wstool init -j$(nproc) src kinetic-ros_comm-wet.rosinstall
./src/catkin/bin/catkin_make_isolated -j$(nproc) --install --install-space /opt/ros/kinetic -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=/toolchain.cmake -DCATKIN_ENABLE_TESTING=OFF -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON

cd /
rm -rf  /ros_catkin_ws2

# wget http://packages.ros.org/ros/ubuntu/pool/main/r/ros-kinetic-opencv3/ros-kinetic-opencv3_3.2.0-4xenial-20170607-102606-0800_arm64.deb -O /tmp/ros-kinetic-opencv3_3.2.0-4xenial-20170607-102606-0800_arm64.deb
# /install-deb.sh /tmp/ros-kinetic-opencv3_3.2.0-4xenial-20170607-102606-0800_arm64.deb

# wget http://packages.ros.org/ros/ubuntu/pool/main/r/ros-kinetic-cv-bridge/ros-kinetic-cv-bridge_1.12.4-0xenial-20170614-095040-0800_arm64.deb -O /tmp/ros-kinetic-cv-bridge_1.12.4-0xenial-20170614-095040-0800_arm64.deb
# /install-deb.sh /tmp/ros-kinetic-cv-bridge_1.12.4-0xenial-20170614-095040-0800_arm64.deb

# wget http://packages.ros.org/ros/ubuntu/pool/main/r/ros-kinetic-image-transport/ros-kinetic-image-transport_1.11.12-0xenial-20170614-102736-0800_arm64.deb -O /tmp/ros-kinetic-image-transport_1.11.12-0xenial-20170614-102736-0800_arm64.deb
# /install-deb.sh /tmp/ros-kinetic-image-transport_1.11.12-0xenial-20170614-102736-0800_arm64.deb


# wget http://packages.ros.org/ros/ubuntu/pool/main/r/ros-kinetic-image-transport-plugins/ros-kinetic-image-transport-plugins_1.9.5-0xenial-20170614-232943-0800_arm64.deb -O /tmp/ros-kinetic-image-transport-plugins_1.9.5-0xenial-20170614-232943-0800_arm64.deb
# /install-deb.sh /tmp/ros-kinetic-image-transport-plugins_1.9.5-0xenial-20170614-232943-0800_arm64.deb

# wget http://packages.ros.org/ros/ubuntu/pool/main/r/ros-kinetic-pluginlib/ros-kinetic-pluginlib_1.10.5-0xenial-20170614-053649-0800_arm64.deb -O /tmp/ros-kinetic-pluginlib_1.10.5-0xenial-20170614-053649-0800_arm64.deb
# /install-deb.sh /tmp/ros-kinetic-pluginlib_1.10.5-0xenial-20170614-053649-0800_arm64.deb

# wget http://packages.ros.org/ros/ubuntu/pool/main/r/ros-kinetic-class-loader/ros-kinetic-class-loader_0.3.6-0xenial-20170227-212536-0800_arm64.deb -O /tmp/ros-kinetic-class-loader_0.3.6-0xenial-20170227-212536-0800_arm64.deb
# /install-deb.sh /tmp/ros-kinetic-class-loader_0.3.6-0xenial-20170227-212536-0800_arm64.deb

cd /
rm -rf /tmp/*
