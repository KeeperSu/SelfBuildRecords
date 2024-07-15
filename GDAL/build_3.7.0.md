# gdal_3.7.0

## Build requirements

一些基础的依赖版本

> CMake >= 3.16
>
> C99 compiler
>
> C++11 compiler
>
> PROJ >= 6.3.1
>
> SWIG >= 4, for building bindings to other programming languages
>
> Python >= 3.8

额外的依赖

> A number of optional libraries are also strongly recommended for most builds: SQLite3, expat, libcurl, zlib, libtiff, libgeotiff, libpng, libjpeg

## 编译流程记录.

> 编译顺序
>
> SQLite3 -> libtiff -> curl -> PROJ

### 1.Build SQLite3

> SQLite3官网：https://www.sqlite.org/download.html
>
> 下载版本：[sqlite-3.46.0](https://www.sqlite.org/2024/sqlite-autoconf-3460000.tar.gz)
>
> ```shell
> SQLITE3_DIR=/home/sgt/Third/open_source/sqlite-3.46.0
> # download
> wget https://www.sqlite.org/2024/sqlite-autoconf-3460000.tar.gz
> # uzip
> tar -zxvf sqlite-autoconf-3460000.tar.gz -C ./sqlite-3.46.0 && cd sqlite-3.46.0
> # build
> ./configure prefix=$SQLITE3_DIR
> make
> make install
> ```
>
> 查看编译安装结果
>
> ```shell
> tree -L 3 ../open_source/sqlite-3.46.0
> ../open_source/sqlite-3.46.0
> ├── bin
> │   └── sqlite3
> ├── include
> │   ├── sqlite3ext.h
> │   └── sqlite3.h
> ├── lib
> │   ├── libsqlite3.a
> │   ├── libsqlite3.la
> │   ├── libsqlite3.so -> libsqlite3.so.0.8.6
> │   ├── libsqlite3.so.0 -> libsqlite3.so.0.8.6
> │   ├── libsqlite3.so.0.8.6
> │   └── pkgconfig
> │       └── sqlite3.pc
> └── share
>     └── man
>         └── man1
> 
> 7 directories, 9 files
> ```

### 2.Build libtiff

> 官网：http://www.libtiff.org/
>
> 下载版本：[tiff-4.6.0t.tar.gz](http://www.libtiff.org/downloads/tiff-4.6.0t.tar.gz)
>
> ```sh
> TIFF_DIR=/home/sgt/Third/open_source/tiff-4.6.0t
> # downlod
> wget http://www.libtiff.org/downloads/tiff-4.6.0t.tar.gz
> # uzip
> tar -zxvf tiff-4.6.0t.tar.gz
> # build
> cd tiff-4.6.0t && rm -rf ./build && mkdir build && cd build
> cmake .. -D CMAKE_INSTALL_PREFIX=$TIFF_DIR
> make
> make install
> ```
>
> 查看编译结果
>
> ```sh
> tree -L 2 ./open_source/tiff-4.6.0t
> ./open_source/tiff-4.6.0t
> ├── bin
> │   ├── fax2ps
> │   ├── fax2tiff
> │   ├── pal2rgb
> │   ├── ppm2tiff
> │   ├── raw2tiff
> │   ├── tiff2bw
> │   ├── tiff2pdf
> │   ├── tiff2ps
> │   ├── tiff2rgba
> │   ├── tiffcmp
> │   ├── tiffcp
> │   ├── tiffcrop
> │   ├── tiffdither
> │   ├── tiffdump
> │   ├── tiffinfo
> │   ├── tiffmedian
> │   ├── tiffset
> │   └── tiffsplit
> ├── include
> │   ├── tiffconf.h
> │   ├── tiff.h
> │   ├── tiffio.h
> │   ├── tiffio.hxx
> │   └── tiffvers.h
> ├── lib
> │   ├── cmake
> │   ├── libtiff.so -> libtiff.so.6
> │   ├── libtiff.so.6 -> libtiff.so.6.0.3
> │   ├── libtiff.so.6.0.3
> │   ├── libtiffxx.so -> libtiffxx.so.6
> │   ├── libtiffxx.so.6 -> libtiffxx.so.6.0.3
> │   ├── libtiffxx.so.6.0.3
> │   └── pkgconfig
> └── share
>     └── doc
> 
> 7 directories, 29 files
> ```

### 3.Build curl

> 官网：https://curl.se/download.html
>
> 下载版本：[curl-7.88.0.tar.gz](https://curl.se/download/curl-7.88.0.tar.gz)
>
> ```sh
> CURL_DIR=/home/sgt/Third/open_source/curl-7.88.0
> # downlod
> wget https://curl.se/download/curl-7.88.0.tar.gz
> # uzip
> tar -zxvf curl-7.88.0.tar.gz
> # build
> cd curl-7.88.0
> ./configure prefix=$CURL_DIR
> make -j32 && make install
> ```
>
> > 如果系统环境没有安装openssl，则需要源码编译安装openssl，然后将curl依赖的openssl对于的so文件拷贝到$CURL_DIR/lib/下
> >
> > ```sh
> > SSL_DIR=/home/sgt/Third/open_source/openssl-3.0.14
> > wget https://www.openssl.org/source/openssl-3.0.14.tar.gz
> > tar -zxvf openssl-3.0.14.tar.gz
> > cd openssl-3.0.14
> > ./Configure --prefix=$SSL_DIR
> > make -j32 && make install
> > ```
> >
> > curl的./configure更新为：
> >
> > ```sh
> > ./configure --prefix=/home/sgt/Third/open_source/curl-7.88.0 --with-ssl=$SSL_DIR
> > ```
> >
> > 同时将编译完成的$SSL_DIR/lib64/lib*拷贝到$CURL_DIR/lib下
> >
> > ```sh
> > cp -r $SSL_DIR/lib64/lib* $CURL_DIR/lib/
> > ```
>
> 查看编译结果
>
> ```sh
> tree -L 2 ../open_source/curl-7.88.0
> ../open_source/curl-7.88.0
> ├── bin
> │   ├── curl
> │   └── curl-config
> ├── include
> │   └── curl
> ├── lib
> │   ├── libcurl.a
> │   ├── libcurl.la
> │   ├── libcurl.so -> libcurl.so.4.8.0
> │   ├── libcurl.so.4 -> libcurl.so.4.8.0
> │   ├── libcurl.so.4.8.0
> │   └── pkgconfig
> └── share
>     ├── aclocal
>     └── man
> 
> 8 directories, 7 files
> ```

### 4.Build PROJ

> 官网：https://proj.org/en/7.2/install.html
>
> Github：https://github.com/OSGeo/PROJ
>
> 下载版本：[proj-7.2.1.tar.gz](https://download.osgeo.org/proj/proj-7.2.1.tar.gz)
>
> ```sh
> PROJ_DIR=/home/sgt/Third/open_source/proj-7.2.1
> # downlod
> wget https://download.osgeo.org/proj/proj-7.2.1.tar.gz
> # uzip
> tar -zxvf proj-7.2.1.tar.gz
> # build
> cd proj-7.2.1 && rm -rf build && mkdir build && cd build
> cmake .. \
> -D CMAKE_INSTALL_PREFIX=$PROJ_DIR \
> -D EXE_SQLITE3=$SQLITE3_DIR/bin/sqlite3 \
> -D SQLITE3_INCLUDE_DIR=$SQLITE3_DIR/include \
> -D SQLITE3_LIBRARY=$SQLITE3_DIR/lib/libsqlite3.so \
> -D CURL_INCLUDE_DIR=$CURL_DIR/include \
> -D CURL_LIBRARY=$CURL_DIR/lib/libcurl.so \
> -D TIFF_INCLUDE_DIR=$TIFF_DIR/include \
> -D TIFF_LIBRARY_RELEASE=$TIFF_DIR/lib/libtiff.so
> make -j32 && make install
> ```
>
> 查看编译结果
>
> ```sh
> tree -L 2 ./open_source/proj-7.2.1
> ./open_source/proj-7.2.1
> ├── bin
> │   ├── cct
> │   ├── cs2cs
> │   ├── geod
> │   ├── gie
> │   ├── proj
> │   ├── projinfo
> │   └── projsync
> ├── include
> │   ├── geodesic.h
> │   ├── proj
> │   ├── proj_api.h
> │   ├── proj_constants.h
> │   ├── proj_experimental.h
> │   └── proj.h
> ├── lib
> │   ├── cmake
> │   ├── libproj.so -> libproj.so.19
> │   ├── libproj.so.19 -> libproj.so.21.1.2
> │   └── libproj.so.21.1.2
> └── share
>     ├── man
>     └── proj
> 
> 8 directories, 15 files
> ```

### 5.Build GEOS

> 官网：https://libgeos.org/usage/download/
>
> 下载版本：[geos-3.12.2.tar.bz2](https://download.osgeo.org/geos/geos-3.12.2.tar.bz2)
>
> ```sh
> GEOS_DIR=/home/sgt/Third/open_source/geos-3.12.2
> # downlod
> curl -O https://download.osgeo.org/geos/geos-3.12.2.tar.bz2
> # uzip
> tar -jxvf geos-3.12.2.tar.bz2
> # build
> cd geos-3.12.2 && rm -rf build && mkdir build && cd build
> cmake .. \
> -D CMAKE_BUILD_TYPE=Release \
> -D CMAKE_INSTALL_PREFIX=$GEOS_DIR
> make -j32 && make install
> ```

### 6.Build Zlib

> 官网：https://www.zlib.net/
>
> 下载版本：[zlib-1.3.1.tar.gz](https://www.zlib.net/zlib-1.3.1.tar.gz)
>
> ```sh
> ZLIB_DIR=/home/sgt/Third/open_source/zlib-1.3.1
> # downlod
> curl -O https://www.zlib.net/zlib-1.3.1.tar.gz
> # uzip
> tar -zxvf zlib-1.3.1.tar.gz
> # build
> cd zlib-1.3.1
> ./configure --prefix=$ZLIB_DIR
> make && make install
> ```

### 7.Build libpng

> 官网：http://www.libpng.org/pub/png/libpng.html
>
> ```sh
> LIBPNG_DIR=/home/sgt/Third/open_source/libpng-1.6.43
> # downlod from site https://download.sourceforge.net/libpng/libpng-1.6.43.tar.gz
> # uzip
> tar -zxvf libpng-1.6.43.tar.gz
> # build
> cd libpng-1.6.43
> ./configure --prefix=$LIBPNG_DIR
> make && make install
> ```

### 8.Build libjpeg-turbo

> 官网：https://libjpeg-turbo.org/
>
> 下载版本：[libjpeg-turbo-3.0.3.tar.gz](https://github.com/libjpeg-turbo/libjpeg-turbo/releases/download/3.0.3/libjpeg-turbo-3.0.3.tar.gz)
>
> ```sh
> LIBJPEG_TURBO_DIR=/home/sgt/Third/open_source/libjpeg-turbo-3.0.3
> # downlod
> wget https://github.com/libjpeg-turbo/libjpeg-turbo/releases/download/3.0.3/libjpeg-turbo-3.0.3.tar.gz
> # uzip
> tar -zxvf libjpeg-turbo-3.0.3.tar.gz
> # build
> cd libjpeg-turbo-3.0.3 && rm -rf build && mkdir build && cd build
> cmake .. -D CMAKE_INSTALL_PREFIX=$LIBJPEG_TURBO_DIR
> make -j32 && make install
> ```

### 9.Build gdal

> 官网：
>
> 下载版本：
>
> 说明：
>
> 1. geos编译安装必须安装到默认目录才能编译通过不然会报错，指定头文件和so依然会报错，待解决
> 2. 需要指定openssl的lib路径，很多库依赖它，我曾经拷贝到这里export LD_LIBRARY_PATH=/home/sgt/Third/open_source/curl-7.88.0/lib
>
> ```sh
> SQLITE3_DIR=/home/sgt/Third/open_source/sqlite-3.46.0
> GEOS_DIR=/home/sgt/Third/open_source/geos-3.10.6
> LIBPNG_DIR=/home/sgt/Third/open_source/libpng-1.6.43
> LIBJPEG_TURBO_DIR=/home/sgt/Third/open_source/libjpeg-turbo-3.0.3
> PROJ_DIR=/home/sgt/Third/open_source/proj-7.2.1
> ZLIB_DIR=/home/sgt/Third/open_source/zlib-1.3.1
> TIFF_DIR=/home/sgt/Third/open_source/tiff-4.6.0t
> CURL_DIR=/home/sgt/Third/open_source/curl-7.88.0
> SWIG_DIR=/home/sgt/Third/open_source/swig-4.2.1
> # downlod
> wget 
> # uzip
> tar -zxvf 
> # build
> cd gdal-3.7.0 && rm -rf build && mkdir build && cd build
> cmake .. \
> -D CMAKE_BUILD_TYPE=Release \
> -D GDAL_USE_EXTERNAL_LIBS:BOOL=ON \
> -D CMAKE_INSTALL_PREFIX=/home/sgt/Third/open_source/gdal-3.7.0 \
> -D SQLite3_INCLUDE_DIR=$SQLITE3_DIR/include \
> -D SQLite3_LIBRARY=$SQLITE3_DIR/lib/libsqlite3.so \
> -D CURL_INCLUDE_DIR=$CURL_DIR/include \
> -D CURL_LIBRARY_RELEASE=$CURL_DIR/lib/libcurl.so \
> -D ZLIB_INCLUDE_DIR=$ZLIB_DIR/include \
> -D ZLIB_LIBRARY_RELEASE=$ZLIB_DIR/lib/libz.so \
> -D TIFF_INCLUDE_DIR=$TIFF_DIR/include \
> -D TIFF_LIBRARY_RELEASE=$TIFF_DIR/lib/libtiff.so \
> -D PROJ_INCLUDE_DIR=$PROJ_DIR/include \
> -D PROJ_LIBRARY_RELEASE=$PROJ_DIR/lib/libproj.so \
> -D PNG_PNG_INCLUDE_DIR=$LIBPNG_DIR/include \
> -D PNG_LIBRARY_RELEASE=$LIBPNG_DIR/lib/libpng.so \
> -D JPEG_INCLUDE_DIR=$LIBJPEG_TURBO_DIR/include \
> -D JPEG_LIBRARY_RELEASE=$LIBJPEG_TURBO_DIR/lib/libjpeg.so \
> -D SWIG_EXECUTABLE=$SWIG_DIR/bin/swig \
> -D GEOS_CONFIG=${GEOS_DIR}/bin/geos-config \
> -D GEOS_DIR=${GEOS_DIR}
> make -j32 && make install
> ```

