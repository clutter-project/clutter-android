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


SOURCES="$PWD/sources"
PREFIX="$PWD/install"
LIBDIR="$PWD/install/lib"

export CFLAGS=
export CC=arm-linux-androideabi-gcc
export CXX=arm-linux-androideabi-g++

export C_INCLUDE_PATH=$PREFIX/include
export CPLUS_INCLUDE_PATH=$PREFIX/include

export ANDROID_SDK_DIR="$HOME/android-sdk-linux"
export ANDROID_NDK_DIR=`find $HOME -maxdepth 1 -type d -name 'android-ndk-*'`
export ANDROID_NDK_TOOLCHAIN="$PWD/toolchain"

export gl_cv_header_working_stdint_h=yes

# remove other langauges
export LINGUAS=C

# avoid picking up system libraries
export PKG_CONFIG_LIBDIR=/foo/bar
export PKG_CONFIG_PATH=$LIBDIR/pkgconfig

export PATH="$PATH:$ANDROID_NDK_DIR:$ANDROID_NDK_TOOLCHAIN/bin"
export PATH="$PATH:$ANDROID_SDK_DIR/tools/:$ANDROID_SDK_DIR/platform-tools"

export NDK_MODULE_PATH=$PWD

export PKG_CONFIG="pkg-config --define-variable=glib_genmarshal=/usr/bin/glib-genmarshal --define-variable=gobject_query=/usr/bin/gobject-query --define-variable=glib_mkenums=/usr/bin/glib-mkenums --define-variable=glib_compile_resources=/usr/bin/glib-compile-resources"
