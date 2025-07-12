# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="Shoko makes managing your anime collection effortless."
HOMEPAGE="https://shokoanime.com/"
SRC_URI="https://github.com/ShokoAnime/ShokoServer/releases/download/v${PV}/Shoko.CLI_Framework_any-x64.zip -> ${P}.zip"
S="${WORKDIR}/net8.0/linux-x64/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="mirror test"

DEPEND="acct-user/shoko"
RDEPEND="${DEPEND}"
BDEPEND="
	acct-user/shoko
	app-arch/unzip
"

INST_DIR="/opt/shoko"
QA_PREBUILT="${INST_DIR#/}/*.so* ${INST_DIR#/}/Shoko.CLI ${INST_DIR#/}/publish/*.so* ${INST_DIR#/}/publish/Shoko.CLI"

src_install() {
	insinto "${INST_DIR}"
	dodir "${INST_DIR}"
	doins -r "${S}"/*
	fperms 755 "${INST_DIR}/publish/Shoko.CLI"
	systemd_dounit "${FILESDIR}/shokoserver.service"
}
