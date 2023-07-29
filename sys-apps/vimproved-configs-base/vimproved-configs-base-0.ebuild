# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo

DESCRIPTION="My base system-level config files."
HOMEPAGE="https://codeberg.org/vimproved"
LICENSE="MIT"
S="${WORKDIR}"

SLOT="0"
KEYWORDS="~amd64"
IUSE="+nvim-fennel"

BDEPEND="nvim-fennel? ( dev-lang/fennel )"

src_compile() {
	use nvim-fennel &&
		edo fennel --compile "${FILESDIR}/tangerine.fnl" > tangerine.lua
}

src_install() {
	insinto /etc/xdg/nvim/plugin
	use nvim-fennel && doins tangerine.lua
}
