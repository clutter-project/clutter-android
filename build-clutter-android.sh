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


set -ex

# Which target architecture (arm or x86).
ARCH=x86

# Which Android "API Level" to build for.
API_LEVEL=14

# Which version of the Android NDK toolchain to use (e.g. 4.6). 
TOOLCHAIN_VERSION=4.6

# Where the Android NDK lives.
NDK_NAME=android-ndk-r8d
NDK_DIR=$HOME/$NDK_NAME

# Where the Android SDK lives.
SDK_NAME=android-sdk-linux
SDK_DIR=$HOME/$SDK_NAME

# Download the Android NDK if necessary.
if ! test -d $NDK_DIR; then
    mkdir -p $NDK_DIR
    pushd $NDK_DIR/..
        wget http://dl.google.com/android/ndk/$NDK_NAME-linux-x86.tar.bz2 \
            && tar jxf $NDK_NAME-linux-x86.tar.bz2 \
            && rm $NDK_NAME-linux-x86.tar.bz2
    popd
fi

# Download the Android SDK if necessary.
if ! test -d $SDK_DIR; then
    mkdir -p $SDK_DIR
    pushd $SDK_DIR/..
        wget http://dl.google.com/android/android-sdk_r21-linux.tgz \
            && tar zxf android-sdk_r21-linux.tgz \
            && rm android-sdk_r21-linux.tgz
    popd
fi

# Update the Android SDK if necessary.
#$SDK_DIR/tools/android update sdk -u --filter platform-tool,tool
#$SDK_DIR/tools/android update sdk -u --filter android-$API_LEVEL

# Toolchain name: the prefix of toolchain command names
# Toolchain arg: passed to make-standalon-toolchain.sh
# Toolchain dir: where we put the standalone toolchain
case $ARCH in
    arm)
        export TOOLCHAIN_NAME=arm-linux-androideabi
        TOOLCHAIN_ARG=arm-linux-androideabi-$TOOLCHAIN_VERSION
        ;;
    x86)
        export TOOLCHAIN_NAME=i686-linux-android
        TOOLCHAIN_ARG=x86-$TOOLCHAIN_VERSION
        ;;
esac
TOOLCHAIN_DIR=$PWD/toolchain-$ARCH-$TOOLCHAIN_VERSION

# Create the standalone toolchain.
$NDK_DIR/build/tools/make-standalone-toolchain.sh \
    --toolchain=$TOOLCHAIN_ARG \
    --platform=android-$API_LEVEL \
    --install-dir=$TOOLCHAIN_DIR

# Set up patched version of jhbuild
JHB_PREFIX=$PWD/jhbuild/.local
if ! test -d jhbuild; then
    git clone git://git.gnome.org/jhbuild
    pushd jhbuild
        patch -p1 -i ../modulesets/patches/jhbuild/disable-clean-la-files.patch
        ./autogen.sh --prefix=$JHB_PREFIX
        make install
    popd
fi

mkdir -p $JHB_PREFIX/share/aclocal
cp /usr/share/aclocal/gtk-doc.m4 $JHB_PREFIX/share/aclocal/

export PREFIX="$PWD/install-$ARCH-$API_LEVEL"

export CFLAGS=
export CC=$TOOLCHAIN_NAME-gcc
export CXX=$TOOLCHAIN_NAME-g++

export C_INCLUDE_PATH=$PREFIX/include
export CPLUS_INCLUDE_PATH=$PREFIX/include

export gl_cv_header_working_stdint_h=yes

# remove other langauges
export LINGUAS=C

# avoid picking up system libraries
export PKG_CONFIG_LIBDIR=/foo/bar
export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig

export ac_cv_path_GLIB_COMPILE_RESOURCES=/usr/bin/glib-compile-resources
export ac_cv_path_GLIB_COMPILE_SCHEMAS=/usr/bin/glib-compile-schemas
export ac_cv_path_GLIB_GENMARSHAL=/usr/bin/glib-genmarshal

export PATH="$TOOLCHAIN_DIR/bin:$NDK_DIR:$SDK_DIR/tools/:$SDK_DIR/platform-tools:$PATH"

export NDK_MODULE_PATH=$PWD

export PKG_CONFIG="pkg-config \
    --define-variable=glib_genmarshal=/usr/bin/glib-genmarshal \
    --define-variable=gobject_query=/usr/bin/gobject-query \
    --define-variable=glib_mkenums=/usr/bin/glib-mkenums \
    --define-variable=glib_compile_resources=/usr/bin/glib-compile-resources \
"

# Do it.
$JHB_PREFIX/bin/jhbuild -f jhbuildrc-android -m modulesets/clutter-android.modules ${*:-build glib}
