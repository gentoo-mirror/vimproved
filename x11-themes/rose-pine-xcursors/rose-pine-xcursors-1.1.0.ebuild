# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Soho vibes for Cursors"
HOMEPAGE="https://rosepinetheme.com/themes/cursor/"
SRC_URI="
	https://github.com/rose-pine/cursor/releases/download/v${PV}/BreezeX-RosePine-Linux.tar.xz
		-> BreezeX-RosePine-Linux-${PV}.tar.xz
	https://github.com/rose-pine/cursor/releases/download/v${PV}/BreezeX-RosePineDawn-Linux.tar.xz
		-> BreezeX-RosePineDawn-Linux-${PV}.tar.xz
"
S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

src_install() {
	insinto /usr/share/icons
	doins -r BreezeX-RosePine-Linux/
	doins -r BreezeX-RosePineDawn-Linux/
}
