# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Image loader and saver with support for custom IO and allocators."
HOMEPAGE="https://code.dlang.org/packages/imagefmt/"
SRC_URI="https://github.com/tjhann/imagefmt/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DLANG_PACKAGE_TYPE="single"
inherit dlang dub

src_prepare() {
	dlang_src_prepare

	sed -i "s/library/dynamicLibrary/" dub.json || die
}
