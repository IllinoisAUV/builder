FROM ubuntu:16.04

# RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list'
# RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

RUN apt-get update && apt-get install -y \
    python-rosdep \
    python-rosinstall \
    python-rosinstall-generator \
    python-wstool \
    build-essential \
    python-empy
RUN apt-get install -y wget \
    git \
    cmake

# RUN apt-get install -y \
#         binutils-aarch64-linux-gnu \
#         gcc-aarch64-linux-gnu \
#         g++-aarch64-linux-gnu

RUN apt-get install -y wget zip

# ENV SYSROOT=/usr/aarch64-linux-gnu
# RUN mkdir $SYSROOT
# RUN dpkg --add-architecture armhf

# ADD deps/ /deps

# Compile 32 bit
# ADD https://developer.nvidia.com/embedded/dlc/l4t-gcc-toolchain-64-bit-28-1 /downloads/gcc-toolchain.tar.gz
# ADD deps/gcc-4.8.5-aarch64.tgz /opt/
# RUN tar -xf /deps/gcc-4.8.5-aarch64.tgz -C /opt/
# RUN mkdir -p $SYSROOT/var/lib
# RUN cp -rf /var/lib/dpkg $SYSROOT/var/lib/dpkg


# RUN mkdir /tmp/gcc
# RUN tar -xf /deps/src_aarch64_gcc-4.8.5.tar.gz -C /tmp/gcc
# RUN sed -i 's/disable-multilib/enable-multilib/g' /tmp/gcc/make-aarch64-toolchain.sh
# ENV SYSROOT=/opt/install/aarch64-linux-gnu/sysroot


# RUN mkdir -p $SYSROOT/var/lib/
# RUN touch $SYSROOT/var/lib/dpkg/status
# RUN apt-get install -y \
#     g++-arm-linux-gnueabihf \
#     gcc-arm-linux-gnueabihf \
#     binutils-arm-linux-gnueabihf \
#     cmake \
#     git


# RUN wget --quiet https://developer.nvidia.com/embedded/dlc/l4t-sample-root-filesystem-28-1 -O /tmp/Tegra_Linux_Sample-Root-Filesystem_R28.1.0_aarch64.tbz2
# RUN tar -xvf /tmp/Tegra_Linux_Sample-Root-Filesystem_R28.1.0_aarch64.tbz2 -C /usr/aarch64-linux-gnu --exclude 'usr/lib/debug' --exclude 'usr/lib/libreoffice' --exclude 'usr/lib/chromium-browser' usr/lib lib usr/include
# ADD fixsymlinks.sh /fixsymlinks.sh
# RUN /fixsymlinks.sh $SYSROOT

RUN apt-get install -y gawk bison flex texinfo
# ADD install-make.sh /install-make.sh 
# RUN /install-make.sh

RUN mkdir /opt/gcc/
# ADD gcc-4.8.5-aarch64.tgz /opt/gcc/

ADD make-make.sh /make-make.sh
RUN /make-make.sh
ADD make-aarch64-toolchain.sh /tmp/make-aarch64-toolchain.sh
ADD make-gcc.sh /make-gcc.sh
RUN /make-gcc.sh
ENV PATH=/opt/gcc/install/bin:$PATH
ENV SYSROOT=/opt/gcc/install/aarch64-linux-gnu/sysroot
ENV TRIPLET=aarch64-linux-gnu
ENV CROSS_COMPILE=${TRIPLET}-

ADD make-zlib.sh /make-zlib.sh
RUN /make-zlib.sh

# Cross compiling cmake toolchain
ADD toolchain.cmake /toolchain.cmake

# ADD install-deb.sh /install-deb.sh

# ENV CFLAGS="-I$SYSROOT/usr/include -I$SYSROOT/include"
# ENV CXXFLAGS="-I$SYSROOT/usr/include -I$SYSROOT/include"
# ADD ./deps/zlib-1.2.11.tar.gz /tmp/
# RUN tar -xf /tmp/zlib-1.2.11.tar.gz -C /tmp
# ADD make-zlib.sh /make-zlib.sh
# RUN /make-zlib.sh


# Install zlib from deb
# RUN /install-deb.sh /deps/zlib1g_1.2.8.dfsg-2+b1_arm64.deb
# RUN /install-deb.sh /deps/zlib1g-dev_1.2.8.dfsg-5_arm64.deb
# ADD fix-links.sh /fix-links.sh
# RUN /fix-links.sh


