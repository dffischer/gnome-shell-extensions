# Gnome Shell Extension Packages for AUR

This repository collects packages for [extensions](https://extensions.gnome.org/) to the [GNOME Shell](https://wiki.gnome.org/Projects/GnomeShell) to globally install them via [Arch Linux](http://archlinux.org/)'s [User Repository](https://aur.archlinux.org/). They are all built and installed in a similar way, so collecting them here eases maintenance as code fragments can be unified and shared among them.


## Contributing

Contributions are very welcome. If you want to use the templates to package other extensions, feel free to fork this repository and add them. Pull requests are much appreciated.

Simple version updates are only checked in on important upstream changes. Please leave all templates unexpanded (as `template input` instead of `template begin` and `template and`) to avoid cluttered and redundant code.


## Organization

- [makepkg-templates](makepkg-templates) contains code snippets needed in many of the extensions. See the [README](makepkg-templates) there for a more detailed description.

- [gschemas.install](gschemas.install) is the install script utilized by all extensions that install glib schemas. The [corresponding template](makepkg-templates/install-schemas.template) automatically adds it, but as a PKGBUILD can not pull in something from outside its own directory, so it also has to be linked into the package directory.

- [build.sh](build.sh) can be used to build packages without touching their template declarations. The script does this by substituting the templates in a file `PKGBUILD.expanded` which is then used to compile the package and source tarball. Version changes caused by a `pkgver` function propagate back to the original.

- A [.gitignore](.gitignore) file excludes all intermediate products, packages and source aurballs created when building packages and preparing them for upload to the AUR.

- [README.md](README.md) is the document you are reading right now.

- all other directories package one extension each.

Apart from expanding the templates, this repository should exactly mirror the state of the packages in the AUR.
