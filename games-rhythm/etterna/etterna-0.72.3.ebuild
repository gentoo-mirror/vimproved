# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop flag-o-matic

DESCRIPTION="Advanced cross-platform rhythm game focused on keyboard play"
HOMEPAGE="https://etternaonline.com/"
SRC_URI="https://github.com/etternagame/etterna/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/openssl:=
	media-libs/glu
	media-libs/libglvnd
	media-libs/libpulse
	virtual/jack
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrandr
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-root-dir-env.patch"
)

src_configure() {
	append-cppflags -DASIO_HAS_STD_INVOKE_RESULT

	local mycmakeargs=(
		-DWITH_CRASHPAD=OFF
		-DINSTALL_DIR="$(get_libdir)/Etterna"
		-DASSET_DIR="share/Etterna"
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	local suffix
	case "${CMAKE_BUILD_TYPE}" in
		Debug)
			suffix="-debug"
			;;
		MinSizeRel)
			suffix="-MinSizeRelease"
			;;
		RelWithDebInfo)
			suffix="-RelWithDebInfo"
			;;
		*)
			suffix=""
			;;
	esac

	newbin - Etterna <<-EOF
		#!/bin/sh
		export ETTERNA_ROOT_DIR="\${HOME}/.local/share/Etterna"
		export ETTERNA_ADDITIONAL_ROOT_DIRS="${EPREFIX}/usr/share/Etterna"
		exec ${EPREFIX}/usr/$(get_libdir)/Etterna/Etterna${suffix}
	EOF

	# work around attempt to write logs to Etterna INSTALL_DIR
	fperms -R 555 /usr/$(get_libdir)/Etterna/

	doicon "${FILESDIR}/Etterna.png"
	newmenu "${S}/CMake/CPack/Linux/stepmania.desktop" Etterna.desktop
}
