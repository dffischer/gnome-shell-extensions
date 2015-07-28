#!/bin/bash

makepkg-expanded -a PKGBUILD -r '
  GLOBIGNORE="$GLOBIGNORE:replaced-by"
  aurbranch -p "$1" "${@/%/:}" $(git ls-files *)'
