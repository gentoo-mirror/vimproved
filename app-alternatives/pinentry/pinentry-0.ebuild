# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ALTERNATIVES=(
	"ncurses:app-crypt/pinentry[ncurses]"
	"gtk:app-crypt/pinentry[gtk]"
	"qt5:app-crypt/pinentry[qt5]"
	"efl:app-crypt/pinentry[efl]"
	"tty:app-crypt/pinentry"
)

inherit app-alternatives

DESCRIPTION="pinentry symlinks"
KEYWORDS="~amd64"

src_install() {
	local alternative
	case $(get_alternative) in
		ncurses)
			alternative=curses
			;;
		gtk)
			alternative=gnome3
			;;
		*)
			alternative=$(get_alternative)
			;;
	esac
	dosym pinentry-${alternative} /usr/bin/pinentry
}
