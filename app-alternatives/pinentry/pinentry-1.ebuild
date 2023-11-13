# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ALTERNATIVES=(
	"pinentry-curses:app-crypt/pinentry[ncurses]"
	"pinentry-gnome3:app-crypt/pinentry[gtk]"
	"pinentry-qt5:app-crypt/pinentry[qt5]"
	"pinentry-efl:app-crypt/pinentry[efl]"
	"pinentry-tty:app-crypt/pinentry"
)

inherit app-alternatives

DESCRIPTION="pinentry symlinks"
KEYWORDS="~amd64"

src_install() {
	dosym $(get_alternative) /usr/bin/pinentry
}
