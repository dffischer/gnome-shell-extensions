#!/bin/bash

if [ "$1" = "-h" ]
then
  echo "usage: $0 [package...]"
  echo 'builds the given packages, or the one found in the current directory,' \
    'with makepkg-template in a temporary directory, leaving the original' \
    'intact apart from the version numbers and moves the source package back.'
  echo 'Templates are taken from a makepkg-templates directory found besides this script.'
  exit
fi

for dir in ${@-.}
do
  if [ ! -r "$dir/PKGBUILD" ]
  then
    echo "$dir does not contain any PKGBUILD"
  else
    pkgname=$(sed -n "s/pkgname=\([\"']\?\)\(.*\)\1$/\2/p;t" "$dir/PKGBUILD")
    builddir=/tmp/build-packages/$pkgname
    mkdir -p "$builddir"
    find $dir -mindepth 1 -maxdepth 1 \! -name PKGBUILD -exec cp -Lrt $builddir '{}' +
    makepkg-template -p "$dir/PKGBUILD" -o $builddir/PKGBUILD --template-dir ${BASH_SOURCE[@]%%/*}/makepkg-templates
    ( cd $builddir ; makepkg -f ; mkaurball -f )
    mv $builddir/*.src.tar.gz $builddir/*.pkg.tar* "$dir"
    oldpkgver=$(grep -Po '(?<=^pkgver=)[^ ]*' "$dir/PKGBUILD")
    newpkgver=$(grep -Po '(?<=^pkgver=)[^ ]*' $builddir/PKGBUILD)
    if [ $newpkgver != $oldpkgver ]
    then
      sed --follow-symlinks -i "s:^pkgver=[^ ]*:pkgver=$newpkgver:;s:^pkgrel=[^ ]*:pkgrel=1:" "$dir/PKGBUILD"
    fi
  fi
done
