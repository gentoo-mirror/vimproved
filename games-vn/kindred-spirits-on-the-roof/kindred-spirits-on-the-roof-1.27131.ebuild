# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy unpacker

DESCRIPTION="Let’s Make This a Yuritopia!"
HOMEPAGE="https://www.gog.com/en/game/kindred_spirits_on_the_roof"
SRC_URI="kindred_spirits_on_the_roof_gog_$(ver_cut 1)_$(ver_cut 2).sh"
S="${WORKDIR}/data/noarch/game/"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch"

BDEPEND="app-arch/unzip"

RENPY_TITLE="Kindred Spirits on the Roof"
RENPY_WINDOW_ICON="game/icon.png"

src_unpack() {
	unpack_zip "${DISTDIR}/${A}"
}