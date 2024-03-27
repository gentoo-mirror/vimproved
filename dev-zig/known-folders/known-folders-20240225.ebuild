# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit zig-package

DESCRIPTION="Provides access to well-known folders across several operating systems"
HOMEPAGE="https://github.com/ziglibs/known-folders"
KNOWN_FOLDERS_COMMIT="055c95a717c5b54a0fc52ff5f370439c28eb2e73"
SRC_URI="https://github.com/ziglibs/${PN}/archive/${KNOWN_FOLDERS_COMMIT}.tar.gz -> ${PN}-${KNOWN_FOLDERS_COMMIT}.tar.gz"
S="${WORKDIR}/${PN}-${KNOWN_FOLDERS_COMMIT}"

LICENSE="MIT"
