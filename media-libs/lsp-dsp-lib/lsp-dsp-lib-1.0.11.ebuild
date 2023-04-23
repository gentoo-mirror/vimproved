# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="DSP library for signal processing"
HOMEPAGE="https://github.com/lsp-plugins/lsp-dsp-lib"
SRC_URI="
	https://github.com/lsp-plugins/lsp-dsp-lib/releases/download/${PV}/lsp-dsp-lib-src-${PV}.tar.gz -> ${P}.tar.gz
"
S="${WORKDIR}/${PN}"

LICENSE="LGPL-3 GPL-3"
SLOT="0"
KEYWORDS="~amd64"

src_configure() {
	emake PREFIX="/usr" LIBDIR="$(get_libdir)" config
}
