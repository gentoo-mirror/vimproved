# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop xdg

DESCRIPTION="A 2D game about building and maintaining factories."
HOMEPAGE="https://factorio.com/download"
SRC_URI="${PN}_alpha_x64_${PV}.tar.xz"
S="${WORKDIR}/${PN}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="doc"
RESTRICT="bindist fetch splitdebug"

QA_PREBUILT="/usr/bin/${PN}"

RDEPEND="
	media-libs/alsa-lib
	media-libs/mesa
	x11-libs/libXcursor
	x11-libs/libXinerama
	x11-libs/libXrandr
"

pkg_nofetch() {
	einfo "Please buy and download ${SRC_URI} from:"
	einfo "  ${HOMEPAGE}"
	einfo "and move it to your distfiles directory."
}

src_install() {
	insinto "/usr/share/factorio"
	doins -r data/*

	dobin bin/x64/factorio

	use doc && dodoc -r doc-html/*

	doicon -s 128 data/core/graphics/factorio.png
	make_desktop_entry ${PN} Factorio
}
