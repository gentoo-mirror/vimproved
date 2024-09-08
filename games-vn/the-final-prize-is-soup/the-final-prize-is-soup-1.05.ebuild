# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit desktop python-single-r1 xdg

DESCRIPTION="A survival-horror yuri visual novel."
HOMEPAGE="https://4noki.itch.io/the-final-prize-is-soup"
SRC_URI="the-final-prize-is-soup-win-linux.zip"
S="${WORKDIR}/finalsoup-${PV}-pc"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="bindist fetch splitdebug test"

QA_PREBUILT="/opt/${PN}/*"

RDEPEND="
	games-engines/renpy[${PYTHON_SINGLE_USEDEP}]
	${PYTHON_DEPS}
"
BDEPEND="
	app-arch/unzip
	games-util/rpatool
"

pkg_nofetch() {
	einfo "Please download ${SRC_URI} from:"
	einfo " ${HOMEPAGE}"
	einfo "and move it to your distfiles directory"
}

src_install() {
	mkdir "${T}/unpacked" || die
	pushd "${T}/unpacked" || die
	rpatool -x "${S}/game/archive.rpa" || die
	popd || die

	insinto /opt/${PN}
	doins -r game

	dosym ../../usr/lib/${EPYTHON}/site-packages/renpy /opt/${PN}/renpy
	dosym ../../usr/lib/python-exec/${EPYTHON}/renpy /opt/${PN}/${PN}

	newbin - ${PN} <<-EOF
		#!/bin/sh
		exec /opt/${PN}/${PN}
	EOF

	newicon -s 256 "${T}/unpacked/gui/window_icon.png" ${PN}.png
	make_desktop_entry ${PN} "The Final Prize is Soup"
}
