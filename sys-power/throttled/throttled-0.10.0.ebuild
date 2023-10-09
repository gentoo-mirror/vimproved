# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
inherit python-single-r1 systemd

DESCRIPTION="Workaround for Intel throttling issues in Linux."
HOMEPAGE="https://github.com/erpalma/throttled"
SRC_URI="https://github.com/erpalma/throttled/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/dbus-python[${PYTHON_USEDEP}]
		dev-python/pygobject[${PYTHON_USEDEP}]
	')
	sys-apps/pciutils
"

src_install() {
	default
	python_newscript throttled.py throttled
	python_domodule mmio.py
	doinitd "${FILESDIR}/throttled"
	systemd_dounit "${FILESDIR}/throttled.service"
	insinto /etc
	doins etc/throttled.conf
}
