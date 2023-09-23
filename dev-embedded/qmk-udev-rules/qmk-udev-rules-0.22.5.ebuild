# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit udev

DESCRIPTION="udev rules for QMK's CLI"
HOMEPAGE="https://qmk.fm/"
SRC_URI="https://github.com/qmk/qmk_firmware/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
S="${WORKDIR}/qmk_firmware-${PV}"

RESTRICT="test"

src_compile() {
	:
}

src_install() {
	udev_dorules "${S}/util/udev/50-qmk.rules"
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
