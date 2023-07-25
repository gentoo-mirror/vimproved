# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="The Cloud Native Application Proxy"
HOMEPAGE="https://traefik.io/"
SRC_URI="https://github.com/traefik/traefik/releases/download/v${PV}/${PN}-v${PV}.src.tar.gz"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build
}

src_install() {
	dobin "${S}/traefik"
}
