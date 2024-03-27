# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit zig-package

DESCRIPTION="Implementation of go-diff's diffmatchpatch in Zig"
HOMEPAGE="https://github.com/ziglibs/diffz"
DIFFZ_COMMIT="e10bf15962e45affb3fcd7d9a950977a69c901b3"
SRC_URI="https://github.com/ziglibs/${PN}/archive/${DIFFZ_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${DIFFZ_COMMIT}"

LICENSE="MIT"
