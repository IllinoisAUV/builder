FROM ubuntu:16.04


RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

RUN apt-get update && apt-get install -y \
    python-rosdep \
    python-rosinstall \
    python-rosinstall-generator \
    python-wstool \
    build-essential \
    python-empy

RUN apt-get install -y \
    g++-aarch64-linux-gnu \
    gcc-aarch64-linux-gnu \
    binutils-aarch64-linux-gnu \
    cmake \
    git

RUN apt-get install -y wget


# Cross compiling cmake toolchain
ADD toolchain.cmake /toolchain.cmake

# Install libpython from deb
RUN wget -O /tmp/libpython2.7.deb http://ftp.us.debian.org/debian/pool/main/p/python2.7/libpython2.7_2.7.13-4_arm64.deb
RUN mkdir /tmp/libpython
RUN dpkg-deb -R /tmp/libpython2.7.deb /tmp/libpython
RUN rsync -rah /tmp/libpython/usr/ /usr/aarch64-linux-gnu

RUN wget -O /tmp/libpython2.7-dev.deb http://ftp.us.debian.org/debian/pool/main/p/python2.7/libpython2.7-dev_2.7.13-2_arm64.deb
RUN mkdir /tmp/libpython-dev
RUN dpkg-deb -R /tmp/libpython2.7-dev.deb /tmp/libpython-dev
RUN rsync -rah /tmp/libpython-dev/usr/ /usr/aarch64-linux-gnu

# Build and install console_bridge
RUN wget -O /tmp/console_bridge.tar.gz https://github.com/ros/console_bridge/archive/0.3.2.tar.gz
RUN tar -xf /tmp/console_bridge.tar.gz -C /tmp
RUN cd /tmp/console_bridge-0.3.2 && cmake . -DCMAKE_TOOLCHAIN_FILE=/toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/aarch64-linux-gnu/
RUN cd /tmp/console_bridge-0.3.2 && make
RUN cd /tmp/console_bridge-0.3.2 && make install


# Install tinyxml from deb
RUN wget -O /tmp/libtinyxml-dev.deb http://ftp.us.debian.org/debian/pool/main/t/tinyxml/libtinyxml2.6.2v5_2.6.2-4_arm64.deb
RUN mkdir /tmp/tinyxml
RUN dpkg-deb -R /tmp/libtinyxml-dev.deb /tmp/tinyxml
RUN rsync -ah /tmp/tinyxml/usr/ /usr/aarch64-linux-gnu

RUN wget -O /tmp/libtinyxml-dev.deb http://ftp.us.debian.org/debian/pool/main/t/tinyxml/libtinyxml-dev_2.6.2-4_arm64.deb
RUN mkdir /tmp/tinyxml-dev
RUN dpkg-deb -R /tmp/libtinyxml-dev.deb /tmp/tinyxml-dev
RUN rsync -ah /tmp/tinyxml-dev/usr/ /usr/aarch64-linux-gnu

# Install libbz2-dev from deb
RUN wget -O /tmp/libbz2-dev.deb http://ftp.us.debian.org/debian/pool/main/b/bzip2/libbz2-dev_1.0.6-8.1_arm64.deb
RUN mkdir /tmp/libbz2-dev
RUN dpkg-deb -R /tmp/libbz2-dev.deb /tmp/libbz2-dev
RUN rsync -ah /tmp/libbz2-dev/usr/ /usr/aarch64-linux-gnu

# Build and install boost
ADD user-config.jam /root/user-config.jam
RUN wget -O /tmp/boost.tar.bz2 http://sourceforge.net/projects/boost/files/boost/1.58.0/boost_1_58_0.tar.bz2
RUN tar -xf /tmp/boost.tar.bz2 -C /tmp
RUN cd /tmp/boost_1_58_0/tools/build && ./bootstrap.sh
RUN cd /tmp/boost_1_58_0/tools/build && ./b2 install
 
# Install boost
RUN cd /tmp/boost_1_58_0 && ./bootstrap.sh toolset=gcc-arm --without-libraries=python --prefix=/usr/aarch64-linux-gnu
# -q makes it fail completely on first failure, so that they don't get lost in all the logging
RUN cd /tmp/boost_1_58_0 && ./bjam -q toolset=gcc-arm architecture=arm abi=aapcs address-model=64 -j4 --prefix=/usr/aarch64-linux-gnu install


# Build and install ROS
RUN rosdep init
RUN rosdep update
RUN mkdir /ros_catkin_ws
RUN cd /ros_catkin_ws && rosinstall_generator ros_comm --rosdistro kinetic --deps --wet-only --tar > kinetic-ros_comm-wet.rosinstall
RUN cd /ros_catkin_ws && wstool init -j4 src kinetic-ros_comm-wet.rosinstall
# RUN cd ros_catkin_ws && rosdep install --from-paths src --ignore-src --rosdistro kinetic -y
RUN cd /ros_catkin_ws && ./src/catkin/bin/catkin_make_isolated --install --install-space /opt/ros/kinetic -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=/toolchain.cmake

# RUN mkdir -p /catkin_ws
# 
# # Source ROS setup files
# RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
# RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc


# WORKDIR /catkin_ws
# VOLUME ["/catkin_ws", "/boost"]
# CMD ["bash", "-i", "-c", "catkin_make", "-DCMAKE_TOOLCHAIN_FILE=/toolchain.cmake"]
