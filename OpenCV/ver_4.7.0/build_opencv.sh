#!/bin/bash
set -ex
# ------------ set opensource path and install path ---------------
CURRENT_DIR=$(cd $(dirname $0); pwd)
YASM_DIR=${CURRENT_DIR}/yasm-1.3.0
FFMPEG_DIR=${CURRENT_DIR}/ffmpeg-5.1.5
OPENCV_DIR=${CURRENT_DIR}/opencv-4.7.0
OPEN_SOURCE_DIR=${CURRENT_DIR}/open_source
if [ ! -d ${OPEN_SOURCE_DIR} ];then
  mkdir ${OPEN_SOURCE_DIR}
fi
# ------------ build yasm and install ---------------
YASM_INSTALL_DIR=${OPEN_SOURCE_DIR}/yasm
if [ -d ${YASM_INSTALL_DIR} ];then
  rm -rf ${YASM_INSTALL_DIR}
fi
mkdir ${YASM_INSTALL_DIR}

cd ${YASM_DIR}
./configure --prefix=${YASM_INSTALL_DIR}
make -j$(nproc) && make install

export PATH=$PATH:${YASM_INSTALL_DIR}/bin
# ------------ build ffmpeg and install ---------------
FFMPEG_INSTALL_DIR=${OPEN_SOURCE_DIR}/ffmpeg
if [ -d ${FFMPEG_INSTALL_DIR} ];then
  rm -rf ${FFMPEG_INSTALL_DIR}
fi
mkdir ${FFMPEG_INSTALL_DIR}

cd ${FFMPEG_DIR}
./configure --disable-static --enable-shared --disable-swresample --prefix=${FFMPEG_INSTALL_DIR}
make -j$(nproc) && make install
# ------------ build opencv and install ---------------
OPENCV_INSTALL_DIR=${OPEN_SOURCE_DIR}/opencv
if [ -d ${OPENCV_INSTALL_DIR} ];then
  rm -rf ${OPENCV_INSTALL_DIR}
fi
mkdir ${OPENCV_INSTALL_DIR}

cd ${OPENCV_DIR}
# 指定ffmpeg自编译版本
export LD_LIBRARY_PATH=${FFMPEG_INSTALL_DIR}/lib/:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=${FFMPEG_INSTALL_DIR}/lib/pkgconfig/:$PKG_CONFIG_PATH
export PKG_CONFIG_LIBDIR=${FFMPEG_INSTALL_DIR}/lib/:$PKG_CONFIG_LIBDIR

rm -rf ./build && mkdir build && cd build
cmake .. \
-D WITH_GTK=OFF \
-D CMAKE_BUILD_TYPE=RELEASE \
-D BUILD_SHARED_LIBS=ON \
-D BUILD_TESTS=OFF \
-D BUILD_opencv_world=ON \
-D WITH_JASPER=OFF \
-D WITH_OPENEXR=OFF \
-D WITH_PROTOBUF=OFF \
-D WITH_ADE=OFF \
-D BUILD_opencv_calib3d=OFF \
-D BUILD_opencv_dnn=OFF \
-D BUILD_opencv_objdetect=OFF \
-D BUILD_opencv_python=OFF \
-D BUILD_opencv_java=OFF \
-D BUILD_opencv_apps=OFF \
-D BUILD_IPP_IW=OFF \
-D BUILD_opencv_ts=OFF \
-D CMAKE_INSTALL_PREFIX=${OPENCV_INSTALL_DIR}

make -j$(nproc) && make install