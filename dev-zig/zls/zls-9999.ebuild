# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ZIG_MIN="0.12"

inherit git-r3 zig-build

DESCRIPTION="A Zig language server with features like autocomplete and goto definition"
HOMEPAGE="https://install.zigtools.org/"
EGIT_REPO_URI="https://github.com/zigtools/zls.git"

LICENSE="MIT"
SLOT="0"

DEPEND="
	dev-zig/diffz:20240105
	dev-zig/known-folders:20240321
"

PATCHES=(
	"${FILESDIR}/${P}-fix-latest-zig-master.patch"
)
