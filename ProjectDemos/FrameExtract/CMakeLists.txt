CMAKE_MINIMUM_REQUIRED(VERSION 3.20)
PROJECT(FrameExtract)

ADD_EXECUTABLE(FrameExtract main.cpp src/readVideo.cpp)
TARGET_INCLUDE_DIRECTORIES(FrameExtract PRIVATE include)
TARGET_LINK_LIBRARIES(FrameExtract ${PROJECT_SOURCE_DIR}/lib/libopencv_world.so)