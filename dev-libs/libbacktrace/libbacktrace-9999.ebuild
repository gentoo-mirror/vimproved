# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit flag-o-matic git-r3

DESCRIPTION="A C library to produce symbolic backtraces"
HOMEPAGE="https://github.com/ianlancetaylor/libbacktrace"
EGIT_REPO_URI="https://github.com/ianlancetaylor/libbacktrace.git"

LICENSE="BSD"
SLOT="0"

# Tests fail
RESTRICT="test"

src_configure() {
	# Configure step to determine output filetype is broken with LTO
	filter-lto

	default
}
