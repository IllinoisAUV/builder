FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
    wget \
    bzip2

# RUN apt-get update && apt-get install -y
#     python-rosdep \
#     python-rosinstall \
#     python-rosinstall-generator \
#     python-wstool \
#     build-essential \
#     python-empy
# RUN apt-get install -y wget \
#     git \
#     cmake

# RUN apt-get install -y wget zip


ENV SYSROOT=/cross/sysroot
RUN mkdir -p $SYSROOT
# ADD fetch-sysroot.sh /fetch-sysroot.sh
# RUN /fetch-sysroot.sh


RUN dpkg --add-architecture arm64
ADD arm64-sources.list /etc/apt/sources.list.d/arm64.list
RUN sed -i 's/deb /deb [arch=amd64] /g' /etc/apt/sources.list && sed -i 's/deb-src /deb-src [arch=amd64] /g' /etc/apt/sources.list

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

RUN apt-get update

RUN apt-get install -y gawk bison flex texinfo build-essential

ADD make-make.sh /make-make.sh
RUN /make-make.sh

ENV INSTALL_PATH=/cross

# ADD make-aarch64-toolchain.sh /tmp/make-aarch64-toolchain.sh
# ADD make-gcc.sh /make-gcc.sh
# RUN /make-gcc.sh
# ENV PATH=/opt/gcc/install/bin:$PATH
ENV TRIPLET=aarch64-linux-gnu
ENV CROSS_COMPILE=${TRIPLET}-

RUN apt-get install -y python-catkin-tools

RUN echo "source $SYSROOT/opt/ros/kinetic/setup.bash" >> /.bashrc

RUN apt-get install -y apt-rdepends
RUN apt-get install -y python
RUN apt-get install -y python-apt
ADD get-debs.py /get-debs.py
RUN /get-debs.py ros-kinetic-desktop-full > /tmp/packages-all
RUN cd /tmp && cat /tmp/packages-all | xargs apt-get download
RUN ls /tmp/*.deb | xargs --max-procs $(nproc) -I pkg -n1 dpkg-deb -x pkg $SYSROOT && rm /tmp/*.deb

RUN /get-debs.py ros-kinetic-mavros > /tmp/packages-mavros
# comm -13 <(sort file1) <(sort file2) returns all of the lines in file2 not in file1
RUN bash -c "cd /tmp/ && comm -13 <(sort /tmp/packages-all) <(sort /tmp/packages-mavros) | xargs apt-get download"
RUN ls /tmp/*.deb | xargs --max-procs $(nproc) -I pkg -n1 dpkg-deb -x pkg $SYSROOT && rm /tmp/*.deb
RUN cat /tmp/packages-all /tmp/packages-mavros | uniq > /tmp/packages-all

RUN apt-get install -y cmake
ENV PATH=/cross/bin:$PATH
RUN apt-get install -y ros-kinetic-ros-base
ADD toolchain.cmake /toolchain.cmake

# Some ROS packages specify required include directories in way that a sysroot 
# doesn't help. To get around this, I'm just installing the package on the host
# to get the header files
# RUN apt-get install -y libeigen3-dev
# RUN apt-get install -y ros-kinetic-cv-bridge
# RUN sed -i -e '105d;,117d' /cross/sysroot/opt/ros/kinetic/share/mavros/cmake/mavrosConfig.cmake
# ADD mavrosConfig.cmake.patch /mavrosConfig.cmake.patch
# RUN cd $SYSROOT/opt/ros/kinetic/share/mavros/cmake/ && patch < /mavrosConfig.cmake.patch

# ADD eigen_conversionsConfig.cmake.patch /eigen_conversionsConfig.cmake.patch
# RUN cd /cross/sysroot/opt/ros/kinetic/share/eigen_conversions/cmake/ && patch < /eigen_conversionsConfig.cmake.patch

# ADD cv_bridgeConfig.cmake.patch /cv_bridgeConfig.cmake.patch
# RUN cd /cross/sysroot/opt/ros/kinetic/share/cv_bridge/cmake/ && patch < /cv_bridgeConfig.cmake.patch

# ADD geometry_msgsConfig.cmake.patch /geometry_msgsConfig.cmake.patch
# RUN cd /cross/sysroot/opt/ros/kinetic/share/geometry_msgs/cmake/ && patch < /geometry_msgsConfig.cmake.patch


RUN find /cross/sysroot/opt/ros/kinetic/share/ -name "*Config.cmake" | xargs sed -i 's/set(include \${idir})/set(include \$ENV{SYSROOT}\${idir})/g'

RUN find /cross/sysroot/opt/ros/kinetic/share/ -name "*Config.cmake" | xargs sed -i 's/IS_DIRECTORY \${idir}/IS_DIRECTORY \$ENV{SYSROOT}\${idir}/g'



ADD fix-links.sh /fix-links.sh
RUN /fix-links.sh

RUN find /cross/sysroot/opt/ros/kinetic/share/ -name "*Config.cmake" | xargs sed -i 's/foreach(path \/opt\/ros\/kinetic\/lib;\/opt\/ros\/kinetic\/lib)/foreach(path $ENV{SYSROOT}\/opt\/ros\/kinetic\/lib;$ENV{SYSROOT}\/opt\/ros\/kinetic\/lib)/g'

RUN find /cross/sysroot/opt/ros/kinetic/share/ -name "*Config.cmake" | xargs sed -i '/elseif(IS_ABSOLUTE \${library})/{ N; s/elseif(IS_ABSOLUTE \${library})\n\(.*\)list(APPEND \(.*\)_LIBRARIES ${library})/elseif(IS_ABSOLUTE \${library})\n\1list(APPEND \2_LIBRARIES $ENV{SYSROOT}${library})/ }'

RUN apt-get install -y gcc-aarch64-linux-gnu g++-aarch64-linux-gnu

RUN cd $SYSROOT/usr/lib/aarch64-linux-gnu && ln -s mesa/libGL.so.1 .


WORKDIR /catkin_ws
VOLUME ["/catkin_ws"]
CMD ["bash", "-i", "-c", "rm -rf /catkin_ws/devel /catkin_ws/build && catkin_make -j1 -DCMAKE_TOOLCHAIN_FILE=/toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON"]
