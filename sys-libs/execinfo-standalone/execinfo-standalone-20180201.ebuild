# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="quick-n-dirty BSD licensed clone of backtrace facility found in glibc"
HOMEPAGE="https://github.com/resslinux/libexecinfo"
SRC_URI="https://github.com/resslinux/libexecinfo/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/libexecinfo-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	!sys-libs/glibc
"