# ADD ./deps/openssl-1.1.0f.tar.gz /tmp/
# RUN tar -xf /tmp/openssl-1.1.0f.tar.gz -C /tmp
ADD make-openssl.sh /make-openssl.sh
RUN /make-openssl.sh

# ADD ./deps/sqlite-autoconf-3200100.tar.gz /tmp/
# RUN tar -xf /tmp/sqlite-autoconf-3200100.tar.gz -C /tmp
ADD make-sqlite.sh /make-sqlite.sh
RUN /make-sqlite.sh

# ADD ./deps/libexpat-R_2_2_4.tar.gz /tmp/
# RUN tar -xf /tmp/libexpat-R_2_2_4.tar.gz -C /tmp
ADD make-expat.sh /make-expat.sh
RUN /make-expat.sh

# ADD ./deps/Python-2.7.13.tar.xz /tmp/
# RUN tar -xf /tmp/Python-2.7.13.tar.xz -C /tmp
ADD make-python.sh /make-python.sh
RUN /make-python.sh



# Install libpython from deb
# ADD http://ftp.us.debian.org/debian/pool/main/p/python2.7/libpython2.7_2.7.13-4_arm64.deb /downloads/libpython2.7.deb
# ADD deps/libpython2.7_2.7.13-4_arm64.deb /downloads/
# RUN /install-deb.sh /deps/libpython2.7_2.7.13-4_arm64.deb
# RUN wget -O /tmp/libpython2.7.deb http://ftp.us.debian.org/debian/pool/main/p/python2.7/libpython2.7_2.7.13-4_arm64.deb
# RUN mkdir /tmp/libpython
# RUN dpkg-deb -R /tmp/libpython2.7.deb /tmp/libpython
# RUN rsync -rah /tmp/libpython/usr/ /usr/aarch64-linux-gnu

# ADD http://ftp.us.debian.org/debian/pool/main/p/python2.7/libpython2.7-dev_2.7.13-2_arm64.deb /downloads/libpython2.7-dev.deb
# ADD deps/libpython2.7-dev_2.7.13-2_arm64.deb  /downloads/
# RUN /install-deb.sh /deps/libpython2.7-dev_2.7.13-2_arm64.deb
# RUN wget -O /tmp/libpython2.7-dev.deb http://ftp.us.debian.org/debian/pool/main/p/python2.7/libpython2.7-dev_2.7.13-2_arm64.deb
# RUN mkdir /tmp/libpython-dev
# RUN dpkg-deb -R /tmp/libpython2.7-dev.deb /tmp/libpython-dev
# RUN rsync -rah /tmp/libpython-dev/usr/ /usr/aarch64-linux-gnu


# Install libbz2 from deb
# ADD http://ftp.us.debian.org/debian/pool/main/b/bzip2/libbz2-1.0_1.0.6-8.1_arm64.deb /downloads/libbz2.deb
# ADD libbz2-1.0_1.0.6-8.1_arm64.deb /downloads/
# ADD ./deps/bzip2-1.0.6.tar.gz /tmp/
# RUN tar -xf /tmp/bzip2-1.0.6.tar.gz -C /tmp
ADD make-bzip2.sh /make-bzip2.sh
RUN /make-bzip2.sh
# RUN /install-deb.sh /deps/libbz2-1.0_1.0.6-8.1_arm64.deb
# RUN wget -O /tmp/libbz2.deb http://ftp.us.debian.org/debian/pool/main/b/bzip2/libbz2-1.0_1.0.6-8.1_arm64.deb
# RUN mkdir /tmp/libbz2
# RUN dpkg-deb -R /tmp/libbz2.deb /tmp/libbz2
# RUN rsync -ah /tmp/libbz2/lib/ /lib

# ADD http://ftp.us.debian.org/debian/pool/main/b/bzip2/libbz2-dev_1.0.6-8.1_arm64.deb /downloads/libbz2-dev.deb
# ADD deps/libbz2-dev_1.0.6-8.1_arm64.deb /downloads/
# RUN /install-deb.sh /deps/libbz2-dev_1.0.6-8.1_arm64.deb
# RUN wget -O /tmp/libbz2-dev.deb http://ftp.us.debian.org/debian/pool/main/b/bzip2/libbz2-dev_1.0.6-8.1_arm64.deb
# RUN mkdir /tmp/libbz2-dev
# RUN dpkg-deb -R /tmp/libbz2-dev.deb /tmp/libbz2-dev
# RUN rsync -ah /tmp/libbz2-dev/usr/ /usr/aarch64-linux-gnu

