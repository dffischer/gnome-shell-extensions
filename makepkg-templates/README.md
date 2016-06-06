# Templates for often used PKGBUILD snippets

Comments in the template code are not stripped when they are input and thus would end up in the exported PKGBUILD. To not clutter these, this file provides overview and documentation instead.

All templates end with a version number which should be increased on major changes. There always exists a symbolic link to the newest version, lacking any number.

- [source-github-release](source-github-release.template) downloads the last release from GitHub and generates a version number looking at its tag. The location is generated from a `$url` pointing to the homepage of the repository, which can be overwritten by setting a `$_giturl` pointing to the latest release GitHub API location before including the template.

- [adjust-version](adjust-version.template) contains a `prepare` function that modifies the `metadata.json` of an extension to be exactly compatible with the gnome-shell versions the `depends` array specifies. It is used to make the package installable with versions that are not officially supported by the developer, which mostly happens because the extension is not actively maintained any more. If the functionality is known to be restricted under certain versions, the package should tell so in the post_install and post_upgrade hooks of its installer script.

- [find-version](find-version.template) adds _gnome-shell_ to the dependencies, restricted to the versions parsed from the `metadata.json`.

  As this file has to be present in `$srcdir`, the `.SRCINFO` of `PKGBUILD`s utilizing the version range can only be correctly generated after the sources are downloaded and extracted. If the `metadata.json` is not yet present, the package will be configured to be dependend on _gnome-shell_ independent of any version. It is advised to run `makepkg` to compile the package before executing `makepkg -S`, `makeaurball`, `mksrcinfo` or anything alike.

- [gnome-shell-version](gnome-shell-version.template) is a small snippet that spits out the currently installed version of gnome-shell. It is used in the former two templates.

- [modularize-package](modularize-package.template) sets up a modular `package` function that will call all functions of the naming pattern `package_<number>_<name>` in order. Multiple of these package functions may have the same numbers. They will then be called in alphabetical order. Inclusion of this template is needed to use any of the remaining templates.

- [install-code](install-code.template) installs the extension code. It is most probably always used and uses numbers below `05` in its function names so that these are called first. They set up the variable `$destdir` pointing to the root directory of the extension. It can be used to install additional content to there. As all other installation templates use numbers `10` and up, numbers `05` to `10` are recommended for this purpose.

- [install-locale](install-locale.template) installs translations from the `locale` directory in the extension root to `/usr/share/locale`. Include it whenever the extension is translated.

- [install-schemas](install-schemas.template) installs glib schema XML definitions from the extension root to their common location it also sets up the install script to `gschemas.install` when not previously defined. When using this template, link [the common installer script](../gschemas.install) into the package or provide a custom one that at least includes the same functionality, compiling the schemas on update, installation and removal. This template is appropriate to use whenever schemas are present.

- [unify-conveniencejs](unify-conveniencejs.template) links to `convenience.js` from GNOME's own extensions instead of installing a copy to the extension for the cost of being dependent of gnome-shell-extensions. This saves space and is appropriate whenever the extension source includes a file `convenience.js` similar to [the common variant](https://github.com/GNOME/gnome-shell-extensions/blob/master/lib/convenience.js).

- [github](github.template) contains a notice to this repositories location as a comment, where all the PKGBUILDs are maintained. It is intended to be placed directly under the list of maintainer and contributors to the PKGBUILD.
