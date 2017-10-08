#!/bin/bash
set -xe

cd /ros_catkin_ws

rosinstall_generator ros_comm rospy roscpp sensor_msgs geometry_msgs nav_msgs mavros_msgs visualization_msgs tf2 catkin --rosdistro kinetic --deps --wet-only --tar > kinetic-ros_comm-wet.rosinstall
wstool merge -t src kinetic-ros_comm-wet.rosinstall
wstool update -t src
./src/catkin/bin/catkin_make_isolated --merge --install --install-space /opt/ros/kinetic -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=/toolchain.cmake -DCATKIN_ENABLE_TESTING=OFF -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
