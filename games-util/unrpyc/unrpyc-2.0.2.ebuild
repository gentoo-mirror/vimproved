# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{13..14} )

inherit distutils-r1

DESCRIPTION="A ren'py script decompiler"
HOMEPAGE="https://github.com/CensoredUsername/unrpyc"
SRC_URI="https://github.com/CensoredUsername/unrpyc/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

python_install() {
	python_domodule decompiler
	python_domodule deobfuscate.py
	python_newscript unrpyc.py unrpyc
}

distutils_enable_tests import-check
