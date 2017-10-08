#!/bin/bash

set -xe

mkdir /ros_catkin_ws 
cd /ros_catkin_ws 
rosinstall_generator catkin --rosdistro kinetic --deps --wet-only --tar > kinetic-catkin-wet.rosinstall 
wstool init -j$(nproc) /ros_catkin_ws/src kinetic-catkin-wet.rosinstall
