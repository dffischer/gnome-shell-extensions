#!/bin/bash

if [ "$1" = "-h" ]
then
  echo "usage: $0 [package...]"
  echo 'builds the given packages, or all found below the current directory,' \
    'with makepkg-template in a temporary directory, leaving the original' \
    'intact apart from the version numbers and moves the source package back.'
  echo 'Templates are taken from a makepkg-templates directory found besides this script.'
  echo 'Packages are built in a subdirectory of /tmp/build-packages. This' \
    'path can be overwritten with the environment variable PACKAGE_BUILD_DIR.'
  exit
fi

for dir in ${@:-$(find -iname PKGBUILD -printf "%h\n")}
do
  if [ ! -r "$dir/PKGBUILD" ]
  then
    echo "$dir does not contain any PKGBUILD"
  else
    pkgname=$(sed -n "s/pkgname=\([\"']\?\)\(.*\)\1$/\2/p;t" "$dir/PKGBUILD")
    builddir="${PACKAGE_BUILD_DIR:=/tmp/build-packages}/$pkgname"
    mkdir -p "$builddir"
    find $dir -mindepth 1 -maxdepth 1 \! -name PKGBUILD -exec cp -Lrt "$builddir" '{}' +
    makepkg-template -p "$dir/PKGBUILD" -o "$builddir/PKGBUILD" --template-dir ${BASH_SOURCE[@]%%/*}/makepkg-templates
    ( cd "$builddir" ; makepkg -f ; mkaurball -f )
    mv "$builddir"/*.src.tar.gz "$builddir"/*.pkg.tar* "$dir"
    oldpkgver=$(grep -Po '(?<=^pkgver=)[^ ]*' "$dir/PKGBUILD")
    newpkgver=$(grep -Po '(?<=^pkgver=)[^ ]*' "$builddir/PKGBUILD")
    if [ $newpkgver != $oldpkgver ]
    then
      sed --follow-symlinks -i "s:^pkgver=[^ ]*:pkgver=$newpkgver:;s:^pkgrel=[^ ]*:pkgrel=1:" "$dir/PKGBUILD"
    fi
  fi
done
