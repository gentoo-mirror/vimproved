# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Soho vibes for GTK"
HOMEPAGE="https://github.com/rose-pine/gtk/"
SRC_URI="
	https://github.com/rose-pine/gtk/releases/download/v${PV}/gtk3.tar.gz -> rose-pine-gtk3-${PV}.tar.gz
	https://github.com/rose-pine/gtk/releases/download/v${PV}/gtk4.tar.gz -> rose-pine-gtk4-${PV}.tar.gz
"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	for variant in rose-pine rose-pine-dawn rose-pine-moon; do
		mkdir gtk3/${variant}-gtk/gtk-4.0 || die
		cp gtk4/${variant}.css gtk3/${variant}-gtk/gtk-4.0/gtk.css || die
	done

	default
}

src_install() {
	insinto /usr/share/themes
	doins -r gtk3/rose-pine-gtk
	doins -r gtk3/rose-pine-dawn-gtk
	doins -r gtk3/rose-pine-moon-gtk
}
