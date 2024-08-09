# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Soho vibes for GTK"
HOMEPAGE="https://github.com/rose-pine/gtk/"
SRC_URI="
	https://github.com/rose-pine/gtk/releases/download/v${PV}/rose-pine-icons.tar.gz
		-> rose-pine-icons-${PV}.tar.gz
	https://github.com/rose-pine/gtk/releases/download/v${PV}/rose-pine-dawn-icons.tar.gz
		-> rose-pine-dawn-icons-${PV}.tar.gz
	https://github.com/rose-pine/gtk/releases/download/v${PV}/rose-pine-moon-icons.tar.gz
		-> rose-pine-moon-icons-${PV}.tar.gz
"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	insinto /usr/share/
	doins -r icons/
}
