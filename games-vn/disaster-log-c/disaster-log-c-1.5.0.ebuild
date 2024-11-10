# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="It has been raining ceaselessly for 7 days..."
HOMEPAGE="https://sofdelux.itch.io/disaster-log-c"
SRC_URI="disasterlogC-${PV}-pc.zip"
S="${WORKDIR}/disasterlogC-${PV}-pc"

KEYWORDS="~amd64"

BDEPEND+=" app-arch/unzip"

RENPY_TITLE="Disaster Log C"