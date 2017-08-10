FROM ubuntu:16.04


RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

RUN apt-get update && apt-get install -y \
    ros-kinetic-ros-base \
    ros-kinetic-mavros \ 
    ros-kinetic-mavros-extras \ 
    ros-kinetic-mavros-msgs \
    python-rosinstall \
    python-rosinstall-generator \
    python-wstool \
    build-essential \
    g++-arm-linux-gnueabihf \
    gcc-arm-linux-gnueabihf \
    binutils-arm-linux-gnueabihf

RUN rosdep init
RUN rosdep update

ADD rostoolchain.cmake /opt/ros/kinetic/rostoolchain.cmake

RUN mkdir -p /catkin_ws/src
# Do the initial catkin_make to get setup files
RUN bash -c "source /opt/ros/kinetic/setup.bash; cd catkin_ws; catkin_make"

# Source ROS setup files
RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc
