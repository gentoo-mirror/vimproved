# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit zig-package

DESCRIPTION="Provides access to well-known folders across several operating systems"
HOMEPAGE="https://github.com/ziglibs/known-folders"
KNOWN_FOLDERS_COMMIT="bf79988adcfce166f848e4b11e718c1966365329"
SRC_URI="https://github.com/ziglibs/${PN}/archive/${KNOWN_FOLDERS_COMMIT}.tar.gz -> ${PN}-${KNOWN_FOLDERS_COMMIT}.tar.gz"
S="${WORKDIR}/${PN}-${KNOWN_FOLDERS_COMMIT}"

LICENSE="MIT"
