# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="authenticating ultrapsychoinflammasis. . . ."
HOMEPAGE="https://kolulu.itch.io/operation-eventide"
SRC_URI="operation-eventide-pc.zip"
S="${WORKDIR}/OperationEventide-${PV}-pc"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch"

BDEPEND="app-arch/unzip"

PATCHES=(
	"${FILESDIR}/operation-eventide-2.0-scene-block.patch"
)
