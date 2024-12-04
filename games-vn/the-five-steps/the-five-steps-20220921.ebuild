# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="magical girl helps burnt out high school student graduate?"
HOMEPAGE="https://milkkylemon.itch.io/the-five-steps"
SRC_URI="magicalgirl-linux.tar.bz2"
S="${WORKDIR}/magicalgirl-linux"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch"

RENPY_TITLE="The Five Steps To Ensuring Momo Graduates Successfully!!!"
