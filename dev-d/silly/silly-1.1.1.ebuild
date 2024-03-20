# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Better test runner for D"
HOMEPAGE="https://code.dlang.org/packages/silly"
SRC_URI="https://gitlab.com/AntonMeep/silly/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DLANG_PACKAGE_TYPE="single"
inherit dub

src_compile() {
	:
}
