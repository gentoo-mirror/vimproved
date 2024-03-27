# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit zig-package

DESCRIPTION="Implementation of go-diff's diffmatchpatch in Zig"
HOMEPAGE="https://github.com/ziglibs/diffz"
DIFFZ_COMMIT="90353d401c59e2ca5ed0abe5444c29ad3d7489aa"
SRC_URI="https://github.com/ziglibs/${PN}/archive/${DIFFZ_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${DIFFZ_COMMIT}"

LICENSE="MIT"