# Build and install boost
# ADD http://sourceforge.net/projects/boost/files/boost/1.58.0/boost_1_58_0.tar.bz2 /downloads/boost.tar.bz2
# ADD boost_1_58_0.tar.bz2 /tmp/
# RUN wget -O /tmp/boost.tar.bz2 http://sourceforge.net/projects/boost/files/boost/1.58.0/boost_1_58_0.tar.bz2

# If you are running linux new than 4.10.0, you may encounter issues with docker
# and mv'ing directories. Updates to the overlay module in the kernel break 
# docker's ability to mv directories. For more information and status see 
# https://github.com/moby/moby/issues/33733
# RUN /fix-links.sh
# ADD fix-multiarch.sh /fix-multiarch.sh
# RUN /fix-multiarch.sh

# ADD ./deps/boost_1_58_0.tar.bz2 /tmp/
# RUN tar -xf /deps/boost_1_58_0.tar.bz2 -C /tmp
# RUN aarch64-linux-gnu-ld --verbose -lbz2
ADD ./make-boost.sh /make-boost.sh
ADD user-config.jam /root/user-config.jam
RUN /make-boost.sh
# RUN cd /tmp/boost_1_58_0/tools/build && ./bootstrap.sh
# RUN cd /tmp/boost_1_58_0/tools/build && ./b2 install
 
# Install boost
# RUN cd /tmp/boost_1_58_0 && ./bootstrap.sh toolset=gcc-arm --prefix=${SYSROOT}/usr

# Remove autogenerated python configuration
# RUN sed -i 's/using python.*//g' /tmp/boost_1_58_0/project-config.jam

# -q makes it fail completely on first failure, so that they don't get lost in all the logging
# The toolset is as specified in user-config.jam, which should be placed in the user's home directory
# architecture, abi, and address-model are required for boost to correctly detect the architecture and build
# See https://groups.google.com/forum/#!topic/boost-developers-archive/namMFSO_6Rg for why python is configured this way
# ENV LD_LIBRARY_PATH=$SYSROOT/lib
# RUN aarch64-linux-gnu-ld --verbose -lbz2
# RUN cd /tmp/boost_1_58_0; ./bjam -q --no-samples --no-tests target-os=linux toolset=gcc-arm architecture=arm abi=aapcs address-model=64 -j4 --prefix=$SYSROOT/usr --debug-configuration install

# ADD ./deps/tinyxml_2_6_2.zip /tmp/
# RUN unzip /tmp/tinyxml_2_6_2.zip -d /tmp
ADD make-tinyxml.sh /make-tinyxml.sh
ADD enforce-use-stl.patch /enforce-use-stl.patch
RUN /make-tinyxml.sh

# Install tinyxml from deb
# ADD deps/libtinyxml2.6.2v5_2.6.2-4_arm64.deb /downloads/
# RUN /install-deb.sh /deps/libtinyxml2.6.2v5_2.6.2-4_arm64.deb
# RUN wget -O /tmp/libtinyxml.deb http://ftp.us.debian.org/debian/pool/main/t/tinyxml/libtinyxml2.6.2v5_2.6.2-4_arm64.deb
# RUN mkdir /tmp/tinyxml
# RUN dpkg-deb -R /tmp/lib2-4_arm64.deb /downloads/
# RUN /install-deb.sh /deps/libtinyxml-dev_2.6.2-4_arm64.deb
# RUN wget -O /tmp/libtinyxml-dev.deb http://ftp.us.debian.org/debian/pool/main/t/tinyxml/libtinyxml-dev_2.6.2-4_arm64.deb
# RUN mkdir /tmp/tinyxml-dev
# RUN dpkg-deb -R /tmp/libtinyxml-dev.deb /tmp/tinyxml-dev
# RUN rsync -ah /tmp/tinyxml-dev/usr/ /usr/aarch64-linux-gnu


