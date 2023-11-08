# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Deep ghidra decompiler and sleigh disassembler integration for rizin"
HOMEPAGE="https://github.com/rizinorg/rz-ghidra"
SRC_URI="https://github.com/rizinorg/rz-ghidra/releases/download/v${PV}/rz-ghidra-src-v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/rz-ghidra"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+cutter"

RDEPEND="
	dev-util/rizin
	cutter? ( dev-util/cutter )
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_CUTTER_PLUGIN=$(usex cutter)
		-DCUTTER_INSTALL_PLUGDIR=/usr/share/rizin/cutter/plugins/native
	)

	# Causes build failure in ghidra. Will be fixed upstream in next release.
	filter-flags "-march=*"

	cmake_src_configure
}
