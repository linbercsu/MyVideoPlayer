#!/bin/bash

source ./shell_util.sh

if test -z $ANDROID_HOME
then
  echo "ANDROID_HOME isn't found."
  echo "It should something like this."
  echo "ANDROID_HOME=/Users/jake/Library/Android/sdk"
  echo "now we guess one."
  ANDROID_HOME=$(guessAndroidSdk)
  echo "ANDROID_HOME is $ANDROID_HOME"
fi


NDK_VERSION=$(findValue "$(cat "./build.gradle")" ndkVersion)

echo "ndk version = $NDK_VERSION"

export NDK="${ANDROID_HOME}/ndk/$NDK_VERSION"
echo $NDK

cd app/src/main/cpp/

./config-ffmpeg.sh --arch=arm64