# Build and install console_bridge
# ADD https://github.com/ros/console_bridge/archive/0.3.2.tar.gz /downloads/console_bridge.tar.gz
# ADD deps/0.3.2.tar.gz /tmp/console_bridge-0.3.2
# RUN wget -O /tmp/console_bridge.tar.gz https://github.com/ros/console_bridge/archive/0.3.2.tar.gz
ADD ./make-console_bridge.sh /make-console_bridge.sh
RUN /make-console_bridge.sh
# ADD ./deps/0.3.2.tar.gz /tmp/
# RUN tar -xf /tmp/0.3.2.tar.gz -C /tmp
# RUN cd /tmp/console_bridge-0.3.2 && cmake . -DCMAKE_TOOLCHAIN_FILE=/toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/aarch64-linux-gnu/
# RUN cd /tmp/console_bridge-0.3.2 && cmake . -DCMAKE_TOOLCHAIN_FILE=/toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${SYSROOT}/usr
# RUN cd /tmp/console_bridge-0.3.2 && make
# RUN cd /tmp/console_bridge-0.3.2 && make install


# Install zlib1g from deb
# ADD deps/liblz4-1_0.0~r131-2+b1_arm64.deb /downloads/
# ADD ./deps/liblz4-1_0.0~r131-2+b1_arm64.deb /tmp/
# RUN /install-deb.sh /tmp/liblz4-1_0.0~r131-2+b1_arm64.deb
# RUN wget -O /tmp/liblz4.deb http://ftp.us.debian.org/debian/pool/main/l/lz4/liblz4-1_0.0~r131-2+b1_arm64.deb
# RUN mkdir /tmp/liblz4
# RUN dpkg-deb -R /tmp/liblz4.deb /tmp/liblz4
# RUN rsync -ah /tmp/liblz4/usr/ /usr/aarch64-linux-gnu

ADD ./make-lz4.sh /make-lz4.sh
RUN /make-lz4.sh
# ADD deps/liblz4-dev_0.0~r131-2+b1_arm64.deb /downloads/
# ADD ./deps/liblz4-dev_0.0~r131-2+b1_arm64.deb /tmp/
# RUN /install-deb.sh /tmp/liblz4-dev_0.0~r131-2+b1_arm64.deb
# RUN wget -O /tmp/liblz4-dev.deb http://ftp.us.debian.org/debian/pool/main/l/lz4/liblz4-dev_0.0~r131-2+b1_arm64.deb
# RUN mkdir /tmp/liblz4-dev
# RUN dpkg-deb -R /tmp/liblz4-dev.deb /tmp/liblz4-dev
# RUN rsync -ah /tmp/liblz4-dev/usr/ /usr/aarch64-linux-gnu

# Install googletest - required for tf2
# RUN wget -O /tmp/google-test.tar.gz https://github.com/google/googletest/archive/release-1.8.0.tar.gz
# RUN mkdir /tmp/google-test
# RUN tar -xf /tmp/google-test.tar.gz -C /tmp/google-test
# RUN cd /tmp/google-test/googletest-release-1.8.0; cmake -DCMAKE_INSTALL_PREFIX=/usr/arm-linux-gnueabihf -DBUILD_SHARED_LIBS=ON -DCMAKE_TOOLCHAIN_FILE=/toolchain.cmake .
# RUN cd /tmp/google-test/googletest-release-1.8.0; make -j4
# RUN cd /tmp/google-test/googletest-release-1.8.0; make install

# ADD fix-links2.sh /fix-links.sh
# RUN /fix-links.sh
# Install OpenCV4Tegra
# ADD deps/libopencv4tegra-repo_2.4.12.3_armhf_l4t-r23.deb /downloads/
# RUN wget -O /tmp/libopencv4tegra.deb http://developer.download.nvidia.com/embedded/L4T/r23_Release_v1.0/libopencv4tegra-repo_2.4.12.3_armhf_l4t-r23.deb
# ADD ./deps/libopencv4tegra-repo_2.4.12.3_armhf_l4t-r23.deb /tmp/
# RUN dpkg-deb -R /deps/libopencv4tegra-repo_2.4.12.3_armhf_l4t-r23.deb /tmp/libopencv4tegra

