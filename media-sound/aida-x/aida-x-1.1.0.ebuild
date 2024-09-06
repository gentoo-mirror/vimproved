# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="AIDA-X, an Amp Model Player leveraging AI"
HOMEPAGE="https://aida-x.cc/"
SRC_URI="https://github.com/AidaDSP/AIDA-X/releases/download/${PV}/AIDA-X-${PV}-src.tar.xz -> ${P}.tar.xz"
S="${WORKDIR}/AIDA-X-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	media-libs/libglvnd
	media-libs/libpulse
	media-libs/libsdl2
	sys-apps/dbus
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrandr
"
RDEPEND="${DEPEND}"

src_configure() {
	append-ldflags -Wl,--undefined-version

	cmake_src_configure
}

src_install() {
	default

	dobin "${BUILD_DIR}/bin/AIDA-X"
	into "/usr/$(get_libdir)/vst/"
	dolib.so "${BUILD_DIR}/bin/AIDA-X-vst2.so"
	insinto "/usr/$(get_libdir)/clap/"
	doins "${BUILD_DIR}/bin/AIDA-X.clap"
	insinto "/usr/$(get_libdir)/lv2/"
	doins -r "${BUILD_DIR}/bin/AIDA-X.lv2"
	insinto "/usr/$(get_libdir)/vst3/"
	doins -r "${BUILD_DIR}/bin/AIDA-X.vst3"
}
