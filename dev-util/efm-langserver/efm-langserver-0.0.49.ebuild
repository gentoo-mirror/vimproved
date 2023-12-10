# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="General purpose Language Server"
HOMEPAGE="https://github.com/mattn/efm-langserver"
SRC_URI="
	https://github.com/mattn/efm-langserver/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://codeberg.org/vimproved/go-deps/releases/download/${P}/${P}-deps.tar.xz
"

LICENSE="Apache-2.0 BSD MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build
}

src_install() {
	dobin efm-langserver
	einstalldocs
}
