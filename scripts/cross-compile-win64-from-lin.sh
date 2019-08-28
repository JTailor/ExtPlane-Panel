#!/bin/bash
#
# This script compiles ExtPlane-panel for windows 64bit from Linux host.
# Uses mxe cross-compile environment.
#
# mxe must be installed in /usr/lib/mxe (debian packages) or in ../mxe
#
# Run this script from the ExtPlane-Panel dir:
#
# ./scripts/cross-compile-win64-from-lin.sh
#
#
# Good luck!
#

if [ ! -d ../ExtPlane-Panel ] ; then
   echo "Run this from ExtPlane-Panel subdirectory is. Read the comments in script."
   exit -1
fi
echo "Cleaning up build dir"
qmake -r
make clean distclean

if [ -d ../mxe ] ; then
  MXEDIR=`pwd`/../mxe
else
  if [ -d /usr/lib/mxe ] ; then
     MXEDIR = /usr/lib/mxe
  fi
fi

if [ -z "$MXEDIR" ] ; then
  echo "mxe must be installed in /usr/lib/mxe!"
  exit -1
fi

TARGET=x86_64-w64-mingw32.static

echo "Using mxe in $MXEDIR , target $TARGET"


pushd $MXEDIR
make MXE_TARGETS=$TARGET qt5 QT5_BUILD_TYPE=-debug-and-release
popd

PATH=$MXEDIR/usr/bin/:$PATH

echo
echo Starting ExtPlane-Panel build
echo $PATH
$MXEDIR/usr/$TARGET/qt5/bin/qmake  "CONFIG+=release" -recursive
make
