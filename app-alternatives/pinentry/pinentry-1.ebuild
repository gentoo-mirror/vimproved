# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ALTERNATIVES=(
	"curses:app-crypt/pinentry[ncurses]"
	"gnome3:app-crypt/pinentry[gtk]"
	"qt5:app-crypt/pinentry[qt5]"
	"efl:app-crypt/pinentry[efl]"
	"tty:app-crypt/pinentry"
)

inherit app-alternatives

DESCRIPTION="pinentry symlinks"
KEYWORDS="~amd64"

src_install() {
	dosym pinentry-$(get_alternative) /usr/bin/pinentry
}
