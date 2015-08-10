# Building lighttpd-for-juise.rpm

In order to build the .rpm files, you will need to be running under the base
line architecture that you want to support.  If you want to build an amd64 rpm
file, be under an amd64 host.

## Prerequisites

The prereqs for building the .rpm files are:

```
yum install gcc bison automake make autoconf libtool libxml2-devel libxslt-devel libcurl-devel sqlite-devel tcl libedit-devel bison-devel rpm-build redhat-rpm-config bzip2-devel pcre-devel
```

## Building the .rpm

* Simply run `./rpm.sh`

This script should take care of all the necessary steps to build and package
the .rpm files.  After it is done, the files should be in the `~/rpmbuild/RPMS`
directory.

Note that rpmbuild will create directories ~/rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