# RUN /install-deb.sh -f /tmp/libopencv4tegra/var/opencv4tegra-repo/libopencv4tegra_2.4.12.3_arm64.deb
# RUN dpkg-deb -R /tmp/libopencv4tegra/var/opencv4tegra-repo/libopencv4tegra_2.4.12.3_arm64.deb /tmp/libopencv
# RUN rsync -ah /tmp/libopencv/usr/ /usr/aarch64-linux-gnu/

# RUN /install-deb.sh -f /tmp/libopencv4tegra/var/opencv4tegra-repo/libopencv4tegra-dev_2.4.12.3_arm64.deb
# RUN dpkg-deb -R /tmp/libopencv4tegra/var/opencv4tegra-repo/libopencv4tegra-dev_2.4.12.3_arm64.deb /tmp/libopencv-dev
# RUN rsync -ah /tmp/libopencv-dev/usr/ /usr/aarch64-linux-gnu

# RUN /install-deb.sh -f /tmp/libopencv4tegra/var/opencv4tegra-repo/libopencv4tegra-python_2.4.12.3_arm64.deb
# RUN dpkg-deb -R /tmp/libopencv4tegra/var/opencv4tegra-repo/libopencv4tegra-python_2.4.12.3_arm64.deb /tmp/libopencv-python
# RUN rsync -ah /tmp/libopencv-python/usr/ /usr/aarch64-linux-gnu


ADD make-poco.sh /make-poco.sh
RUN /make-poco.sh
# RUN wget -O /tmp/poco.tar.gz https://pocoproject.org/releases/poco-1.7.8/poco-1.7.8p3.tar.gz
# RUN tar -xf /deps/poco-1.7.8p3.tar.gz -C /tmp
# RUN cd /tmp/poco-1.7.8p3; ./configure --prefix=/usr/arm-linux-gnueabihf --no-tests --no-samples --omit=Data/MySQL,Data/ODBC --include-path=/usr/arm-linux-gnueabihf/include --library-path=/usr/arm-linux-gnueabihf/lib; 
# RUN cd /tmp/poco-1.7.8p3; make -j4 CC=/usr/bin/arm-linux-gnueabihf-gcc CXX=/usr/bin/arm-linux-gnueabihf-g++ STRIP=/usr/bin/arm-linux-gnueabihf-strip
# RUN cd /tmp/poco-1.7.8p3; make install



ADD install-cuda.sh /install-cuda.sh
RUN /install-cuda.sh

# Install cuda 7 toolkit
# RUN wget -O /tmp/cuda-repo-ubuntu1404_7.0-28_amd64.deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/cuda-repo-ubuntu1404_7.0-28_amd64.deb
# RUN dpkg -i /tmp/cuda-repo-ubuntu1404_7.0-28_amd64.deb
# Install cuda 8 toolkit
# RUN wget -O /tmp/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
# RUN dpkg -i /tmp/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
# Force a correct finish
# RUN apt update; true

# Install cuda 7
# RUN apt install -y cuda-minimal-build-7-0:amd64 cuda-cublas-cross-aarch64-7-0:arm64 cuda-cudart-cross-aarch64-7-0:arm64 cuda-cufft-cross-aarch64-7-0:arm64 cuda-curand-cross-aarch64-7-0:arm64 cuda-cusolver-cross-aarch64-7-0:arm64 cuda-cusparse-cross-aarch64-7-0:arm64 cuda-driver-cross-aarch64-7-0:arm64 cuda-misc-headers-cross-aarch64-7-0:arm64 cuda-npp-cross-aarch64-7-0:arm64 cuda-nvrtc-cross-aarch64-7-0:arm64

# Install cuda 8
# RUN apt install -y cuda-minimal-build-8-0:amd64 cuda-cublas-cross-aarch64-8-0:arm64 cuda-cudart-cross-aarch64-8-0:arm64 cuda-cufft-cross-aarch64-8-0:arm64 cuda-curand-cross-aarch64-8-0:arm64 cuda-cusolver-cross-aarch64-8-0:arm64 cuda-cusparse-cross-aarch64-8-0:arm64 cuda-driver-cross-aarch64-8-0:arm64 cuda-misc-headers-cross-aarch64-8-0:arm64 cuda-npp-cross-aarch64-8-0:arm64 cuda-nvrtc-cross-aarch64-8-0:arm64
# RUN cd /usr/local; ln -s ./cuda-7.0 ./cuda
# RUN echo 'export PATH=/usr/local/cuda/bin:$PATH' >> /root/.bashrc
# RUN echo 'export LD_LIBRARY_PATH=/usr/arm-linux-gnueabihf/lib' >> /root/.bashrc

