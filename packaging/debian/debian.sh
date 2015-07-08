#!/bin/bash

#
# usage: debian.sh
#
# This is a somewhat hacky script to use debian tools to build a valid .deb
# package file for lighttpd-for-juise.
#
# See the README file in this directory on steps how to use this script.
#

cd ../..
./autogen.sh

# dpkg-buildpackage requires the debian directory here
ln -s packaging/debian debian
dpkg-buildpackage -us -uc -rfakeroot > debian/build.log

# remove all the files dpkg-buildpackage leaves around
rm -rf debian/files debian/tmp debian/lighttpd-for-juise debian/lighttpd-for-juise*debhelper* debian/lighttpd-for-juise*substvars debian/build.log

# clean up our symlink
rm debian
cd packaging/debian
mkdir -p output

# dpkg-buildpackage doesn't support output directory argument
mv ../../../lighttpd-for-juise_* output

echo "-----------------------------------------------------------------"
echo ".deb (and related files) have been created in 'output' directory."
echo ""
