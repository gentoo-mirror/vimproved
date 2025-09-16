# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="In the middle of a field, far out in the countryside, sits a lone manor."
HOMEPAGE="https://twoandahalfstudios.itch.io/amelie"
SRC_URI="Amelie.zip"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch"

BDEPEND="app-arch/unzip"
