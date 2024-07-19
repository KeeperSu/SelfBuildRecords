#!/bin/bash
set -e
# ------ 当前sh文件所在目录
DIR_ROOT=$(cd `dirname $0`; pwd)
echo "-- CURRENT_SH_DIR=${DIR_ROOT}"
# ------ 函数定义
# 文件夹创建
function createDir(){
  if [ ! -d "$1" ]; then
    mkdir -p "$1"
  else
    echo "-- Directory existed: $1"
  fi
}
# 解压开源包，参数$1=三方库名文件名-版本号
function processUnzip(){
  tarGzFile=${DIR_ZIP}/$1.tar.gz
  tarBzFile=${DIR_ZIP}/$1.tar.bz2
  if [ -f ${tarGzFile} ]; then
    tar -zxf ${tarGzFile} -C ${DIR_3RD}
  elif [ -f ${tarBzFile} ]; then
    tar -jxf ${tarBzFile} -C ${DIR_3RD}
  else
    echo "-- $1.tar.gz or $1.tar.bz2 not found"
  fi
}
# 编译配置函数cmake 或 configure
function processBuildConfig(){
  cd ${cur3rd}
  if [ -f ${cur3rd}/CMakeLists.txt ]; then
    rm -rf build && mkdir build && cd build
    cmake .. \
    -D CMAKE_BUILD_TYPE=Release \
    -D CMAKE_INSTALL_PREFIX=${curInstall}
  elif [ -f ${cur3rd}/configure ]; then
    ./configure --prefix=${curInstall}
  fi
}


# 编译每个开源库，参数$1=三方库名文件名-版本号
function processBuild(){
  echo "-- Build $1 start ..."
  cur3rd=${DIR_3RD}/$1
  curInstall=${DIR_INSTALL}/$1
  rm -rf ${cur3rd}
  rm -rf ${curInstall}
  processUnzip $1
  processBuildConfig $1
  make clean
  make -j$(nproc)
  make install
  # 如果编译失败，未生成install目录，则退出
  if [ ! -d ${curInstall} ]; then
    echo "-- Build $1 failed ..."
    exit
  fi
  echo "-- Build $1 finished ..."
}
#------ 目录设置
DIR_3RD=${DIR_ROOT}/3rd
DIR_ZIP=${DIR_ROOT}/zip
DIR_INSTALL=${DIR_ROOT}/install
DIR_COMMON_LIBS=${DIR_ROOT}/common_lib
createDir ${DIR_3RD}
createDir ${DIR_ZIP}
createDir ${DIR_INSTALL}
createDir ${DIR_COMMON_LIBS}

# ------
LIST_3RD=("zlib-1.3.1")
for name3rd in ${LIST_3RD};
do
  processBuild ${name3rd}
done