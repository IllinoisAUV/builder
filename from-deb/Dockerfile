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
RUN apt-get install -y apt-rdepends
RUN apt-get install -y python
RUN apt-get install -y python-apt
ADD get-debs.py /get-debs.py
RUN /get-debs.py ros-kinetic-desktop-full > /tmp/packages
RUN cd /tmp && cat /tmp/packages | xargs apt-get download
RUN ls /tmp/*.deb | xargs --max-procs $(nproc) -I pkg -n1 dpkg-deb -x pkg /sysroot

# ADD get-debs.sh /get-debs.sh
# RUN /get-debs.sh

# RUN apt-get download $(apt-rdepends ros-kinetic-desktop-full:arm64 | grep -v "^ ") /tmp

# Source ROS setup files
# RUN echo "source /opt/ros/kinetic/setup.bash" >> /.bashrc

WORKDIR /catkin_ws
VOLUME ["/catkin_ws"]
CMD ["bash", "-i", "-c", "catkin_make -j4 -DCMAKE_TOOLCHAIN_FILE=/toolchain.cmake -DCMAKE_BUILD_TYPE=Release"]
