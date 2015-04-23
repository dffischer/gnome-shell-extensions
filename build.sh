#!/bin/bash

if [ "$1" = "-h" ]
then
  echo "usage: $0 [package...]"
  echo 'builds the given packages, or all found below the current directory, expanding' \
    'makepkg-templates but leaving the original intact apart from the version numbers.'
  echo 'Templates are taken from a makepkg-templates directory found besides this script.'
  exit
fi

for dir in ${@:-$(find -iname PKGBUILD -printf "%h\n")}
do
  if [ ! -r "$dir/PKGBUILD" ]
  then
    echo "$dir does not contain any PKGBUILD"
  else
    makepkg-template -p $dir/PKGBUILD -o "$dir/PKGBUILD.expanded" --template-dir ${BASH_SOURCE[@]%%/*}/makepkg-templates
    ( cd "$dir" ; makepkg -fp PKGBUILD.expanded ; mkaurball -fp PKGBUILD.expanded )
    oldpkgver=$(grep -Po '(?<=^pkgver=)[^ ]*' "$dir/PKGBUILD")
    newpkgver=$(grep -Po '(?<=^pkgver=)[^ ]*' "$dir/PKGBUILD.expanded")
    if [ $newpkgver != $oldpkgver ]
    then
      sed --follow-symlinks -i "s:^pkgver=[^ ]*:pkgver=$newpkgver:;s:^pkgrel=[^ ]*:pkgrel=1:" "$dir/PKGBUILD"
    fi
  fi
done
