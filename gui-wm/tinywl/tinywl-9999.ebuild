# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An extremely minimal example compositor for wlroots"
HOMEPAGE="https://gitlab.freedesktop.org/wlroots/wlroots"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://gitlab.freedesktop.org/wlroots/wlroots.git"
	inherit git-r3
else
	SRC_URI="https://gitlab.freedesktop.org/wlroots/wlroots/-/releases/${PV}/downloads/wlroots-${PV}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
	S="${WORKDIR}/wlroots-${PV}"
fi
S="${S}/tinywl"

LICENSE="MIT"
SLOT="0"

DEPEND="~gui-libs/wlroots-${PV}"
RDEPEND="
	${DEPEND}
	!gui-libs/wlroots:0[tinywl]
"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/tinywl-9999-update-for-versioned-pkg-config-file.patch"
)

src_install() {
	einstalldocs
	dobin tinywl
}
