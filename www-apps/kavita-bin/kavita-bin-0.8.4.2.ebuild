# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="Kavita is a fast, feature rich, cross platform reading server."
HOMEPAGE="https://www.kavitareader.com/"
SRC_URI="
	elibc_glibc? (
		https://github.com/Kareadita/Kavita/releases/download/v${PV}/kavita-linux-x64.tar.gz -> ${P}.tar.gz
	)
	elibc_musl? (
		https://github.com/Kareadita/Kavita/releases/download/v${PV}/kavita-linux-musl-x64.tar.gz -> ${P}.tar.gz
	)
"
S="${WORKDIR}/Kavita"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="mirror test"

DEPEND="acct-user/kavita"
RDEPEND="${DEPEND}"
BDEPEND="acct-user/kavita"

INST_DIR="/opt/kavita"
QA_PREBUILT="${INST_DIR#/}/*.so* ${INST_DIR#/}/Kavita ${INST_DIR#/}/createdump"

src_install() {
	insinto "${INST_DIR}"
	dodir "${INST_DIR}"
	doins -r "${S}"/*
	chmod 755 "${D}${INST_DIR}/Kavita"
	systemd_dounit "${FILESDIR}/kavita.service"
	newbin "${FILESDIR}/kavita-wrapper" kavita
}
