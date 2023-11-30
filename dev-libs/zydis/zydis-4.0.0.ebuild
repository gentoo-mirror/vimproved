# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Fast and lightweight x86/x86-64 disassembler and code generation library"
HOMEPAGE="https://zydis.re/"
SRC_URI="https://github.com/zyantific/zydis/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"
RESTRICT="test"

RDEPEND="dev-libs/zycore-c"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DZYAN_SYSTEM_ZYCORE=ON
		-DZYDIS_BUILD_EXAMPLES=$(usex examples)
		-DZYDIS_BUILD_SHARED_LIB=ON
	)

	cmake_src_configure
}
