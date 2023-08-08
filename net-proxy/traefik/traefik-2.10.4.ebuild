# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

DESCRIPTION="The Cloud Native Application Proxy"
HOMEPAGE="https://traefik.io/"
SRC_URI="https://github.com/traefik/traefik/releases/download/v${PV}/${PN}-v${PV}.src.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	acct-group/traefik
	acct-user/traefik
"
RDEPEND="${DEPEND}"

src_configure() {
	ego generate -v
}

src_compile() {
	ego build ./cmd/traefik
}

src_install() {
	dobin "${S}/traefik"
	systemd_dounit "${FILESDIR}/traefik.service"
	newinitd "${FILESDIR}/traefik.initd" traefik
	newconfd "${FILESDIR}/traefik.confd" traefik
	insopts "-m644 -o traefik -g traefik"
	insinto /etc/traefik
	doins "${FILESDIR}/traefik.toml"
}