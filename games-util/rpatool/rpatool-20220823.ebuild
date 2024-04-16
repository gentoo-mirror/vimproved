# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..12} )
inherit python-single-r1

DESCRIPTION="A tool to work with Ren'Py archives."
HOMEPAGE="https://github.com/Shizmob/rpatool"
SRC_URI="https://github.com/shizmob/rpatool/raw/74f26d5dfdd645483e02552aa766ca447ad6b191/rpatool -> ${P}"
S="${WORKDIR}"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}"

src_install() {
	python_newscript "${DISTDIR}/${P}" ${PN}
}
