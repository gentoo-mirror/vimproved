# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="One choice. With her or without."
HOMEPAGE="https://yukimisoft.itch.io/if-you-stay"
SRC_URI="thegamename-${PV}-linux.tar.bz2"
S="${WORKDIR}/thegamename-${PV}-linux"

KEYWORDS="~amd64"

RENPY_TITLE="If You Stay"