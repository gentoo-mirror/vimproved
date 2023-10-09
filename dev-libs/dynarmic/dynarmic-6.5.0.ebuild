# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="An ARM dynamic recompiler."
HOMEPAGE="https://github.com/merryhime/dynarmic"
SRC_URI="https://github.com/merryhime/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-cpp/robin-map
	>=dev-libs/boost-1.57
	>=dev-libs/libfmt-9:=
	dev-libs/mcl
	>=dev-libs/xbyak-6
	>=dev-libs/zydis-4
"
DEPEND="${RDEPEND}"
BDPENED="test? ( >=dev-cpp/catch-3 )"

src_prepare() {
	# Remove bundled dependencies
	for dep in catch fmt mcl robin-map xbyak zycore zydis; do
		rm -rf "externals/${dep}" || die
	done

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DDYNARMIC_TESTS=$(usex test)
		-DDYNARMIC_WARNINGS_AS_ERRORS=OFF
	)

	cmake_src_configure
}
