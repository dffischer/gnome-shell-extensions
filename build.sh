#!/bin/bash

if [ "$1" = "-h" ]
then
  echo "usage: $0 [package...]"
  echo 'builds the given packages, or all found below the current directory, expanding' \
    'makepkg-templates but leaving the original intact apart from the version numbers.'
  echo 'Templates are taken from a makepkg-templates directory found besides this script.'
  exit
fi

templates="--template-dir /usr/share/makepkg-template --template-dir $(realpath ${BASH_SOURCE[@]%%/*})/makepkg-templates"
for dir in ${@:-$(find -iname PKGBUILD -printf "%h\n")}
do
  if [ ! -r "$dir/PKGBUILD" ]
  then
    echo "$dir does not contain any PKGBUILD"
  else (
    cd "$dir"

    # build
    makepkg-template -o PKGBUILD.expanded $templates
    makepkg -fp PKGBUILD.expanded
    mkaurball -fp PKGBUILD.expanded

    # propagate changed pkgver
    oldpkgver=$(grep -Po '(?<=^pkgver=)[^ ]*' PKGBUILD)
    newpkgver=$(grep -Po '(?<=^pkgver=)[^ ]*' PKGBUILD.expanded)
    if [ $newpkgver != $oldpkgver ]
    then
      sed --follow-symlinks -i "s:^pkgver=[^ ]*:pkgver=$newpkgver:;s:^pkgrel=[^ ]*:pkgrel=1:" PKGBUILD
    fi
  ) fi
done
