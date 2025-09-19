# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 pypi

DESCRIPTION="Distributed self-replicating programs in Python"
HOMEPAGE="https://pypi.org/project/mitogen/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ansible test"
RESTRICT="!test? ( test )"

RDEPEND="ansible? ( app-admin/ansible[${PYTHON_USEDEP}] )"
BDEPEND="test? ( dev-python/pytest-import-check[${PYTHON_USEDEP}] )"

python_install() {
	distutils-r1_python_install

	if use ansible; then
		# Symlink strategy plugins into Ansible strategy plugins directory
		for plugin in mitogen mitogen_free mitogen_host_pinned mitogen_linear; do
			dosym \
				../../../ansible_mitogen/plugins/strategy/${plugin}.py \
				"$(python_get_sitedir)/ansible/plugins/strategy/${plugin}.py"

		done

		python_optimize "${D}/$(python_get_sitedir)/ansible/plugins/strategy/"
	fi
}

python_test() {
	local EPYTEST_IGNORE=(
		# TODO: investigate
		"${BUILD_DIR}/install$(python_get_sitedir)/ansible_mitogen/plugins/connection/mitogen_kubectl.py"
		# python2 compat module
		"${BUILD_DIR}/install$(python_get_sitedir)/mitogen/compat/pkgutil.py"
		"${BUILD_DIR}/install$(python_get_sitedir)/mitogen/imports/_py314.py"
	)

	epytest --import-check "${BUILD_DIR}/install$(python_get_sitedir)"
}
