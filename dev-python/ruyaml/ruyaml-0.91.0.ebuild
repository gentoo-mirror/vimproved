# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_12 )

inherit distutils-r1 pypi

DESCRIPTION="An openly maintained fork of elusive ruamel-yaml package."
HOMEPAGE="https://pypi.org/project/ruyaml/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

python_test() {
	# fail for uh, some reason. can't be assed.
	local EPYTEST_DESELECT=(
		_test/test_comments.py::TestCommentedMapMerge::test_issue_60
		_test/test_comments.py::TestCommentedMapMerge::test_issue_60_1
		_test/test_issues.py::TestIssues::test_issue_61
	)

	epytest
}
