# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Dummy libtool package providing symlinks to dev-build/slibtool."
HOMEPAGE="https://dev.midipix.org/cross/slibtool"
S="${WORKDIR}"

LICENSE="metapackage"
SLOT="2"

DEPEND="dev-build/slibtool"
RDEPEND="${DEPEND}"

src_install() {
	dosym slibtool /usr/bin/libtool
	dosym slibtoolize /usr/bin/libtoolize
}
