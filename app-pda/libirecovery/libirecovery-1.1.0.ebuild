# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit autotools udev

DESCRIPTION="Library and utility to talk to iBoot/iBSS via USB"
HOMEPAGE="https://libimobiledevice.org/"
SRC_URI="https://github.com/libimobiledevice/libirecovery/releases/download/${PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-pda/libimobiledevice-glue
	sys-libs/readline
	virtual/libusb
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default
	eautoreconf
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