# RUN apt install 
# RUN apt-get install -y 'libxcb.*' libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev libinput* mtdev* mesa-utils mesa-utils-extra libgles2-mesa-dev libinput10 apt-get install opengles2-mesa-dev
# RUN apt-get install -y libgles2-mesa-dev "^libxcb.*" libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev libinput* mtdev*

# Setup sysroot
# RUN wget --quiet https://download.qt.io/archive/qt/5.9/5.9.0/single/qt-everywhere-opensource-src-5.9.0.tar.xz -O /tmp/qt-everywhere-opensource-src-5.9.0.tar.xz && tar -xf /tmp/qt-everywhere-opensource-src-5.9.0.tar.xz -C /tmp

# RUN dpkg --root $SYSROOT --add-architecture armhf
# RUN dpkg --root $SYSROOT --add-architecture arm64
# RUN apt-get update; true
# RUN dpkg -i --root $SYSROOT <package>



# ADD get-rootfs.sh /get-rootfs.sh
# RUN /get-rootfs.sh


ADD sources.list /etc/apt/sources.list
RUN apt-get update


RUN apt-get install pkg-config
ENV PKG_CONFIG_DIR=
ENV PKG_CONFIG_LIBDIR=${SYSROOT}/usr/lib/pkgconfig:${SYSROOT}/usr/share/pkgconfig
ENV PKG_CONFIG_SYSROOT_DIR=${SYSROOT}
# ADD jhbuildrc /root/.jhbuildrc
# ADD make-xorg.sh /make-xorg.sh
# RUN /make-xorg.sh
ADD libtool.patch /libtool.patch
ADD make-opengles-deps.sh /make-opengles-deps.sh
RUN /make-opengles-deps.sh
ADD make-drivers.sh /make-drivers.sh
RUN /make-drivers.sh
ADD make-opengles.sh /make-opengles.sh
RUN /make-opengles.sh
# QT Requires ssl 1.0
# RUN rm $SYSROOT/lib/libssl.so $SYSROOT/lib/libssl.so.1.1 $SYSROOT/lib/libssl.a

ADD make-qt5.sh /make-qt5.sh
RUN /make-qt5.sh

ADD make-libpng.sh /make-libpng.sh
RUN /make-libpng.sh




ADD make-numpy.sh /make-numpy.sh
RUN /make-numpy.sh

ADD make-ogg.sh /make-ogg.sh
RUN /make-ogg.sh

# Build and install ROS
RUN rosdep init
RUN rosdep update
# RUN mkdir /ros_catkin_ws
# List dependencies here
# RUN cd /ros_catkin_ws && rosinstall_generator ros_comm sensor_msgs geometry_msgs nav_msgs mavros_msgs visualization_msgs tf2 catkin --rosdistro kinetic --deps --wet-only --tar > kinetic-ros_comm-wet.rosinstall
# RUN cd /ros_catkin_ws && wstool init -j4 src kinetic-ros_comm-wet.rosinstall
RUN mkdir /ros_catkin_ws && cd /ros_catkin_ws && rosinstall_generator catkin --rosdistro kinetic --deps --wet-only --tar > kinetic-catkin-wet.rosinstall && wstool init -j$(nproc) /ros_catkin_ws/src kinetic-catkin-wet.rosinstall

# ADD libpthread.so $SYSROOT/usr/lib/aarch64-linux-gnu/libpthread.so

# ENV LD_LIBRARY_PATH=$SYSROOT/lib/aarch64-linux-gnu/
# RUN echo $LD_LIBRARY_PATH

# RUN cd /ros_catkin_ws && ./src/catkin/bin/catkin_make_isolated --install --install-space /opt/ros/kinetic -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=/toolchain.cmake -DCATKIN_ENABLE_TESTING=OFF -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON

# ADD make-ros.sh /make-ros.sh
# RUN /make-ros.sh

# Source ROS setup files
RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc


# ADD make-opencv3.sh /make-opencv3.sh
# RUN /make-opencv3.sh

ADD make-libtheora.sh /make-libtheora.sh
RUN /make-libtheora.sh

