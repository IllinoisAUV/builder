SET(CMAKE_SYSTEM_NAME Linux)
SET(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR arm)

# specify the cross compiler
SET(CMAKE_C_COMPILER   $ENV{TRIPLET}-gcc)
SET(CMAKE_CXX_COMPILER $ENV{TRIPLET}-g++)

# where is the target environment 
SET(CMAKE_FIND_ROOT_PATH $ENV{SYSROOT} /usr/local/cuda /opt/ros/kinetic /)

# SET(CMAKE_IGNORE_PATH /usr/lib)
# SET(CMAKE_LIBRARY_PATH /usr/aarch64-linux-gnu)

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
# SET(CMAKE_SYSROOT $ENV{SYSROOT})

# SET(PYTHON_LIBRARY $ENV{SYSROOT}/usr/lib/python2.7/config-aarch64-linux-gnu/libpython2.7.so)
# SET(PYTHON_INCLUDE_DIR $ENV{SYSROOT}/usr/include/python2.7)
# SET(PYTHON_EXECUTABLE /usr/bin/python2.7)

# SET(TinyXML_ROOT_DIR $ENV{SYSROOT}/usr)
# SET(TinyXML_INCLUDE_PATH $ENV{SYSROOT}/usr/include)
# SET(TinyXML_LIBRARIES $ENV{SYSROOT}/usr/lib/aarch64-linux-gnu/libtinyxml.so)

# SET(CMAKE_LIBRARY_PATH /usr/arm-linux-gnueabihf /usr/local/cuda /opt/ros/kinetic)
# set(CUDA_TOOLKIT_ROOT "/usr/local/cuda" CACHE STRING "" FORCE)
# SET(CUDA_TOOLKIT_ROOT_DIR "/usr/local/cuda" CACHE STRING "" FORCE)
# SET(CUDA_TOOLKIT_TARGET_DIR "/usr/local/cuda" CACHE STRING "" FORCE)
# SET(CUDA_INCLUDE_DIRS "/usr/local/cuda/targets/armv7-linux-gnueabihf/include" CACHE STRING "" FORCE)
# SET(CUDA_CUDART_LIBRARY "/usr/local/cuda/targets/armv7-linux-gnueabihf/lib/libcudart.so")
# SET(CUDA_HOST_COMPILER "/usr/bin/aarch64-linux-gnu-g++" CACHE STRING "host compiler" FORCE)
# SET(CUDA_64_BIT_DEVICE_CODE ON CACHE BOOL "device code" FORCE)
# SET(CUDA_TARGET_CPU_ARCH "aarch64")
