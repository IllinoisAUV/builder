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

RUN mkdir /sysroot
RUN wget https://developer.nvidia.com/embedded/dlc/l4t-sample-root-filesystem-28-2 -O /tmp/sysroot.tar.bz2 && tar -xf /tmp/sysroot.tar.bz2 -C /sysroot


RUN dpkg --add-architecture arm64
ADD arm64-sources.list /etc/apt/sources.list.d/arm64.list
RUN sed -i 's/deb /deb [arch=amd64] /g' /etc/apt/sources.list && sed -i 's/deb-src /deb-src [arch=amd64] /g' /etc/apt/sources.list

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

RUN apt-get update

RUN apt-get install -y gawk bison flex texinfo build-essential

RUN mkdir /opt/gcc/

ENV SYSROOT=/sysroot


ADD make-make.sh /make-make.sh
RUN /make-make.sh

RUN mkdir -p /cross
RUN mv /sysroot /cross
ENV INSTALL_PATH=/cross

ADD make-aarch64-toolchain.sh /tmp/make-aarch64-toolchain.sh
ADD make-gcc.sh /make-gcc.sh
RUN /make-gcc.sh
ENV PATH=/opt/gcc/install/bin:$PATH
ENV TRIPLET=aarch64-linux-gnu
ENV CROSS_COMPILE=${TRIPLET}-

RUN apt-get install -y python-catkin-tools
ADD toolchain.cmake /toolchain.cmake

RUN echo "source $SYSROOT/opt/ros/kinetic/setup.bash" >> /.bashrc

RUN apt-get install -y apt-rdepends
RUN apt-get install -y python
RUN apt-get install -y python-apt
ADD get-debs.py /get-debs.py
RUN /get-debs.py ros-kinetic-desktop-full > /tmp/packages-all
RUN cd /tmp && cat /tmp/packages-all | xargs apt-get download
RUN ls /tmp/*.deb | xargs --max-procs $(nproc) -I pkg -n1 dpkg-deb -x pkg /sysroot

RUN /get-debs.py ros-kinetic-mavros > /tmp/packages-mavros
# comm -13 <(sort file1) <(sort file2) returns all of the lines in file2 not in file1
RUN mkdir -p /tmp/mavros && cd /tmp/mavros && comm -13 <(sort /tmp/packages-all) <(sort /tmp/packages-mavros) | xargs apt-get download
RUN ls /tmp/*.deb | xargs --max-procs $(nproc) -I pkg -n1 dpkg-deb -x pkg /sysroot
RUN cat /tmp/packages-all /tmp/packages-mavros | uniq > /tmp/packages-all

WORKDIR /catkin_ws
VOLUME ["/catkin_ws"]
CMD ["bash", "-i", "-c", "catkin_make -j$(nproc) -DCMAKE_TOOLCHAIN_FILE=/toolchain.cmake -DCMAKE_BUILD_TYPE=Release"]