ADD install-ros-cv-bridge.sh /install-ros-cv-bridge.sh
RUN /install-ros-cv-bridge.sh
# Install cv_bridge headers to ros workspace
# RUN mkdir -p /ros_vision_ws/src
# RUN git clone -b kinetic https://github.com/ros-perception/vision_opencv.git /ros_vision_ws/src/vision_opencv
# RUN sed -i 's/OpenCV 3/OpenCV 2/g' /ros_vision_ws/src/vision_opencv/cv_bridge/CMakeLists.txt
# RUN sed -i 's/opencv_imgcodecs//g' /ros_vision_ws/src/vision_opencv/cv_bridge/CMakeLists.txt
# RUN sed -i 's/opencv3/opencv2/g' /ros_vision_ws/src/vision_opencv/cv_bridge/package.xml

# RUN wget -O /tmp/python-numpy.deb http://ftp.us.debian.org/debian/pool/main/p/python-numpy/python-numpy_1.12.1-3_arm64.deb
# RUN dpkg-deb -R /tmp/python-numpy.deb /tmp/python-numpy
# RUN rsync -ah /tmp/python-numpy/usr/ /usr/aarch64-linux-gnu
# RUN apt install -y python-numpy
# ENV PATH=/usr/local/cuda/bin:$PATH
# ENV CUDA_BIN_PATH=/usr/local/cuda
# RUN cd /ros_vision_ws; bash -c "source /opt/ros/kinetic/setup.bash; source /root/.bashrc; env; CUDA_TOOLKIT_ROOT=/usr/local/cuda catkin_make -DCMAKE_TOOLCHAIN_FILE=/toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DCATKIN_ENABLE_TESTING=OFF"

# Install opencv3
# RUN /install-deb.sh http://packages.ros.org/ros/ubuntu/pool/main/r/ros-kinetic-opencv3/ros-kinetic-opencv3_3.2.0-4xenial-20170607-102606-0800_arm64.deb
# RUN wget -O /tmp/ros-kinetic-opencv3.deb http://packages.ros.org/ros/ubuntu/pool/main/r/ros-kinetic-opencv3/ros-kinetic-opencv3_3.2.0-4xenial-20170607-102606-0800_arm64.deb
# RUN dpkg-deb -R /tmp/ros-kinetic-opencv3.deb /tmp/ros-kinetic-opencv3
# RUN rsync -ah /tmp/ros-kinetic-opencv3/usr/ /usr/aarch64-linux-gnu/
# RUN rsync -ah /tmp/ros-kinetic-opencv3/opt/ /opt/

# RUN /install-deb.sh http://packages.ros.org/ros/ubuntu/pool/main/r/ros-kinetic-cv-bridge/ros-kinetic-cv-bridge_1.12.4-0xenial-20170614-095040-0800_arm64.deb
# RUN wget -O /tmp/ros-kinetic-cv-bridge.deb http://packages.ros.org/ros/ubuntu/pool/main/r/ros-kinetic-cv-bridge/ros-kinetic-cv-bridge_1.12.4-0xenial-20170614-095040-0800_arm64.deb
# RUN dpkg-deb -R /tmp/ros-kinetic-cv-bridge.deb /tmp/ros-kinetic-cv-bridge
# RUN rsync -ah /tmp/ros-kinetic-cv-bridge/usr/ /usr/aarch64-linux-gnu/
# RUN rsync -ah /tmp/ros-kinetic-cv-bridge/opt/ /opt/

# RUN /install-deb.sh http://packages.ros.org/ros/ubuntu/pool/main/r/ros-kinetic-image-transport/ros-kinetic-image-transport_1.11.12-0xenial-20170614-102736-0800_arm64.deb
# RUN wget -O /tmp/ros-kinetic-image-transport.deb http://packages.ros.org/ros/ubuntu/pool/main/r/ros-kinetic-image-transport/ros-kinetic-image-transport_1.11.12-0xenial-20170614-102736-0800_arm64.deb
# RUN dpkg-deb -R /tmp/ros-kinetic-image-transport.deb /tmp/ros-kinetic-image-transport
# RUN rsync -ah /tmp/ros-kinetic-image-transport/usr/ /usr/aarch64-linux-gnu/
# RUN rsync -ah /tmp/ros-kinetic-image-transport/opt/ /opt/

