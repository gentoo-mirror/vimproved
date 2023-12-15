# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="FNA3D - 3D Graphics Library for FNA"
HOMEPAGE="https://fna-xna.github.io/"
MOJOSHADER_COMMIT="8b81b66e96a91115f749e1bae30a5d651ca7e02a"
SRC_URI="
	https://github.com/FNA-XNA/FNA3D/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/icculus/mojoshader/archive/8b81b66e96a91115f749e1bae30a5d651ca7e02a.tar.gz
		-> mojoshader-${MOJOSHADER_COMMIT}.tar.gz
"
S="${WORKDIR}/FNA3D-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-libs/libsdl2"
DEPEND="
	${RDEPEND}
	dev-util/vulkan-headers
"

src_prepare() {
	# Move unpacked MojoShader
	rm -rf MojoShader || die
	mv "${WORKDIR}/mojoshader-${MOJOSHADER_COMMIT}" MojoShader || die

	cmake_src_prepare
}

src_install() {
	dolib.so "${BUILD_DIR}/libFNA3D.so.0.$(ver_cut 1-2)"
	dosym libFNA3D.so.0.$(ver_cut 1-2) /usr/$(get_libdir)/libFNA3D.so.0
	dosym libFNA3D.so.0 /usr/$(get_libdir)/libFNA3D.so
	einstalldocs
}
