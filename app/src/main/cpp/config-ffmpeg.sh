#!/bin/bash

source ./shell_util.sh

PREFIX=$(pwd)/ffmpeg/ffbuild/lib/

CLANG_TARGET=aarch64-none-linux-android21

HOST_PLATFORM=darwin-x86_64

ARCH=arm64
CPU=armv8-a

CC="$NDK/toolchains/llvm/prebuilt/$HOST_PLATFORM/bin/clang -target $CLANG_TARGET"
CXX="$NDK/toolchains/llvm/prebuilt/$HOST_PLATFORM/bin/clang++ -target $CLANG_TARGET"

TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/$HOST_PLATFORM

CROSS_PREFIX=${TOOLCHAIN}/bin/llvm-

FF_COMPILER="\
--arch=$ARCH \
--cpu=$CPU \
--cross-prefix=$CROSS_PREFIX \
--target-os=android \
--enable-cross-compile \
--sysroot=${TOOLCHAIN}/sysroot \
"

cd ffmpeg

./configure \
$FF_COMPILER                     \
--cc="$CC"                       \
--cxx="$CXX"                     \
--prefix=$PREFIX \
    --disable-doc \
    --disable-ffmpeg \
    --disable-ffplay \
    --disable-network \
    --disable-symver \
    --disable-postproc \
    --enable-shared \
    --enable-static \
    --disable-ffprobe \
    --enable-gpl \
    --enable-pic \
    --enable-jni \
    --disable-optimizations \
    --disable-stripping \
    --enable-debug \


make clean
make -j8

make install