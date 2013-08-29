# Copyright © 2012, Intel Corporation.
#
# This program is free software; you can redistribute it and/or modify it
# under the terms and conditions of the GNU Lesser General Public License,
# version 2.1, as published by the Free Software Foundation.
#
# This program is distributed in the hope it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
# more details.
#
# You should have received a copy of the GNU Lesser General Public License along with
# this program; if not, write to the Free Software Foundation, Inc., 51 Franklin St
# - Fifth Floor, Boston, MA 02110-1301 USA

if [ ! -d $PWD/install ]; then
  echo "Please source this script from the top level directory of the clutter-android project"
  exit 1
fi

pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="${PATH:+"$PATH:"}$1"
    fi
}

SOURCES="$PWD/sources"
PREFIX="$PWD/install"
LIBDIR="$PWD/install/lib"

export CFLAGS=
export CC=arm-linux-androideabi-gcc
export CXX=arm-linux-androideabi-g++

export C_INCLUDE_PATH=$PREFIX/include
export CPLUS_INCLUDE_PATH=$PREFIX/include

[[ ! ${ANDROID_SDK_DIR:+isset} ]] && export ANDROID_SDK_DIR="$PWD/android-sdk-linux"
[[ ! ${ANDROID_NDK_DIR:+isset} ]] && export ANDROID_NDK_DIR=`find $PWD/* -maxdepth 0 -type d -name 'android-ndk-r*'`
[[ ! ${ANDROID_NDK_TOOLCHAIN:+isset} ]] && export ANDROID_NDK_TOOLCHAIN="$PWD/toolchain"

export gl_cv_header_working_stdint_h=yes

# remove other langauges
export LINGUAS=C

# avoid picking up system libraries
export PKG_CONFIG_LIBDIR=/foo/bar
export PKG_CONFIG_PATH=$LIBDIR/pkgconfig

pathadd "$ANDROID_NDK_DIR"
pathadd "$ANDROID_NDK_TOOLCHAIN/bin"
pathadd "$ANDROID_SDK_DIR/tools"
pathadd "$ANDROID_SDK_DIR/platform-tools"

export NDK_MODULE_PATH=$PWD

export GLIB_BIN=/usr/bin

if [[ `uname` == 'Darwin' ]] && [[ -f '/opt/local/bin/glib-mkenums' ]]
then
    GLIB_BIN='/opt/local/bin'
fi

export PKG_CONFIG="pkg-config --define-variable=glib_genmarshal=$GLIB_BIN/glib-genmarshal --define-variable=gobject_query=$GLIB_BIN/gobject-query --define-variable=glib_mkenums=$GLIB_BIN/glib-mkenums --define-variable=glib_compile_resources=$GLIB_BIN/glib-compile-resources"
