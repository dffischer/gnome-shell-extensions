# Contributing

Contributions are very welcome. If you want to use the templates to package other extensions, feel free to fork this repository and add them. Pull requests are much appreciated.

Simple version updates are only checked in on important upstream changes. Please leave all templates unexpanded (as `template input` instead of `template begin` and `template and`) to avoid cluttered and redundant code. To ease your work, you may use [makepkg-expanded](https://github.com/dffischer/makepkg-expanded), which can build and distribute the packages without expanding their templates.

The [makepkg-template for git packages](https://github.com/dffischer/git-makepkg-template) are needed to expand all the templates used herein. [Install them globally](https://aur.archlinux.org/packages/git-makepkg-template-git/) or copy them into the [makepkg-templates directory](makepkg-templates) after cloning.


## GNOME Shell Updates

Every time a new stable GNOME version is shipped out, many extensions become outdated and unusable. This repository has good experience in handling this using the following process.

1. Some developers may update their extensions even before the new stable version hits the Arch Linux repositories. These should already be shipped out through regular releases. If the extension repository does not use version numbers or count releases at all, this is a good opportunity to update the package to new revision. <a name="update">These commits are usually called *propagate upstream update*, their content explaining significant changes since the previous revision shipped out to the AUR.</a>

2. Often, extensions are already compatible, but not tested or declared that way. They just need to have the new version added to the *shell-version* array in their `metadata.json` file. Do so manually or temporarily replace the inclusion of the [find-version](makepkg-templates/find-version.template) template with the [adjust-version](makepkg-templates/adjust-version.template) template - [customizepkg](https://github.com/ava1ar/customizepkg) helps a great deal here, especially when combined with [yaourt](https://github.com/archlinuxfr/yaourt) - and test if the extension can be loaded and core functionality works. If it does, notify the maintainer of the extension about this - most probably via a GitHub pull request.

3. Wait a few day for the pull request to be merged.

4. If the pull request is accepted, it can be shipped out immediately as an update just like in <a href="#user-content-update">(1)</a>.

If it is not answered after a reasonable long time, the extension does not fail to work in your daily use or other users report that this is the case, an update may be shipped out by pointing the source array to the fork. Do not forget to switch back once the original maintainer makes a decision to not miss any updates.

If the pull request is rejected or not answered until the next GNOME version despite it at least partially working fine, you can consider to ship the extension with forged compatibility by utilizing the [adjust-version](makepkg-templates/adjust-version.template) template. [A notice about this should inform users on installation.](notice.install)
