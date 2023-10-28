# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Independent session/login tracker"
HOMEPAGE="https://github.com/chimera-linux/turnstile"
SRC_URI="https://github.com/chimera-linux/turnstile/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+man"

RDEPEND="
	sys-libs/pam
"
DEPEND="${RDEPEND}"
BDEPEND="
	man? ( app-text/scdoc )
"

src_configure() {
	local emesonargs=(
		# dinit is not packaged
		-Ddinit=disabled
		$(meson_use man)
	)

	meson_src_configure
}

src_install() {
	meson_src_install
	newinitd "${FILESDIR}/turnstiled.initd" turnstiled
}
