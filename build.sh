#!/bin/bash

# Some of these packages are not compatible with the latest
# gnome-shell version. The -d flag to makepkg builds them anyway.
# With -f they can also be built multiple times while testing.
makepkg-expanded -r 'exec makepkg -dfp $1' -r 'exec cp-pkgver $1 $2' -a
