# OpenCV编译cmake参数记录

### 静态 ----

```shell
cmake .. \
-D WITH_GTK=OFF \
-D CMAKE_BUILD_TYPE=RELEASE \
-D BUILD_SHARED_LIBS=OFF \
-D BUILD_JAVA=OFF \
-D BUILD_PYTHON=OFF \
-D BUILD_TESTS=OFF \
-D BUILD_opencv_world=ON \
-D CMAKE_INSTALL_PREFIX=install
```

### 动态 ----

```shell
cmake .. \
-D WITH_GTK=OFF \
-D CMAKE_BUILD_TYPE=RELEASE \
-D BUILD_SHARED_LIBS=ON \
-D BUILD_JAVA=OFF \
-D BUILD_PYTHON=OFF \
-D BUILD_TESTS=OFF \
-D BUILD_opencv_world=ON \
-D WITH_JASPER=OFF \
-D WITH_OPENEXR=OFF \
-D WITH_PROTOBUF=OFF \
-D BUILD_opencv_calib3d=OFF \
-D CMAKE_INSTALL_PREFIX=install
```

### 动态-精简 ----

```shell
cmake .. \
-D WITH_GTK=OFF \
-D CMAKE_BUILD_TYPE=RELEASE \
-D BUILD_SHARED_LIBS=ON \
-D BUILD_TESTS=OFF \
-D BUILD_opencv_world=ON \
-D WITH_JASPER=OFF \
-D WITH_OPENEXR=OFF \
-D WITH_PROTOBUF=OFF \
-D BUILD_opencv_calib3d=OFF \
-D BUILD_opencv_dnn=OFF \
-D BUILD_opencv_objdetect=OFF \
-D BUILD_opencv_python=OFF \
-D BUILD_opencv_java=OFF \
-D BUILD_opencv_apps=OFF \
-D BUILD_IPP_IW=OFF \
-D BUILD_opencv_ts=OFF \
-D CMAKE_INSTALL_PREFIX=install
```

