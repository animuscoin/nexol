
Debian
====================
This directory contains files used to package nexold/nexol-qt
for Debian-based Linux systems. If you compile nexold/nexol-qt yourself, there are some useful files here.

## nexol: URI support ##


nexol-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install nexol-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your nexol-qt binary to `/usr/bin`
and the `../../share/pixmaps/nexol128.png` to `/usr/share/pixmaps`

nexol-qt.protocol (KDE)

