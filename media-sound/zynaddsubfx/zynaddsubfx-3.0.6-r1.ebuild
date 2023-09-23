# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby31 ruby32"
inherit cmake flag-o-matic ruby-single toolchain-funcs

DESCRIPTION="Software synthesizer capable of making a countless number of instruments"
HOMEPAGE="http://zynaddsubfx.sourceforge.net/"
SRC_URI="
	mirror://sourceforge/zynaddsubfx/${P}.tar.bz2
	zyn-fusion? ( mirror://sourceforge/zynaddsubfx/zyn-fusion-ui-src-${PV}.tar.bz2 )
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+alsa doc dssi fltk jack lash portaudio +zyn-fusion"

REQUIRED_USE="|| ( alsa jack portaudio )"

BDEPEND="
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
"
DEPEND="
	dev-libs/mxml
	media-libs/liblo
	sci-libs/fftw:3.0
	sys-libs/zlib
	alsa? ( media-libs/alsa-lib )
	doc? ( dev-texlive/texlive-fontutils )
	dssi? ( media-libs/dssi )
	fltk? (
		x11-libs/fltk:1
		x11-libs/libX11
		x11-libs/libXpm
	)
	jack? ( virtual/jack )
	lash? ( media-sound/lash )
	portaudio? ( media-libs/portaudio )
	zyn-fusion? (
		dev-libs/libuv
		x11-libs/libX11
		x11-libs/libxcb
		${RUBY_DEPS}
	)
"
RDEPEND="${DEPEND}"
BDEPEND="doc? ( app-doc/doxygen )"

PATCHES=(
	"${FILESDIR}"/${P}-docs.patch
	"${FILESDIR}"/${P}-cstdint.patch
)

DOCS=( AUTHORS.txt NEWS.txt README.adoc )

src_prepare() {
	cmake_src_prepare

	if ! use dssi; then
		sed -i -e '/pkg_search_module.*DSSI/s/^/#DONT/' src/CMakeLists.txt || die
	fi
	if ! use jack; then
		sed -e '/pkg_check_modules.*JACK/s/^/#DONT/' -i {rtosc,src}/CMakeLists.txt || die
	fi
	if ! use lash; then
		sed -i -e '/pkg_search_module.*LASH/s/^/#DONT/' src/CMakeLists.txt || die
	fi
	if ! use portaudio; then
		sed -i -e '/pkg_check_modules.*PORTAUDIO/s/^/#DONT/' src/CMakeLists.txt || die
	fi

	# FIXME upstream: sandbox error
	sed -i -e '/add_subdirectory(bash-completion)/d' doc/CMakeLists.txt || die

	if use zyn-fusion; then
		# Unbundle libuv: makefile and rake file
		sed -i -e "s%./deps/\$(UV_DIR)/.libs/libuv.a%`pkg-config --libs libuv`%" \
			-e 's%-I ../../deps/\$(UV_DIR)/include%-I /usr/include/uv/%' \
			"${WORKDIR}/zyn-fusion-ui-src-${PV}/Makefile"
		sed -i -e "/deps\/libuv.a/s/<< .*/<< \"`pkg-config --libs libuv`\"/" \
			-e 's%../deps/libuv-v1.9.1/include/%usr/include/uv/%' \
			"${WORKDIR}/zyn-fusion-ui-src-${PV}/build_config.rb"
		LD="$(tc-getCC)"
	fi
}

src_configure() {
	local UI
	use fltk && UI=fltk
	use zyn-fusion && UI=zest
	append-cxxflags -std=c++11

	local mycmakeargs=(
		-DPluginLibDir=$(get_libdir)
		-DGuiModule=${UI}
		$(cmake_use_find_package alsa Alsa)
		$(cmake_use_find_package doc Doxygen)
		$(cmake_use_find_package fltk FLTK)
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	use doc && cmake_src_compile doc

	if use zyn-fusion; then
		emake -C "${WORKDIR}/zyn-fusion-ui-src-${PV}"
		emake pack -C "${WORKDIR}/zyn-fusion-ui-src-${PV}"
	fi
}

src_install() {
	use doc && local HTML_DOCS=( "${BUILD_DIR}"/doc/html/. )
	cmake_src_install
	insinto /usr/share/${PN}
	doins -r instruments/*

	if use zyn-fusion; then
		exeinto /opt/zyn-fusion
		doexe "${WORKDIR}/zyn-fusion-ui-src-${PV}/package/zest"
		dodir /usr/bin
		dosym ../../opt/zyn-fusion/zest /usr/bin/zyn-fusion

		insinto /opt/zyn-fusion
		doins -r "${WORKDIR}/zyn-fusion-ui-src-${PV}/package/font" \
			"${WORKDIR}/zyn-fusion-ui-src-${PV}/package/qml" \
			"${WORKDIR}/zyn-fusion-ui-src-${PV}/package/schema" \
			"${WORKDIR}/zyn-fusion-ui-src-${PV}/package/libzest.so"
	fi
}
