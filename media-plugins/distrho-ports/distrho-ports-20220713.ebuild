# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Linux ports of Distrho plugins"
HOMEPAGE="https://github.com/DISTRHO/DISTRHO-Ports"
EGIT_REPO_URI="https://github.com/DISTRHO/DISTRHO-Ports"
DISTRHO_PORTS_COMMIT="f2dbaded0a05732e3499fa374a586e5b32370da5"
SRC_URI="https://github.com/DISTRHO/DISTRHO-Ports/archive/${DISTRHO_PORTS_COMMIT}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"
S="${WORKDIR}/DISTRHO-Ports-${DISTRHO_PORTS_COMMIT}"
LICENSE="GPL-2"
SLOT="0"
RESTRICT="mirror"

IUSE="lv2 vst"
REQUIRED_USE="|| ( lv2 vst )"

RDEPEND="media-libs/alsa-lib
	media-libs/freetype
	virtual/opengl
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXcursor
	x11-libs/libXrender"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-20220713-clang.patch"
	"${FILESDIR}/${PN}-20220713-musl.patch"
	"${FILESDIR}/${PN}-20220713-musl-1.2.4.patch"
)

src_prepare() {
	# Remove stripping of binaries
	sed -i -e "/'-Wl,--strip-all',/d" meson.build || die "sed failed"

	# Remove hardcoded O3 CFLAG
	sed -i -e "s/'-O3', //" meson.build || die "sed failed"

	default
}

src_configure() {
	local emesonargs=(
		-Doptimizations=false
		$(meson_use vst build-vst2)
		$(meson_use vst build-vst3)
		$(meson_use lv2 build-lv2)
	)
	meson_src_configure
}
