# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="authenticating ultrapsychoinflammasis. . . ."
HOMEPAGE="https://kolulu.itch.io/operation-eventide"
SRC_URI="operation-eventide-pc.zip"
S="${WORKDIR}/OperationEventide-${PV}-pc"

KEYWORDS="~amd64"

BDEPEND+=" app-arch/unzip"

PATCHES=(
	"${FILESDIR}/operation-eventide-1.3-scene-block.patch"
)

RENPY_TITLE="Operation Eventide"
