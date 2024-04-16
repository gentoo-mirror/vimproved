# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..12} )
inherit desktop python-single-r1 xdg

DESCRIPTION="A short yuri Visual Novel set in the American Southwest."
HOMEPAGE="https://vnstudioelan.itch.io/highway-blossoms"
SRC_URI="${PN}-unified-zip.zip"
S="${WORKDIR}/Highway Blossoms ${PV} - Unified"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="bindist fetch splitdebug"

QA_PREBUILT="/opt/${PN}/*"

RDEPEND="
	games-engines/renpy[${PYTHON_SINGLE_USEDEP}]
	${PYTHON_DEPS}
"
BDEPEND="app-arch/unzip"

pkg_nofetch() {
	einfo "Please buy and download ${SRC_URI} from:"
	einfo " ${HOMEPAGE}"
	einfo "and move it to your distfiles directory"
}

src_unpack() {
	default
	unpack "${WORKDIR}"/*.zip
}

src_install() {
	insinto /opt/${PN}
	doins -r game

	dosym ../../usr/lib/${EPYTHON}/site-packages/renpy /opt/${PN}/renpy
	dosym ../../usr/lib/python-exec/${EPYTHON}/renpy /opt/${PN}/${PN}

	newbin - ${PN} <<-EOF
		#!/bin/sh
		exec /opt/${PN}/${PN}
	EOF

	newicon -s 256 game/AppIcon.png ${PN}.png
	make_desktop_entry ${PN} "Highway Blossoms"
}
