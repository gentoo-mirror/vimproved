# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Scaffolding CLI for Astal+TypeScript"
HOMEPAGE="https://aylur.github.io/ags/"
SRC_URI="https://github.com/Aylur/ags/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://distfiles.vimproved.dev/${P}-deps.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="
	dev-lang/sassc
	dev-util/blueprint-compiler
	gui-libs/astal
	gui-libs/astal-gjs
"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	# use sassc instead of dart-sass (unpackaged)
	sed -i 's/Exec("sass"/Exec("sassc"/' lib/esbuild.go || die "sed failed"
	default
}

src_compile() {
	ego build -ldflags "\
		-X 'main.gtk4LayerShell=${EPREFIX}/usr/$(get_libdir)/libgtk4-layer-shell.so'
		-X 'main.astalGjs=${EPREFIX}/usr/share/astal/gjs'"
}

src_install() {
	dobin ags
	default
}
