#!/bin/bash
set -ex
# ------------ set path ---------------
CURRENT_DIR=$(cd $(dirname $0); pwd)
YASM_DIR=${CURRENT_DIR}/yasm-1.3.0
FFMPEG_DIR=${CURRENT_DIR}/ffmpeg-4.4.4
OPENCV_DIR=${CURRENT_DIR}/opencv-4.7.0
# ------------ build yasm and install ---------------
 cd ${YASM_DIR}
 ./configure --prefix=${YASM_DIR}/install
 make -j$(nproc) && make install
 export PATH=$PATH:${YASM_DIR}/install/bin
# ------------ build ffmpeg and install ---------------
 cd ${FFMPEG_DIR}
 ./configure --disable-static --enable-shared --prefix=install
 make -j$(nproc) && make install
# ------------ build opencv and install ---------------
cd ${OPENCV_DIR}
# 指定ffmpeg自编译版本
export LD_LIBRARY_PATH=/home/sgt/Third/ffmpeg/lib/:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/home/sgt/Third/ffmpeg/lib/pkgconfig/:$PKG_CONFIG_PATH
export PKG_CONFIG_LIBDIR=/home/sgt/Third/ffmpeg/lib/:$PKG_CONFIG_LIBDIR

rm -rf ./build_demo ./install_demo
mkdir build_demo install_demo && cd build_demo
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
-D CMAKE_INSTALL_PREFIX=${OPENCV_DIR}/install_demo

 make -j$(nproc) && make install