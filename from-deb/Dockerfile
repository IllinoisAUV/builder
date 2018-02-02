FROM ubuntu:16.04

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

RUN apt-get install -y wget zip

RUN mkdir /sysroot
RUN wget https://developer.nvidia.com/embedded/dlc/l4t-sample-root-filesystem-28-2 -O /tmp/sysroot.tar.bz2 && tar -xf /tmp/sysroot.tar.bz2 -C /sysroot


RUN dpkg --add-architecture arm64
ADD arm64-sources.list /etc/apt/sources.list.d/arm64.list
RUN sed -i 's/deb /deb [arch=amd64] /g' /etc/apt/sources.list && sed -i 's/deb-src /deb-src [arch=amd64] /g' /etc/apt/sources.list

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

RUN apt-get update
RUN apt-get install -y apt-rdepends

RUN apt-get download $(apt-rdepends ros-kinetic-desktop-full:arm64 | grep -v "^ ") /tmp

# RUN apt-get install -y gawk bison flex texinfo

# RUN mkdir /opt/gcc/
# 
# ADD make-make.sh /make-make.sh
# RUN /make-make.sh
# ADD make-aarch64-toolchain.sh /tmp/make-aarch64-toolchain.sh
# ADD make-gcc.sh /make-gcc.sh
# RUN /make-gcc.sh
# ENV PATH=/opt/gcc/install/bin:$PATH
# ENV SYSROOT=/opt/gcc/install/aarch64-linux-gnu/sysroot
# ENV TRIPLET=aarch64-linux-gnu
# ENV CROSS_COMPILE=${TRIPLET}-

ADD make-zlib.sh /make-zlib.sh
RUN /make-zlib.sh

# Cross compiling cmake toolchain
ADD toolchain.cmake /toolchain.cmake

ADD make-openssl.sh /make-openssl.sh
RUN /make-openssl.sh

ADD make-sqlite.sh /make-sqlite.sh
RUN /make-sqlite.sh

ADD make-expat.sh /make-expat.sh
RUN /make-expat.sh

ADD make-python.sh /make-python.sh
RUN /make-python.sh

ADD make-bzip2.sh /make-bzip2.sh
RUN /make-bzip2.sh

ADD ./make-boost.sh /make-boost.sh
ADD user-config.jam /root/user-config.jam
RUN /make-boost.sh

ADD make-tinyxml.sh /make-tinyxml.sh
ADD enforce-use-stl.patch /enforce-use-stl.patch
RUN /make-tinyxml.sh

ADD ./make-console_bridge.sh /make-console_bridge.sh
RUN /make-console_bridge.sh

ADD ./make-lz4.sh /make-lz4.sh
RUN /make-lz4.sh

ADD make-poco.sh /make-poco.sh
RUN /make-poco.sh

ADD install-cuda.sh /install-cuda.sh
RUN /install-cuda.sh


ADD sources.list /etc/apt/sources.list
RUN apt-get update


RUN apt-get install pkg-config
ENV PKG_CONFIG_DIR=
ENV PKG_CONFIG_LIBDIR=${SYSROOT}/usr/lib/pkgconfig:${SYSROOT}/usr/share/pkgconfig
ENV PKG_CONFIG_SYSROOT_DIR=${SYSROOT}

ADD libtool.patch /libtool.patch
ADD make-opengles-deps.sh /make-opengles-deps.sh
RUN /make-opengles-deps.sh
ADD make-drivers.sh /make-drivers.sh
RUN /make-drivers.sh
ADD make-opengles.sh /make-opengles.sh
RUN /make-opengles.sh

ADD make-qt5.sh /make-qt5.sh
RUN /make-qt5.sh

ADD make-libpng.sh /make-libpng.sh
RUN /make-libpng.sh

ADD make-numpy.sh /make-numpy.sh
RUN /make-numpy.sh

ADD make-ogg.sh /make-ogg.sh
RUN /make-ogg.sh

ADD make-libtheora.sh /make-libtheora.sh
RUN /make-libtheora.sh

ADD make-tinyxml2.sh /make-tinyxml2.sh
RUN /make-tinyxml2.sh

RUN apt-get update
RUN apt-get install -y python-pip
ENV PYTHONPATH=$PYTHONPATH:/usr/lib/python2.7

ADD install-eigen3.sh /install-eigen3.sh
RUN /install-eigen3.sh
ADD install-geographiclib.sh /install-geographiclib.sh
RUN /install-geographiclib.sh
RUN pip install future

ADD install-urdfdom_headers.sh /install-urdfdom_headers.sh
RUN /install-urdfdom_headers.sh

ADD install-urdfdom.sh /install-urdfdom.sh
RUN /install-urdfdom.sh

# Build and install ROS
RUN rosdep init
RUN rosdep update

# Create the catkin base workspace
RUN mkdir /ros_catkin_ws && cd /ros_catkin_ws && rosinstall_generator catkin --rosdistro kinetic --deps --wet-only --tar > kinetic-catkin-wet.rosinstall && wstool init -j$(nproc) /ros_catkin_ws/src kinetic-catkin-wet.rosinstall && wstool update -t src && ./src/catkin/bin/catkin_make_isolated -j$(nproc) --merge --install --install-space /opt/ros/kinetic -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=/toolchain.cmake -DCATKIN_ENABLE_TESTING=OFF -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -DCMAKE_LIBRARY_PATH=/usr/local/cuda/lib64/stubs -DWITH_CUDA=OFF

# Source ROS setup files
RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc

# Install ros and necessary packages
ADD install-ros-package.sh /install-ros-package.sh
RUN /install-ros-package.sh cv_bridge image_transport image_transport_plugins
RUN /install-ros-package.sh mavros mavros_extras mavros_msgs 

# Source ROS setup files
RUN echo "source /opt/ros/kinetic/setup.bash" >> /.bashrc

WORKDIR /catkin_ws
VOLUME ["/catkin_ws"]
CMD ["bash", "-i", "-c", "catkin_make -j4 -DCMAKE_TOOLCHAIN_FILE=/toolchain.cmake -DCMAKE_BUILD_TYPE=Release"]
