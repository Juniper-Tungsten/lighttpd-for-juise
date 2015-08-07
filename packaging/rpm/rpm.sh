#!/bin/bash

#
# usage: rpm.sh
#
# This is a somewhat hacky script to use rpmbuild to build a valid .rpm
# package file for lighttpd-for-juise.
#
# Note this will make rpmbuild directories under ~/rpmbuild
#
# See the README.md file in this directory on steps how to use this script.
#

PKG_DIR=`pwd`

mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}

cd ../..
./autogen.sh

cd $PKG_DIR
mkdir -p build
cd build

../../../configure --with-websocket=ALL --without-libicu

make
make dist

# spec files can't have hyphens in Version string.  This is a cruddy song and
# dance to appease the rpmbuild Gods.
VERSION=`grep " PACKAGE_VERSION \"" config.h | cut -d "\"" -f 2`
SPEC_VERSION=${VERSION//-/_}
mkdir tmp
cd tmp
tar xzf ../lighttpd-${VERSION}.tar.gz
mv lighttpd-${VERSION} lighttpd-for-juise-${SPEC_VERSION}
rm -f ~/rpmbuild/SOURCES/lighttpd-for-juise-${VERSION}.tar.gz
tar czf ~/rpmbuild/SOURCES/lighttpd-for-juise-${VERSION}.tar.gz lighttpd-for-juise-${SPEC_VERSION}
cd ..

rpmbuild -ba packaging/rpm/lighttpd-for-juise.spec

cd $PKG_DIR
rm -rf build

echo "------------------------------------------------------------"
echo ".rpm has been created in '~/rpmbuild/RPMS/<arch>' directory."
echo "-"
