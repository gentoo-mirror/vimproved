# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="PNG encoder and decoder"
HOMEPAGE="
	http://lodev.org/lodepng
	https://github.com/lvandeve/lodepng
"
EGIT_COMMIT="c18b949b71f45e78b1f9a28c5d458bce0da505d6"
SRC_URI="https://github.com/lvandeve/lodepng/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/lodepng-${EGIT_COMMIT}"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="benchmark pngdetail showpng test"
RESTRICT="!test? ( test )"

DEPEND="
	benchmark? ( media-libs/libsdl )
	showpng? ( media-libs/libsdl )
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-makefile.patch"
)

src_compile() {
	emake liblodepng.so
	use test && emake unittest
	use benchmark && emake benchmark
	use showpng && emake showpng
	use pngdetail && emake pngdetail
}

src_install() {
	dodoc README.md
	doheader lodepng.h
	dolib.so liblodepng.so
	use showpng && dobin showpng
	use pngdetail && dobin pngdetail
	exeinto /usr/libexec/lodepng
	use benchmark && doexe benchmark
}

src_test() {
	LD_LIBRARY_PATH="${S}:${LD_LIBRARY_PATH}" ./unittest || die
}
