# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Building blocks for creating custom desktop shells"
HOMEPAGE="https://aylur.github.io/astal/"
ASTAL_COMMIT="7d28889727b80e0a68c20c2f0f1926ddc96a7be6"
SRC_URI="https://github.com/Aylur/astal/archive/${ASTAL_COMMIT}.tar.gz
	-> astal-${ASTAL_COMMIT}.tar.gz"
S="${WORKDIR}/astal-${ASTAL_COMMIT}/lang/gjs"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

DEPEND="
	dev-libs/gjs
	dev-libs/glib:2
	~gui-libs/astal-${PV}
	~gui-libs/astal-io-${PV}
"
RDEPEND="${DEPEND}"
