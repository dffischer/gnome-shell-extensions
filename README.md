# Gnome Shell Extension Packages for AUR

This repository collects packages for [extensions](https://extensions.gnome.org/) to the [GNOME Shell](https://wiki.gnome.org/Projects/GnomeShell) to globally install them via [Arch Linux](http://archlinux.org/)'s [User Repository](https://aur.archlinux.org/). They are all built and installed in a similar way, so collecting them here eases maintenance as code fragments can be unified and shared among them.


## Contributing

Contributions are very welcome. If you want to use the templates to package other extensions, feel free to fork this repository and add them. Pull requests are much appreciated.

Simple version updates are only checked in on important upstream changes. Please leave all templates unexpanded (as `template input` instead of `template begin` and `template and`) to avoid cluttered and redundant code. The [makepkg-expanded suite of tools](https://github.com/dffischer/makepkg-expanded) can build the packages without expanding their templates. If you have it installed, you can ease your work further with the [build.sh](build.sh) wrapper.

The [makepkg-template for git packages](https://github.com/dffischer/git-makepkg-template) are needed to expand all the templates used herein. [Install them globally](https://aur.archlinux.org/packages/git-makepkg-template-git/) or copy them into the [makepkg-templates directory](makepkg-templates) after cloning.


## Organization

- [makepkg-templates](makepkg-templates) contains code snippets needed in many of the extensions. See the [README](makepkg-templates) there for a more detailed description.

- [gschemas.install](gschemas.install) is the install script utilized by all extensions that install glib schemas. The [corresponding template](makepkg-templates/install-schemas.template) automatically adds it, but as a PKGBUILD can not pull in something from outside its own directory, so it also has to be linked into the package directory. It compiles glib-2.0 schemas installed with the extension, which normally are used to store its configuration, and tells the user how to activate it.

- All PKGBUILDs not utilizing gschemas.install should use [notice.install](notice.install) instead. It reminds the user to restart the shell for the extension installation to have an effect.

-  [build.sh](build.sh) builds all packages found below the current directory. It needs [makepkg-expanded](https://github.com/dffischer/makepkg-expanded) installed.

-  [distribute.sh](distribute.sh) commits all packages found below the current directory to distribution branches to prepare for AUR upload. It needs [makepkg-expanded](https://github.com/dffischer/makepkg-expanded) and [pkgbuild-introspection](https://www.archlinux.org/packages/community/any/pkgbuild-introspection/) installed.

- A [.gitignore](.gitignore) file excludes all intermediate products, packages and source aurballs created when building packages and preparing them for upload to the AUR.

- [README.md](README.md) is the document you are reading right now.

- all other directories package one extension each.

Apart from expanding the templates, this repository should exactly mirror the state of the packages in the AUR.
