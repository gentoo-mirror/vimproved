# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="A modern client-server application for the Soulseek file sharing network."
HOMEPAGE="https://github.com/slskd/slskd/"
SRC_URI="
	elibc_glibc? ( https://github.com/slskd/slskd/releases/download/${PV}/slskd-${PV}-linux-x64.zip )
	elibc_musl? ( https://github.com/slskd/slskd/releases/download/${PV}/slskd-${PV}-linux-musl-x64.zip )
"
S="${WORKDIR}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip test"

RDEPEND="
	acct-group/slskd
	acct-user/slskd
"
BDEPEND="app-arch/unzip"

INSTDIR="/opt/slskd"
QA_PREBUILT="${INSTDIR}/slskd"

src_install() {
	default

	exeinto "${INSTDIR}"
	doexe slskd
	insinto "${INSTDIR}"
	doins -r wwwroot
	doins -r etc
	insinto "${INSTDIR}/config"
	newins config/slskd.example.yml slskd.yml
	systemd_dounit "${FILESDIR}/slskd.service"
}
