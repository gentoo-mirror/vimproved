# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake llvm llvm.org

DESCRIPTION="LLVM Framework for High-Level Loop and Data-Locality Optimizations"
HOMEPAGE="https://polly.llvm.org/"

IUSE="static-libs"
LICENSE="Apache-2.0-with-LLVM-exceptions"
SLOT="17"
KEYWORDS="~amd64"

LLVM_MAX_SLOT="${SLOT}"
LLVM_COMPONENTS=( polly cmake )
llvm.org_set_globals

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr/lib/llvm/${LLVM_MAJOR}"
		-DBUILD_SHARED_LIBS=OFF
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
	if ! use static-libs; then
		rm "${ED}/usr/lib/llvm/${LLVM_MAJOR}/$(get_libdir)/libPolly.a" || die
		rm "${ED}/usr/lib/llvm/${LLVM_MAJOR}/$(get_libdir)/libPollyISL.a" || die
	fi
}
