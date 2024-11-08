# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="A short girls love kinetic novel."
HOMEPAGE="https://foxpancakes.itch.io/its-a-promise"
SRC_URI="ItsAPromise-${PV}-pc.zip"
S="${WORKDIR}/ItsAPromise-${PV}-pc"

KEYWORDS="~amd64"

BDEPEND+=" app-arch/unzip"

RENPY_TITLE="It's A Promise"
