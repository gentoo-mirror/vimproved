# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="[[>SCRUB AWAY THE GUILT<]]"
HOMEPAGE="https://throwpup.itch.io/idni"
SRC_URI="IdandI-${PV}-linux.tar.bz2"
S="${WORKDIR}/IdandI-${PV}-linux"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="fetch mirror"
