# Experimental Toolchain for Building

This is an experiment in cross compiling on non-ubuntu hosts targeting the Jetson.


### Usage

Build the builder container (takes a while because it installs ros from scratch)
```sh
$ docker build -t builder .
```

Run the container to build the code
```sh
$ docker run -v $(pwd)/catkin_ws:/catkin_ws -it -u $(id -u $(whoami)) builder
```
