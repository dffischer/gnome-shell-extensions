# Gnome Shell Extension Packages for AUR

This repository collects packages for [extensions](https://extensions.gnome.org/) to the [GNOME Shell](https://wiki.gnome.org/Projects/GnomeShell) to globally install them via [Arch Linux](http://archlinux.org/)'s [User Repository](https://aur.archlinux.org/). They are all built and installed in a similar way, so collecting them here eases maintenance as code fragments can be unified and shared among them.


## Organization

- [makepkg-templates](makepkg-templates) contains code snippets needed in many of the extensions. See the [README](makepkg-templates) there for a more detailed description.

- [gschemas.install](gschemas.install) is the install script utilized by all extensions that install glib schemas. The [corresponding template](makepkg-templates/install-schemas.template) automatically adds it, but as a PKGBUILD can not pull in something from outside its own directory, so it also has to be linked into the package directory.

- [README.md](README.md) is the document you are reading right now.

- all other directories package one extension each.
