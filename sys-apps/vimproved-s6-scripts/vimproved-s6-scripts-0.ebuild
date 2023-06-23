# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Helper scripts for an s6 and s6-rc based init system."
HOMEPAGE="https://codeberg.org/vimproved"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
S="${WORKDIR}"

RDEPEND="
	sys-apps/s6-rc
"

src_install() {
	dobin "${FILESDIR}/s6-rc-db-rebuild"
}
