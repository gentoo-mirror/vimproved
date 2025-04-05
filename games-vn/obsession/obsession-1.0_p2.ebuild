# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="A yandere yuri VN about being a witch's obedient pet."
HOMEPAGE="https://ebihime.itch.io/obsession"
SRC_URI="Theendofanobsession-$(ver_cut 1-2)-pc.zip"
S="${WORKDIR}/Theendofanobsession-$(ver_cut 1-2)-pc/"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch"

BDEPEND="app-arch/unzip"