# RUN /install-deb.sh http://packages.ros.org/ros/ubuntu/pool/main/r/ros-kinetic-image-transport-plugins/ros-kinetic-image-transport-plugins_1.9.5-0xenial-20170614-232943-0800_arm64.deb
# RUN wget -O /tmp/ros-kinetic-image-transport-plugins.deb http://packages.ros.org/ros/ubuntu/pool/main/r/ros-kinetic-image-transport-plugins/ros-kinetic-image-transport-plugins_1.9.5-0xenial-20170614-232943-0800_arm64.deb
# RUN dpkg-deb -R /tmp/ros-kinetic-image-transport-plugins.deb /tmp/ros-kinetic-image-transport-plugins
# RUN rsync -ah /tmp/ros-kinetic-image-transport-plugins/usr/ /usr/aarch64-linux-gnu/
# RUN rsync -ah /tmp/ros-kinetic-image-transport-plugins/opt/ /opt/


# RUN /install-deb.sh http://packages.ros.org/ros/ubuntu/pool/main/r/ros-kinetic-pluginlib/ros-kinetic-pluginlib_1.10.5-0xenial-20170614-053649-0800_arm64.deb
# RUN wget -O /tmp/ros-kinetic-pluginlib.deb http://packages.ros.org/ros/ubuntu/pool/main/r/ros-kinetic-pluginlib/ros-kinetic-pluginlib_1.10.5-0xenial-20170614-053649-0800_arm64.deb
# RUN dpkg-deb -R /tmp/ros-kinetic-pluginlib.deb /tmp/ros-kinetic-pluginlib
# RUN rsync -ah /tmp/ros-kinetic-pluginlib/usr/ /usr/aarch64-linux-gnu/
# RUN rsync -ah /tmp/ros-kinetic-pluginlib/opt/ /opt/


# RUN /install-deb.sh http://packages.ros.org/ros/ubuntu/pool/main/r/ros-kinetic-class-loader/ros-kinetic-class-loader_0.3.6-0xenial-20170227-212536-0800_arm64.deb
# RUN wget -O /tmp/ros-kinetic-class-loader.deb http://packages.ros.org/ros/ubuntu/pool/main/r/ros-kinetic-class-loader/ros-kinetic-class-loader_0.3.6-0xenial-20170227-212536-0800_arm64.deb
# RUN dpkg-deb -R /tmp/ros-kinetic-class-loader.deb /tmp/ros-kinetic-class-loader
# RUN rsync -ah /tmp/ros-kinetic-class-loader/usr/ /usr/aarch64-linux-gnu/
# RUN rsync -ah /tmp/ros-kinetic-class-loader/opt/ /opt/

# RUN mkdir /ros_catkin_ws2
# RUN cd /ros_catkin_ws2 && rosinstall_generator cv_bridge image_transport --rosdistro kinetic --deps --wet-only --tar > kinetic-ros_comm-wet.rosinstall
# RUN cd /ros_catkin_ws2 && wstool init -j4 src kinetic-ros_comm-wet.rosinstall
# RUN cd /ros_catkin_ws2 && ./src/catkin/bin/catkin_make_isolated --install --install-space /opt/ros/kinetic -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=/toolchain.cmake -DCATKIN_ENABLE_TESTING=OFF

# Fudge up some paths for our setup
# RUN cd /opt/ros/kinetic; grep -RIl /usr/lib/arm-linux-gnueabihf . | xargs sed -i 's/\/usr\/lib\/arm-linux-gnueabihf/\/usr\/arm-linux-gnueabihf\/lib/g'
# RUN cd /opt/ros/kinetic; grep -RIl /usr/arm-linux-gnueabihf/lib/libtinyxml.so . | xargs sed -i 's/\/usr\/arm-linux-gnueabihf\/lib\/libtinyxml.so/\/usr\/arm-linux-gnueabihf\/lib\/arm-linux-gnueabihf\/libtinyxml.so/g'
# RUN cd /opt/ros/kinetic; grep -RIl /usr/lib . | xargs sed -i 's/\/usr\/lib/\/usr\/arm-linux-gnueabihf\/lib/g'

# RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc
WORKDIR /catkin_ws
VOLUME ["/catkin_ws"]
CMD ["bash", "-i", "-c", "catkin_make -j4 -DCMAKE_TOOLCHAIN_FILE=/toolchain.cmake -DCMAKE_BUILD_TYPE=Release"]
