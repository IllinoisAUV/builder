FROM ubuntu:16.04


RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

RUN apt-get update && apt-get install -y \
    python-rosdep \
    python-rosinstall \
    python-rosinstall-generator \
    python-wstool \
    build-essential

RUN apt-get install -y \
    g++-aarch64-linux-gnu \
    gcc-aarch64-linux-gnu \
    binutils-aarch64-linux-gnu \
    git

# RUN apt-get install -y wget rsync

# # Build boost for arm
# ADD user-config.jam /root/user-config.jam
# RUN wget https://dl.bintray.com/boostorg/release/1.64.0/source/boost_1_64_0.tar.bz2
# RUN tar -xf boost_1_64_0.tar.bz2 -C /boost
# RUN bash -c "cd /boost/tools/build; ./bootstrap.sh; ./b2 install --prefix=/usr/aarch64-linux-gnu"
# 
# RUN rosdep init
# RUN rosdep update
# 
# ADD rostoolchain.cmake /opt/ros/kinetic/share/ros/rostoolchain.cmake
# 
# 
# # Build and install console_bridge
# RUN git clone git://github.com/ros/console_bridge.git /console_bridge
# RUN bash -c "cd /console_bridge && cmake . -DCMAKE_TOOLCHAIN_FILE=/opt/ros/kinetic/share/ros/rostoolchain.cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/aarch64-linux-gnu/"
# 
# # Install python
# RUN wget http://ftp.us.debian.org/debian/pool/main/p/python2.7/libpython2.7-dev_2.7.13-2_arm64.deb
# RUN mkdir /tmp/python
# RUN dpkg-deb -R libpython2.7-dev_2.7.13-2_arm64.deb /tmp/python
# # Copy all of the files
# RUN rsync -avh /tmp/python/usr /usr/aarch64-linux-gnu
# 
# # Install tinyxml
# RUN wget http://ftp.us.debian.org/debian/pool/main/t/tinyxml/libtinyxml-dev_2.6.2-4_arm64.deb
# RUN mkdir /tmp/tinyxml
# RUN dpkg-deb -R libtinyxml-dev_2.6.2-4_arm64.deb /tmp/tinyxml
# # Copy all of the files
# RUN rsync -avh /tmp/tinyxml/usr /usr/aarch64-linux-gnu
# 
# # Get ros dependencies
# RUN wget http://packages.ros.org/ros/ubuntu/pool/main/r/ros-kinetic-ros-comm/ros-kinetic-ros-comm_1.12.7-0xenial-20170714-110205-0800_arm64.deb
# 
# # Build and install ROS
# RUN mkdir /ros_catkin_ws
# RUN bash -c "cd /ros_catkin_ws && rosinstall_generator ros_comm --rosdistro kinetic --deps --wet-only --tar > kinetic-ros_comm-wet.rosinstall"
# RUN "cd /ros_catkin_ws && wstool init -j4 src kinetic-ros_comm-wet.rosinstall"
# RUN "cd /ros_catkin_ws && rosdep install --from-paths src --ignore-src --rosdistro kinetic -y"
# RUN "cd /ros_catkin_ws && ./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=/opt/ros/kinetic/share/ros/rostoolchain.cmake"


# RUN mkdir -p /catkin_ws
# 
# # Source ROS setup files
# RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
# RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc


# WORKDIR /catkin_ws
# VOLUME ["/catkin_ws", "/boost"]
# CMD ["bash", "-i", "-c", "catkin_make", "-DCMAKE_TOOLCHAIN_FILE=/opt/ros/kinetic/share/ros/rostoolchain.cmake"]
