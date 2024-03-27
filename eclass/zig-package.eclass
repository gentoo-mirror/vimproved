# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: zig-package.eclass
# @MAINTAINER:
# Violet Purcell <vimproved@inventati.org>
# @AUTHOR:
# Violet Purcell <vimproved@inventati.org>
# @SUPPORTED_EAPIS: 8
# @BLURB: eclass for Zig source packages
# @DESCRIPTION:
# This eclass provieds functionality to automatically install Zig source
# packages into the global system cachedir. Since Zig uses hashes for cache
# paths, every Zig package is slotted according to ${PV}.

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ ! ${_ZIG_PACKAGE_ECLASS} ]]; then
_ZIG_PACKAGE_ECLASS=1

ZIG_MIN="0.12"
inherit zig

SLOT="${PV}"

zig-package_src_install() {
	local zig_pkg_hash="$("${ZIG}" fetch "${S}")" || die
	insinto /usr/src/zig/packages
	doins -r "${T}/zig-cache/p/${zig_pkg_hash}"
}

EXPORT_FUNCTIONS src_install

fi
