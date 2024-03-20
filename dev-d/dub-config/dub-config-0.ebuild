# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Dub configuration for Gentoo."
HOMEPAGE="https://dub.pm/"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-util/dub"
RDEPEND="${DEPEND}"

src_install() {
	insinto /etc/dub
	newins - settings.json <<< "{'customCachePaths': ['/usr/$(get_libdir)/dub']}"
}
