# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="Fast and lightweight x86/x86-64 disassembler and code generation library"
HOMEPAGE="https://zydis.re/"
SRC_URI="https://github.com/zyantific/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

IUSE="doc examples man +tools"
LICENSE="MIT"
SLOT="0/4.0"
KEYWORDS="~amd64"

RESTRICT="test"

DEPEND="dev-libs/zycore-c"
RDEPEND="${DEPEND}"
BDEPEND="
	doc? ( app-doc/doxygen )
	man? ( app-text/ronn-ng )
"

src_configure() {
	local mycmakeargs=(
		-DZYAN_SYSTEM_ZYCORE=ON
		-DZYDIS_BUILD_DOXYGEN=$(usex doc)
		-DZYDIS_BUILD_EXAMPLES=$(usex examples)
		-DZYDIS_BUILD_MAN=$(usex man)
		-DZYDIS_BUILD_SHARED_LIB=ON
		-DZYDIS_BUILD_TOOLS=$(usex tools)
	)

	cmake_src_configure
}
