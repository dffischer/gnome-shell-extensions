# Gnome Shell Extension Packages for AUR

This repository collects packages for [extensions](https://extensions.gnome.org/) to the [GNOME Shell](https://wiki.gnome.org/Projects/GnomeShell) to globally install them via [Arch Linux](http://archlinux.org/)'s [User Repository](https://aur.archlinux.org/). They are all built and installed in a similar way, so collecting them here eases maintenance as code fragments can be unified and shared among them.

If you are interested in how this repository and the AUR packages therein are managed or want to help maintain it, you may want to look at [the contribution guidelines](CONTRIBUTING.md).


## Organization

- [makepkg-templates](makepkg-templates) contains code snippets needed in many of the extensions. See the [README](makepkg-templates) there for a more detailed description.

- [gschemas.install](gschemas.install) is the install script utilized by all extensions that install glib schemas. The [corresponding template](makepkg-templates/install-schemas.template) automatically adds it, but as a PKGBUILD can not pull in something from outside its own directory, so it also has to be linked into the package directory. It compiles glib-2.0 schemas installed with the extension, which normally are used to store its configuration, and tells the user how to activate it.

- All PKGBUILDs not utilizing gschemas.install should use [notice.install](notice.install) instead. It reminds the user to restart the shell for the extension installation to have an effect.

- A [.gitignore](.gitignore) file excludes all intermediate products, packages and source aurballs created when building packages and preparing them for upload to the AUR.

- [README.md](README.md) is the document you are reading right now.

- all other directories package one extension each.

Apart from expanding the templates, this repository should exactly mirror the state of the packages in the AUR.
